//
// Created by CPU11808 on 10/9/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomAnimator.h"

@class ZoomDismissalInteractionController;


@interface ZoomTransitionController : NSObject <UINavigationControllerDelegate>

@property (strong, nonatomic) ZoomAnimator * animator;
@property (strong, nonatomic) ZoomDismissalInteractionController * interactionController;
@property (assign, nonatomic) BOOL isInteractive;
@property (weak, nonatomic) id<ZoomAnimatorDelegate>  fromDelegate;
@property (weak, nonatomic) id<ZoomAnimatorDelegate>  toDelegate;

-(void)didPanWithGesture:(UIPanGestureRecognizer *) gestureRecognizer;
@end