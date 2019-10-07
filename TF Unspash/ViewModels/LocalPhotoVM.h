//
// Created by CPU11808 on 10/4/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePhotoVM.h"

@class PHAsset;


@interface LocalPhotoVM : BasePhotoVM

@property (nonatomic,strong) PHAsset * asset;

- (instancetype)initWithAsset:(PHAsset *)asset;

+ (instancetype)vmWithAsset:(PHAsset *)asset;

+(NSCache<NSString*,UIImage*>*) imagesCache;


@end