//
// Created by CPU11808 on 10/7/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "CustomAnimatedTransitioning.h"

@interface CustomAnimatedTransitioning()

@end

@implementation CustomAnimatedTransitioning {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initProperties];
    }

    return self;
}

- (void)initProperties {
    self.duration = 0.4;
    self.presenting = YES;
    self.originFrame = CGRectZero;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView * containerView = transitionContext.containerView;
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * animatedView = _presenting? toView : fromView;

    CGRect initialFrame = _presenting? self.originFrame : animatedView.frame;
    CGRect fullScreenFrame = UIApplication.sharedApplication.keyWindow.frame;
    if (_presenting) {
        toView.frame = fullScreenFrame;
    }
    CGRect finalFrame = _presenting? toView.frame : self.originFrame;

    CGFloat xScaleFactor, yScaleFactor;
    if (_presenting){
        xScaleFactor = initialFrame.size.width / finalFrame.size.width;
        yScaleFactor = initialFrame.size.height / finalFrame.size.height;
    }else{
        xScaleFactor = finalFrame.size.width / initialFrame.size.width ;
        yScaleFactor = finalFrame.size.height / initialFrame.size.height ;
    }

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    if (_presenting){
        animatedView.transform = scaleTransform;
        animatedView.center = CGPointMake(CGRectGetMidX(initialFrame), CGRectGetMidY(initialFrame));
        animatedView.clipsToBounds = YES;
    }

    [containerView addSubview:toView];
    [containerView bringSubviewToFront:animatedView];
    animatedView.layer.opacity = 0.0;
    [UIView animateWithDuration:self.duration animations:^{
        animatedView.transform = _presenting? CGAffineTransformIdentity : scaleTransform;
        animatedView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
        animatedView.layer.opacity = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}



@end