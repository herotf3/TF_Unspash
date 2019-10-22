//
// Created by CPU11808 on 10/11/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomDismissalInteractionController.h"
#import "ZoomAnimator.h"
#import "SDInternalMacros.h"

@implementation ZoomDismissalInteractionController {

}
- (void)didPanWithGesture:(UIPanGestureRecognizer *)gestureRecognizer {

    ZoomAnimator* zoomAnimator = self.animator;
    UIView * transitionView = zoomAnimator.transitionView;
    UIViewController * fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView * fromRefImageView = [zoomAnimator.fromDelegate referenceImageView:zoomAnimator];
    UIImageView * toRefImageView = [zoomAnimator.toDelegate referenceImageView:zoomAnimator];
    // Validate
    if (!(zoomAnimator && transitionView && fromVC && toVC && fromRefImageView && toRefImageView)){
        return;
    }

    // Center of src img
    CGPoint anchorPoint = CGPointMake(CGRectGetMidX(_fromRefImageViewFrame), CGRectGetMidY(_fromRefImageViewFrame));

    // The translation of img
    CGPoint translationVector = [gestureRecognizer translationInView: fromRefImageView.superview];

    CGFloat verticalDelta = 0;
    if (UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation)){
        verticalDelta = translationVector.x < 0 ? 0 : translationVector.x;
    }else {
        verticalDelta = translationVector.y < 0 ? 0 : translationVector.y;
    }

    CGFloat bgAlpha = [self backgroundAlphaForView: fromVC.view withVerticalPanDelta: verticalDelta];
    CGFloat scale = [self scaleForView: fromVC.view withVerticalPanDelta: verticalDelta];
    fromVC.view.alpha = bgAlpha;

//    transitionView.frame = [zoomAnimator.fromDelegate referenceImageViewFrameInTransitionView:zoomAnimator];
    transitionView.transform = CGAffineTransformMakeScale(scale, scale);
    CGPoint newCenter = CGPointMake(anchorPoint.x + translationVector.x, anchorPoint.y + translationVector.y);
    transitionView.center = newCenter;

    [toRefImageView setHidden:YES];
    [fromRefImageView setHidden:YES];
    [_transitionContext updateInteractiveTransition:1-scale];

    toVC.tabBarController.tabBar.alpha = 1 - bgAlpha;

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint velocity = [gestureRecognizer velocityInView:fromVC.view];
        BOOL velocityCheck = NO;

        if (UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation)){
            velocityCheck = velocity.x < 0 || newCenter.x < anchorPoint.x;
        }else{
            velocityCheck = velocity.y < 0 || newCenter.y < anchorPoint.y;
        }

        if (velocityCheck){
            // cancel
            [UIView animateWithDuration:0.25 delay:0
                 usingSpringWithDamping:0.9 initialSpringVelocity:0
                 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    transitionView.frame = self.fromRefImageViewFrame;
                    fromVC.view.alpha = 1;
                    toVC.tabBarController.tabBar.alpha = 0;
            }
            completion:^(BOOL finished) {
                [toRefImageView setHidden:NO];
                [fromRefImageView setHidden:NO];
                [transitionView removeFromSuperview];
                zoomAnimator.transitionView = nil;
                [self.transitionContext cancelInteractiveTransition];
                [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
                self.transitionContext = nil;
            }];
            return;
        }

        // start animation
        CGRect finalTransitionFrame = _toRefImageViewFrame;
        
        [UIView animateWithDuration:0.5 animations:^{
            fromVC.view.alpha = 0;
            transitionView.frame = finalTransitionFrame;
            toVC.tabBarController.tabBar.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionView removeFromSuperview];
            [toRefImageView setHidden:NO];
            [fromRefImageView setHidden:NO];
            [self.transitionContext finishInteractiveTransition];
            [self.transitionContext completeTransition: !self.transitionContext.transitionWasCancelled];
            self.transitionContext = nil;
        }];
    }
}

- (CGFloat)scaleForView:(UIView *)view withVerticalPanDelta:(CGFloat)delta {
    CGFloat startScale = 1;
    CGFloat finalScale = 0.5;
    CGFloat totalAvailableScale = startScale-finalScale;

    CGFloat maxDelta = view.bounds.size.height / 2 ;
    CGFloat percentageDelta = MIN(abs(delta) / maxDelta, 1);

    return startScale - percentageDelta * totalAvailableScale;
}

- (CGFloat)backgroundAlphaForView:(UIView *)view withVerticalPanDelta:(CGFloat)delta {
    CGFloat maxOfDelta = view.bounds.size.height / 4.0;
    CGFloat percentageDelta = MIN(abs(delta) / maxOfDelta, 1);
    return 1 - (percentageDelta);
}

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIView * containerView = transitionContext.containerView;

    ZoomAnimator* zoomAnimator = self.animator;
    UIViewController * fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView * fromRefImageView = [zoomAnimator.fromDelegate referenceImageView:zoomAnimator];
    CGRect fromRefImageViewFrame = [zoomAnimator.fromDelegate referenceImageViewFrameInTransitionView: zoomAnimator];
    CGRect toRefImageViewFrame = [zoomAnimator.toDelegate referenceImageViewFrameInTransitionView: zoomAnimator];

    if (!(zoomAnimator && fromVC && toVC && fromRefImageView)){
        return;
    }

    self.fromRefImageViewFrame = fromRefImageViewFrame;
    self.toRefImageViewFrame = toRefImageViewFrame;
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];

    zoomAnimator.transitionView = [fromRefImageView snapshotViewAfterScreenUpdates:NO];
    zoomAnimator.transitionView.frame = fromRefImageViewFrame;
    [containerView addSubview:zoomAnimator.transitionView];
}

@end
