//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePhotoVM.h"

@class USPhoto;


@interface USPhotoVM : BasePhotoVM
@property(nonatomic, strong) USPhoto *photo;

- (instancetype)initWithPhoto:(USPhoto *)photo;

+ (instancetype)photoVMWithPhoto:(USPhoto *)photo;

- (NSURL *)photoURLForDisplayInLarge;

- (UIImage *)placeHolderImage;

- (NSString *)totalLike;

- (NSString *)userName;

- (NSURL *)userAvatar;

- (NSString *)instagramUsername;

- (NSString *)createDateText;

- (NSString *)totalLikeOfUser;

- (NSString *)totalUserPhoto;

- (UIImage *)photoPlaceHolder;
@end