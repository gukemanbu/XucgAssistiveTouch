//
//  RootViewController.m
//  XucgAssistiveTouch
//
//  Created by xucg on 10/11/16.
//  Copyright © 2016 xucg. All rights reserved.
//

#import "RootViewController.h"
#import "TabViewController1.h"
#import "XucgAssistiveTouch/XucgAssistiveTouch.h"

@interface RootViewController ()

@property (nonatomic, strong) XucgAssistiveTouch *xucgAssistiveTouch;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // tab1
    TabViewController1 *controller1 = [[TabViewController1 alloc] init];
    controller1.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:controller1];
    controller1.tabBarItem.tag = 1;
    controller1.tabBarItem.title = @"111";
    
    // tab2
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:controller2];
    controller2.tabBarItem.tag = 2;
    controller2.tabBarItem.title = @"222";
    
    // tab3
    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = [UIColor cyanColor];
    [self addChildViewController:controller3];
    controller3.tabBarItem.tag = 3;
    controller3.tabBarItem.title = @"333";
    
    UIImage *image = [UIImage imageNamed:@"xucg-iphone"];
    CGFloat tmpX = kScreenWidth - image.size.width - 10;
    CGFloat tmpY = kScreenHeight - image.size.height - 49 - 10;
    _xucgAssistiveTouch = [[XucgAssistiveTouch alloc] initWithFrame:CGRectMake(tmpX, tmpY, image.size.width, image.size.height)];
    _xucgAssistiveTouch.normalImage = image;
    _xucgAssistiveTouch.highlightedImage = image;
    _xucgAssistiveTouch.selectedImage = image;
    _xucgAssistiveTouch.delegate = (id<XucgAssistiveTouchDelegate>)self;
}

- (void)xucgAssistiveTouchAction:(UIButton*)sender {
    NSLog(@"aaaaaaaaaa");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
