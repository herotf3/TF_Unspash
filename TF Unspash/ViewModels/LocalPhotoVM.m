//
// Created by CPU11808 on 10/4/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import "LocalPhotoVM.h"
#import "UIImageView+WebCache.h"
#import "SDInternalMacros.h"

@interface LocalPhotoVM()
@property(nonatomic, strong) PHImageRequestOptions *options;
@property (nonatomic, assign) PHImageRequestID phImageRequestID;
@end

@implementation LocalPhotoVM {
}

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
    }

    return self;
}

+ (instancetype)vmWithAsset:(PHAsset *)asset {
    return [[self alloc] initWithAsset:asset];
}

+ (NSCache<NSString *, UIImage *> *)imagesCache {
    static NSCache<NSString *, UIImage *> * imagesCache = nil;
    if (!imagesCache){
        imagesCache = [[NSCache alloc] init];
//        imagesCache.countLimit = 20;
    }
    return imagesCache;
}


#pragma mark - Overriding Methods

- (UIImage *)iconForType {
    static UIImage * iconDevice;
    if (!iconDevice){
        iconDevice = [UIImage imageNamed:@"smartphone"];
    }
    return iconDevice;
}

- (void)setImageIntoImageView:(UIImageView *)imageView {

    UIImage *image = [LocalPhotoVM.imagesCache objectForKey: self.asset.localIdentifier];
    if (image){
        imageView.image = image;
        return;
    }

    self.photoCell.localAssetID = _asset.localIdentifier;
    CGSize size = CGSizeMake(self.asset.pixelWidth* self.scale, self.asset.pixelHeight* self.scale);
    // Cache missed, request image for asset
    @weakify(self);
    self.phImageRequestID = [PHImageManager.defaultManager requestImageForAsset:self.asset targetSize:size contentMode:PHImageContentModeDefault
                                                options:self.options resultHandler:^(UIImage *image, NSDictionary *info)
    {
        @strongify(self);
        if ([self.photoCell.localAssetID isEqualToString:self.asset.localIdentifier] && image){
            [self.photoCell setImage: image];
            // Cache
            [LocalPhotoVM.imagesCache setObject:image forKey:self.asset.localIdentifier];
        }
    }];

}

- (CGFloat)scale {
    return 0.5;
}

- (void)prepareForReuse {
    [PHImageManager.defaultManager cancelImageRequest: self.phImageRequestID];
}

- (CGSize)photoSize {
    return CGSizeMake(self.asset.pixelWidth, self.asset.pixelHeight);
}

    - (PHImageRequestOptions *)options {
    if (!_options){
        _options = [PHImageRequestOptions new];
    }
    return _options;
}


@end