//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>

@class USPhoto;


@interface USPhotoVM : NSObject
@property (nonatomic, strong) USPhoto* photo;

- (instancetype)initWithPhoto:(USPhoto *)photo;
+ (instancetype)photoVMWithPhoto:(USPhoto *)photo;

// Presentation methods
-(NSURL *) URLForDisplayInThumb;
- (CGSize)photoSizeForColectionView;
@end