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

@interface PhotoCollectionViewCell()
@property (nonatomic, copy) NSString* representedAssetIdentifier;
@property (nonatomic, strong) UIImage* iconInDevice;

@end

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindWithPhotoVM:(USPhotoVM *)presenter {
    if (presenter==NULL){
        NSLog(@"photo item null!!!!");
    }

    [self.imageView sd_setImageWithURL:[presenter URLForDisplayInThumb] placeholderImage:nil];

    [self setBackgroundColor:UIColor.lightGrayColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView sd_cancelCurrentImageLoad];
    self.imageView.image = nil;
    self.iconTypeImv.image = nil;
}


- (void)bindWithPHAsset:(PHAsset*)asset {
    self.representedAssetIdentifier = asset.localIdentifier;
    self.iconTypeImv.image = [UIImage imageNamed:@"smartphone"];
    
    PHImageRequestOptions * options = [PHImageRequestOptions new];
    [options setSynchronous:NO];
    [PHImageManager.defaultManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options
                                          resultHandler:^(UIImage *image, NSDictionary *info)
    {
        if (image && [asset.localIdentifier isEqualToString:self.representedAssetIdentifier] ){
            self.imageView.image = image;
        }

    }];


}

- (UIImage *)iconInDevice{
    if (_iconInDevice==NULL){
        _iconInDevice = [UIImage imageNamed:@"smartphone"];
    }
    return _iconInDevice;
}

@end
