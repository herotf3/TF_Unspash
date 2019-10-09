//
// Created by CPU11808 on 10/9/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomTransitioningAnimator.h"


@interface ZoomTransitionController : NSObject <UINavigationControllerDelegate>

@property (strong, nonatomic) ZoomAnimator * animator;
@property (weak, nonatomic) id<ZoomAnimatorDelegate>  fromDelegate;
@property (weak, nonatomic) id<ZoomAnimatorDelegate>  toDelegate;

@end