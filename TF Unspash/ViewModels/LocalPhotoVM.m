//
// Created by CPU11808 on 10/4/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import "LocalPhotoVM.h"
#import "UIImageView+WebCache.h"

@interface LocalPhotoVM()
@property(nonatomic, strong) PHImageRequestOptions *options;

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

    // Cache miss
    [PHImageManager.defaultManager requestImageForAsset:self.asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault
                                                options:self.options resultHandler:^(UIImage *image, NSDictionary *info)
    {
        if (image){
            imageView.image = image;
            [LocalPhotoVM.imagesCache setObject:image forKey:self.asset.localIdentifier];
        }

    }];

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