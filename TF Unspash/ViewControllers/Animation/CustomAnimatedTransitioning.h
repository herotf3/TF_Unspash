//
// Created by CPU11808 on 10/7/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CustomAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) float duration;
@property (nonatomic, assign) BOOL presenting;
@property  (nonatomic, assign) CGRect originFrame;

@end