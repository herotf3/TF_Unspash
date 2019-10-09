//
// Created by CPU11808 on 10/9/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "ZoomTransitionController.h"
#import "ZoomTransitioningAnimator.h"

@interface ZoomTransitionController() <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation ZoomTransitionController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.animator = [ZoomAnimator new];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    [self setupAnimatorForPresent:YES];
    return self.animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    [self setupAnimatorForPresent:NO];
    return self.animator;
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVc toViewController:(UIViewController *)toVc {
    if (operation == UINavigationControllerOperationPush){
        [self setupAnimatorForPresent:YES];

    }else{
//        [self setupAnimatorForPresent:NO];
        return nil;
    }
    return self.animator;
}

#pragma mark - Functions

- (void)setupAnimatorForPresent:(BOOL)isPresenting {
    if (isPresenting){
        self.animator.isPresenting = YES;
        self.animator.fromDelegate = _fromDelegate;
        self.animator.toDelegate = _toDelegate;
    } else{
        self.animator.isPresenting = NO;
        id temp = self.fromDelegate;
        self.animator.fromDelegate = self.toDelegate;
        self.animator.toDelegate = temp;
    }
}


@end