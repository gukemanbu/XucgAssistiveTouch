//
//  XucgAssistiveTouch.h
//  XucgAssistiveTouch
//
//  Created by xucg on 10/11/16.
//  Copyright © 2016 xucg. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSelfWidth    self.frame.size.width
#define kSelfHeight   self.frame.size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@protocol XucgAssistiveTouchDelegate <NSObject>

- (void)xucgAssistiveTouchAction:(UIButton*)sender;

@end

@interface XucgAssistiveTouch : UIWindow

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, weak) id<XucgAssistiveTouchDelegate> delegate;

@end
