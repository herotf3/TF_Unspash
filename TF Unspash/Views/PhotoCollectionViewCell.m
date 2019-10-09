//
//  PhotoCollectionViewCell.m
//  TF Unspash
//
//  Created by CPU11808 on 9/30/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <SDWebImage/SDAnimatedImageView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import "PhotoCollectionViewCell.h"
#import "UIView+WebCache.h"
#import "BasePhotoVM.h"

@interface PhotoCollectionViewCell()

@property (nonatomic, weak) BasePhotoVM* photoVM;

@end

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:UIColor.lightGrayColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.photoVM prepareForReuse];

    [self.imageView sd_cancelCurrentImageLoad];
    self.imageView.image = nil;
    self.iconTypeImv.image = nil;
}

- (void)bindWithPhotoVM:(BasePhotoVM *)viewModel {
    if (viewModel==NULL){
        NSLog(@"photo view model is null !");
        return;
    }
    self.photoVM = viewModel;
    viewModel.photoCell = self;

    [viewModel setImageIntoImageView];
    self.iconTypeImv.image = [viewModel iconForType];
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

@end
