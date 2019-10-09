//
// Created by CPU11808 on 10/9/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZoomAnimator;

@protocol ZoomAnimatorDelegate  <NSObject>
@required
-(CGRect) referenceImageViewFrameInTransitionView:(ZoomAnimator*)animator;
-(UIImageView*) referenceImageView:(ZoomAnimator *)animator;
@end

@interface ZoomAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic, nullable) id<ZoomAnimatorDelegate> fromDelegate;
@property (weak, nonatomic, nullable) id<ZoomAnimatorDelegate> toDelegate;
@property (strong, nonatomic, nonnull) UIImageView *transitionImv;
@property (assign, nonatomic) BOOL isPresenting;

@end