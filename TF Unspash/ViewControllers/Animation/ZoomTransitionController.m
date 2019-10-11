//
// Created by CPU11808 on 10/9/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "ZoomTransitionController.h"
#import "ZoomAnimator.h"
#import "ZoomDismissalInteractionController.h"

@interface ZoomTransitionController() <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation ZoomTransitionController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.animator = [ZoomAnimator new];
        self.interactionController = [ZoomDismissalInteractionController new];
        self.isInteractive = NO;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    [self setupAnimatorForPresent];
    return self.animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    [self setupAnimationForPop];
    return self.animator;
}

// interaction
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (self.isInteractive){
        self.interactionController.animator = animator;
        return self.interactionController;
    }
    return nil;
}


#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVc toViewController:(UIViewController *)toVc {
    if (operation == UINavigationControllerOperationPush){
        [self setupAnimatorForPresent];
    }else{
        [self setupAnimationForPop];
    }
    return self.animator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    if (self.isInteractive){
        self.interactionController.animator = self.animator;
        return self.interactionController;
    }
    return nil;
}


#pragma mark - Functions

- (void)setupAnimatorForPresent {
    self.animator.isPresenting = YES;
    self.animator.fromDelegate = _fromDelegate;
    self.animator.toDelegate = _toDelegate;
}

-(void)setupAnimationForPop{
    self.animator.isPresenting = NO;
    id temp = self.fromDelegate;
    self.animator.fromDelegate = self.toDelegate;
    self.animator.toDelegate = temp;
}

#pragma mark - Handle Interaction with pan gesture

- (void)didPanWithGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    // Pass to interaction controller to handle
    [self.interactionController didPanWithGesture:gestureRecognizer];
}


@end
