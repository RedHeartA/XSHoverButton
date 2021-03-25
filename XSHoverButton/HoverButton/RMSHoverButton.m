//
//  RMSHoverButton.m
//  Salesmate for Romens
//
//  Created by Mr.X on 2020/3/2.
//  Copyright © 2020 Romens. All rights reserved.
//
    

#import "RMSHoverButton.h"

static CGFloat const kHoverButtonSize   = 55.0;
static CGFloat const kHoverButtonInsets = 15.0;

@interface RMSHoverButton ()
{
    // 拖动按钮的起始坐标点
    CGPoint _touchPoint;
    
    // 起始按钮 x, y 值
    CGFloat _touchBtnX;
    CGFloat _touchBtnY;
}

//@property (nonatomic, assign) CGRect moveFrame;

@end

@implementation RMSHoverButton

- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
                withImageName:(NSString *)imageName {
    frame.size.width  = kHoverButtonSize;
    frame.size.height = kHoverButtonSize;
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor cyanColor];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        if (imageName != nil) {
            self.titleLabel.font = [UIFont systemFontOfSize:11];
            [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        } else {
            self.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        
        self.layer.cornerRadius = kHoverButtonSize * 0.5;
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 1.6f;   // 阴影透明度
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0); // 阴影的范围
        self.layer.shadowRadius = 4.0;
        
        [self addTarget:self action:@selector(p_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.width * 0.5;

    if (self.imageView.image) {
        // Center image
        CGPoint center = self.imageView.center;
        center.x = self.frame.size.width / 2;
        center.y = self.imageView.frame.size.height / 2 + 5;
        self.imageView.center = center;
        
        //Center text
        CGRect newFrame = [self titleLabel].frame;
        newFrame.origin.x = 0;
        newFrame.origin.y = self.imageView.frame.size.height + 5;
        newFrame.size.width = self.frame.size.width;
        
        self.titleLabel.frame = newFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)dismissHoverBtn {
    [self removeFromSuperview];
}

- (void)p_clickBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hoverButtonClickEvent)]) {
        [self.delegate hoverButtonClickEvent];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    // 按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    _touchBtnX = self.frame.origin.x;
    _touchBtnY = self.frame.origin.y;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    // 偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    
    // 移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnX = self.frame.origin.x;
    
    CGFloat minDistance = 2;
    
    // 结束move的时候，计算移动的距离是>最低要求，如果没有，就调用按钮点击事件
    BOOL isOverX = fabs(btnX - _touchBtnX) > minDistance;
    BOOL isOverY = fabs(btnY - _touchBtnY) > minDistance;
    
    if (isOverX || isOverY) {
        // 超过移动范围就不响应点击 - 只做移动操作
        [self touchesCancelled:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
    
    [self keepToTheSide:YES];
}


- (void)setMoveFrame:(CGRect)moveFrame {
    if (CGRectGetWidth(_moveFrame) < 0.1) {
        // 第一次设置 范围时，设定默认位置
        self.frame = [self defatultFrameThatFits:moveFrame];
    }
    _moveFrame = moveFrame;
    [self keepToTheSide:(self.superview != nil)];
}

- (CGRect)defatultFrameThatFits:(CGRect)moveFrame {
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetMaxX(moveFrame);
    frame.origin.y = CGRectGetMaxY(moveFrame) - 100;
    return frame;
}

// 自动贴边
- (void)keepToTheSide:(BOOL)animated {
    CGRect frame = self.frame;
    frame.origin = [self originThatFits:frame.origin];
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = frame;
        }];
    } else {
        self.frame = frame;
    }
}

- (CGPoint)originThatFits:(CGPoint)point {
    CGFloat x = point.x;
    CGFloat y = point.y;
    CGFloat width = CGRectGetWidth(self.frame); // kHoverButtonSize
    
    // 1.自动贴边：按钮越中线，则贴近右侧，否则贴近左侧。
    if ((x + width) > CGRectGetMidX(self.moveFrame)) {
        x = CGRectGetMaxX(self.moveFrame) - kHoverButtonInsets - width;
    } else {
        x = kHoverButtonInsets;
    }
    
    // 2.调整 y
    CGFloat miny = CGRectGetMinY(self.moveFrame) + kHoverButtonInsets;
    CGFloat maxy = CGRectGetMaxY(self.moveFrame) - kHoverButtonInsets - width;
    y = (y < miny) ? miny : y;
    y = (y > maxy) ? maxy : y;
    
    return CGPointMake(x, y);
}

@end
