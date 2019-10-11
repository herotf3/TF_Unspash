//
// Created by CPU11808 on 10/11/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZoomDismissalInteractionController : NSObject<UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animator;

@property (nonatomic, assign) CGRect fromRefImageViewFrame;
@property (nonatomic, assign) CGRect toRefImageViewFrame;

-(void) didPanWithGesture:(UIPanGestureRecognizer *) gestureRecognizer;

@end