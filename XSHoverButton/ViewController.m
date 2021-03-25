//
//  ViewController.m
//  XSHoverButton
//
//  Created by Mr.X on 2021/3/25.
//

#import "ViewController.h"
#import "HoverButton/RMSHoverButton.h"

@interface ViewController () <RMSHoverButtonDelegate>

///
@property (nonatomic, strong) RMSHoverButton *hoverButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.hoverButton = [[RMSHoverButton alloc] initWithFrame:CGRectMake(10, 100, 55, 55) withTitle:@"+" withImageName:@"chinesekKnot"];
    self.hoverButton.moveFrame = [self getHoverButtonMoveFrame];
    self.hoverButton.delegate = self;
    [self.view addSubview:self.hoverButton];
    [self.view bringSubviewToFront:self.hoverButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.hoverButton.moveFrame = [self getHoverButtonMoveFrame];
    }
}

// 悬浮按钮可移动区域
- (CGRect)getHoverButtonMoveFrame {
    CGFloat screenWidth = 0;
    CGFloat navBarWidth = self.navigationController.view.frame.size.width;
    if (navBarWidth > 0) {
        screenWidth = self.navigationController.view.frame.size.width;
    } else {
        screenWidth = self.view.frame.size.width;
    }
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
    CGRect moveFrame = CGRectMake(0, navBarHeight, screenWidth, screenHeight - navBarHeight - tabBarHeight);
    return moveFrame;
}

//// 悬浮按钮可移动区域
//- (CGRect)getHoverButtonMoveFrame {
//
//    CGFloat navBarHeight = 0;
//    if (@available(iOS 13.0, *)) {
//        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows[0].windowScene.statusBarManager;
//        navBarHeight = self.navigationController.navigationBar.frame.size.height + statusBarManager.statusBarFrame.size.height;
//    } else {
//        navBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
//    }
//    CGFloat screenWidth = self.navigationController.view.frame.size.width;
//    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//
//    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
//    CGRect moveFrame = CGRectMake(0, 0, screenWidth, screenHeight - navBarHeight - tabBarHeight);
//    return moveFrame;
//}


///< 悬浮按钮点击事件
- (void)hoverButtonClickEvent {
    NSLog(@"----hoverButton click---");
}

@end
