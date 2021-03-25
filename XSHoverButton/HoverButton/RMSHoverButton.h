//
//  RMSHoverButton.h
//  Salesmate for Romens
//
//  Created by Mr.X on 2020/3/2.
//  Copyright © 2020 Romens. All rights reserved.
//
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RMSHoverButtonDelegate <NSObject>

///< 悬浮按钮点击事件
- (void)hoverButtonClickEvent;

@end

@interface RMSHoverButton : UIButton

/**
 悬浮按钮

 @param frame       按钮在父视图上的位置
 @param title       按钮title
 @param imageName   按钮imageName
 @return 悬浮按钮
 */
- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
                withImageName:(NSString *)imageName;
@property (nonatomic, weak) id<RMSHoverButtonDelegate> delegate;    ///< 悬浮按钮代理

///< 悬浮按钮移动范围 (设置 CGRectZero 则无法移动)
@property (nonatomic, assign) CGRect moveFrame;

@end

NS_ASSUME_NONNULL_END
