//
//  XimCircleAnimator.m
//  CAShapeLayer_transition
//
//  Created by ximdefangzh on 16/10/24.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "XimCircleAnimator.h"

@interface XimCircleAnimator()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@end

@implementation XimCircleAnimator{
    BOOL _isPresent;
    __weak id _transitionContext;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _isPresent = NO;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresent = YES;
    return self;
}


#pragma mark -UIViewControllerInteractiveTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 2.0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
     _transitionContext = transitionContext;
    
    UIView *view = _isPresent ? toView : fromView;
    
    if(_isPresent){
        [containerView addSubview:view];
    }
     [self animationView:view];
    
//    [transitionContext completeTransition:YES];
    
   
}

-(void)animationView:(UIView *)view{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGFloat radious = 50;
    CGFloat margin = 20;
    
    CGFloat viewWidth = view.bounds.size.width;
    CGFloat viewHeight = view.bounds.size.height;
    
    CGRect rect = CGRectMake(viewWidth - margin - radious, margin, radious, radious);
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    layer.path = beginPath.CGPath;
    
    view.layer.mask = layer;
    
    
    //利用勾股定理获取对角线长度
    CGFloat maxRadious = sqrt(viewWidth * viewWidth + viewHeight *viewHeight);
    
    CGRect endRect = CGRectInset(rect, -maxRadious, -maxRadious);
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    
    if(_isPresent){
        anim.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(endPath.CGPath);
    }
    else{
        anim.fromValue = (__bridge id _Nullable)(endPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(beginPath.CGPath);
    }
    anim.duration = [self transitionDuration:_transitionContext];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    anim.delegate = self;
    
    [layer addAnimation:anim forKey:nil];
}

#pragma mark -CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:YES];
}

@end
