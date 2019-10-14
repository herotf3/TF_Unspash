//
// Created by CPU11808 on 10/9/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "ZoomAnimator.h"


@interface ZoomAnimator()

@end

@implementation ZoomAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return _isPresenting ? 1 : 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresenting)
        [self animateZoomInTransitionUsing:transitionContext];
    else
        [self animateZoomOutTransitionUsing:transitionContext];
}

- (void)animateZoomOutTransitionUsing:(id <UIViewControllerContextTransitioning>)context {
    NSLog(@"Zoom out transition.");
    UIView * container = context.containerView;
    UIView * fromView = [context viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [context viewForKey:UITransitionContextToViewKey];

    UIImageView * refFromImageView = [self.fromDelegate referenceImageView:self];
    UIImageView * refToImageView = [self.toDelegate referenceImageView:self];
    CGRect fromImvFrame = [self.fromDelegate referenceImageViewFrameInTransitionView:self];
    CGRect toImvFrame = [self.toDelegate referenceImageViewFrameInTransitionView:self];
    //snap shot the source image view need to animate
    self.transitionView = [refFromImageView snapshotViewAfterScreenUpdates:NO];

    //pre animation
    [container insertSubview:toView belowSubview:fromView];
    [refFromImageView setHidden:YES];
    [refToImageView setHidden:YES];

    self.transitionView.frame = fromImvFrame;
    [container addSubview:self.transitionView];
    // Begin animation
    [UIView animateWithDuration:[self transitionDuration:context]
            delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0
            options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.transitionView.frame = toImvFrame;
        fromView.alpha = 0;
    } completion:^(BOOL finished) {
        [self fadingTransitionView];
        [refFromImageView setHidden:NO];
        [refToImageView setHidden:NO];
        [context completeTransition: ![context transitionWasCancelled]];
    }];
}

- (void)fadingTransitionView {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.transitionView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.transitionView removeFromSuperview];
    }];
}


- (void)animateZoomInTransitionUsing:(id <UIViewControllerContextTransitioning>)context {
    NSLog(@"Zoom in transition.");
    UIView * container = context.containerView;
    UIView * toView = [context viewForKey:UITransitionContextToViewKey];

    UIImageView * refFromImageView = [self.fromDelegate referenceImageView:self];
    UIImageView * refToImageView = [self.toDelegate referenceImageView:self];
    CGRect fromImvFrame = [self.fromDelegate referenceImageViewFrameInTransitionView:self];
    CGRect toImvFrame = [self.toDelegate referenceImageViewFrameInTransitionView:self];
    // snapshot the source image view
    self.transitionView = [refFromImageView snapshotViewAfterScreenUpdates:NO];

    toView.alpha = 0;
    [container addSubview:toView];
    [refToImageView setHidden:YES];
    [refFromImageView setHidden:YES];

    self.transitionView.frame = fromImvFrame;
    [container addSubview:self.transitionView];
    // Begin animation
    [UIView animateWithDuration:[self transitionDuration:context]
                          delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self.transitionView.frame = toImvFrame;
                         toView.alpha = 1.0;

                     } completion:^(BOOL finished) {
                [self fadingTransitionView];
                //show 2 image views again
                [refToImageView setHidden:NO];
                [refFromImageView setHidden:NO];

                [context completeTransition:finished];
            }];
}

@end
