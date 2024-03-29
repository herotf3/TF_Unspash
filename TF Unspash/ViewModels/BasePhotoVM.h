//
// Created by CPU11808 on 10/4/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoCollectionViewCell.h"

@class UIImage;



@interface BasePhotoVM : NSObject

@property (nonatomic, weak) PhotoCollectionViewCell* photoCell;

-(UIImage *) iconForType;


- (void)setImageIntoImageView;
- (void)prepareForReuse;
- (CGSize)photoSize;
@end