//
//  LYFStatusBarHUD.m
//  状态栏指示器-HUD
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LYFStatusBarHUD.h"

#define LYFMessageFont [UIFont systemFontOfSize:12]

/** 消息停留时间 */
static CGFloat const LYFMessageDuration = 2.0;
/** 消息显示/隐藏动画时间 */
static CGFloat const LYFAnimationDuration = 0.5;

@implementation LYFStatusBarHUD

/** 全局窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;

/**  
 *  显示窗口
 */
+ (void)showWindow
{
    
    //frame数据
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, windowH);
    
    //显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc]init];
    window_.backgroundColor = [UIColor blackColor];
    window_.frame = frame;
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    //动画
    frame.origin.y = 0;
    [UIView animateWithDuration:LYFAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 *  显示普通信息
 *  @param msg      文字
 *  @param image    图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    //停止定时器
    [timer_ invalidate];
    
    //显示窗口
    [self showWindow];
    
    //添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = LYFMessageFont;
    if (image) {//如果有图片
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    button.frame = window_.frame;
    [window_ addSubview:button];
    
    //定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:LYFMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 *  显示普通信息
 */
+ (void)showMessage:(NSString *)msg
{
    [self showMessage:msg image:nil];
}

/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"LYFStatusBarHUD.bundle/success"]];
    
}


/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"LYFStatusBarHUD.bundle/error"]];
}


/**
 *  显示正在处理信息
 */
+ (void)showLoading:(NSString *)msg
{
    //停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    //显示窗口
    [self showWindow];
    
    //添加文字
    UILabel *label = [[UILabel alloc]init];
    label.frame = window_.frame;
    label.font = LYFMessageFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    //添加圆圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName:LYFMessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/**
 *  隐藏
 */
+ (void)hide
{
    [UIView animateWithDuration:LYFAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = -frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}

@end
