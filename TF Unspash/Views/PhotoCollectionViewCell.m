//
//  PhotoCollectionViewCell.m
//  TF Unspash
//
//  Created by CPU11808 on 9/30/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <SDWebImage/SDAnimatedImageView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindDataWith:(USPhotoVM *)presenter {
    [self.imageView sd_setImageWithURL:[presenter URLForDisplayInThumb] placeholderImage:nil];
    [self setBackgroundColor:UIColor.lightGrayColor];
}


@end
