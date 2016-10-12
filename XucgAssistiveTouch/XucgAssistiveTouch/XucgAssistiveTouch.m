//
//  XucgAssistiveTouch.m
//  XucgAssistiveTouch
//
//  Created by xucg on 10/11/16.
//  Copyright © 2016 xucg. All rights reserved.
//

#import "XucgAssistiveTouch.h"

#define animateDuration       0.3    // 位置改变动画时间
#define statusChangeDuration  3.0    // 状态改变时间

@interface XucgAssistiveTouch ()

@property (nonatomic, strong) UIButton               *mainButton;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation XucgAssistiveTouch

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.windowLevel = UIWindowLevelAlert + 1;
        self.backgroundColor = [UIColor clearColor];
        self.rootViewController = [[UIViewController alloc] init];
        [self makeKeyAndVisible];
        
        _mainButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_mainButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mainButton];
        
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delaysTouchesBegan = NO;
        [self addGestureRecognizer:_panGesture];
    }
    
    return self;
}

// 拖动事件
- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture {
    CGPoint panPoint = [panGesture locationInView:[UIApplication sharedApplication].windows[0]];
    if(panGesture.state == UIGestureRecognizerStateBegan) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(correctLocation) object:nil];
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self performSelector:@selector(correctLocation) withObject:nil afterDelay:statusChangeDuration];
        
        if(panPoint.x <= kScreenWidth/2) {
            if(panPoint.y <= 40+kSelfHeight/2 && panPoint.x >= 20+kSelfWidth/2) {
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(panPoint.x, kSelfHeight/2);
                }];
            } else if (panPoint.y >= kScreenHeight-kSelfHeight/2-40 && panPoint.x >= 20+kSelfWidth/2) {
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-kSelfHeight/2);
                }];
            } else if (panPoint.x < kSelfWidth/2+20 && panPoint.y > kScreenHeight-kSelfHeight/2) {
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(kSelfWidth/2, kScreenHeight-kSelfHeight/2);
                }];
            } else {
                CGFloat pointy = panPoint.y < kSelfHeight/2 ? kSelfHeight/2 :panPoint.y;
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(kSelfWidth/2, pointy);
                }];
            }
        } else if(panPoint.x > kScreenWidth/2) {
            if(panPoint.y <= 40+kSelfHeight/2 && panPoint.x < kScreenWidth-kSelfWidth/2-20 ) {
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(panPoint.x, kSelfHeight/2);
                }];
            } else if(panPoint.y >= kScreenHeight-40-kSelfHeight/2 && panPoint.x < kScreenWidth-kSelfWidth/2-20) {
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-kSelfHeight/2);
                }];
            } else if (panPoint.x > kScreenWidth-kSelfWidth/2-20 && panPoint.y < kSelfHeight/2) {
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(kScreenWidth-kSelfWidth/2, kSelfHeight/2);
                }];
            } else {
                CGFloat pointy = panPoint.y > kScreenHeight-kSelfHeight/2 ? kScreenHeight-kSelfHeight/2 :panPoint.y;
                [UIView animateWithDuration:animateDuration animations:^{
                    self.center = CGPointMake(kScreenWidth-kSelfWidth/2, pointy);
                }];
            }
        }
    }
}

// 修正位置，使其只露出半边
- (void)correctLocation {
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat x = self.center.x < 20+kSelfWidth/2 ? 0 :  self.center.x > kScreenWidth - 20 -kSelfWidth/2 ? kScreenWidth : self.center.x;
        CGFloat y = self.center.y < 40 + kSelfHeight/2 ? 0 : self.center.y > kScreenHeight - 40 - kSelfHeight/2 ? kScreenHeight : self.center.y;
        
        // 禁止停留在4个角
        if((x == 0 && y ==0) || (x == kScreenWidth && y == 0) || (x == 0 && y == kScreenHeight) || (x == kScreenWidth && y == kScreenHeight)){
            y = self.center.y;
        }
        self.center = CGPointMake(x, y);
    }];
}

- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    [_mainButton setImage:normalImage forState:UIControlStateNormal];
}

- (void)setHighlightedImage:(UIImage *)highlightedImage {
    _highlightedImage = highlightedImage;
    [_mainButton setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    [_mainButton setImage:selectedImage forState:UIControlStateSelected];
}

- (void)mainButtonAction:(UIButton*)sender {
    [_delegate xucgAssistiveTouchAction:sender];
}

@end
