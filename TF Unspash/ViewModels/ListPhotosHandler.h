//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListPhotosViewController;


@interface ListPhotosHandler : NSObject

@property (nonatomic, weak) ListPhotosViewController* viewController;

- (instancetype)initWithViewController:(ListPhotosViewController *)viewController;

- (void)fetchData;

+ (instancetype)vmWithViewController:(ListPhotosViewController *)viewController;

@end
