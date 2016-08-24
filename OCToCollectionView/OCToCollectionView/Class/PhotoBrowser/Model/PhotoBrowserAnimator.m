//
//  PhotoBrowserAnimator.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "PhotoBrowserAnimator.h"

@interface PhotoBrowserAnimator ()<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

/**  <#名称#> */
@property (nonatomic,assign)BOOL isPresented;

@end

@implementation PhotoBrowserAnimator

#pragma mark - UIViewControllerTransitioningDelegate
/*********************   转场动画代理方法      *************************/
// 告诉弹出动画交给谁去处理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresented = YES;
    return self;
}

/// 该代理方法用于告诉系统谁来负责控制器如何弹出
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresented = NO;
    return self;
}


#pragma mark - 转场的动画
// 动画执行时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresented) {
        // 1.获取弹出的View
        UIView * presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        // 2.将弹出的控制器的View添加到控制器上面
        [[transitionContext containerView] addSubview:presentedView];
        
        // 3.执行动画alpha
        presentedView.alpha = 0.0;
        // 动画执行时长
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            
            // 设置alpha为1.0
            presentedView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
        
    }else
    {
        // 1.获取取消的View
        UIView * dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        // 2.执行动画的
        NSTimeInterval duretion = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:duretion animations:^{
            dismissView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            [dismissView removeFromSuperview];
            [transitionContext completeTransition:YES];
            
        }];
    }
    
}

@end
