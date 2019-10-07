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

@property (nonatomic, strong) BasePhotoVM* photoVM;

@end

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:UIColor.lightGrayColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.imageView sd_cancelCurrentImageLoad];
    self.imageView.image = nil;
    self.iconTypeImv.image = nil;
}

- (void)bindWithPhotoVM:(BasePhotoVM *)viewModel {
    if (viewModel==NULL){
        NSLog(@"photo view model is null !");
        return;
    }

//    [self.imageView sd_setImageWithURL:[viewModel photoURLForDisplayInThumb] placeholderImage:nil];
    [viewModel setImageIntoImageView:self.imageView];
    self.iconTypeImv.image = [viewModel iconForType];
}

//- (void)bindWithPHAsset:(PHAsset*)asset {
//    self.representedAssetIdentifier = asset.localIdentifier;
//    self.iconTypeImv.image = [UIImage imageNamed:@"smartphone"];
//
//    PHImageRequestOptions * options = [PHImageRequestOptions new];
////    [options setSynchronous:NO];
////    [PHImageManager.defaultManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options
////                                          resultHandler:^(UIImage *image, NSDictionary *info)
////    {
////        if (image && [asset.localIdentifier isEqualToString:self.representedAssetIdentifier] ){
////            self.imageView.image = image;
////        }
////    }];
//
//    [asset requestContentEditingInputWithOptions:[PHContentEditingInputRequestOptions new]
//                               completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info)
//    {
//        if (contentEditingInput){
//            NSURL * URL = contentEditingInput.fullSizeImageURL;
//            [self.imageView sd_setImageWithURL:URL];
//        }
//    }];
//
//    [PHImageManager.defaultManager requestImageDataForAsset:asset options:options
//                                              resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info)
//    {
//        NSLog(@"image asset data info%@",info);
//        NSLog(@"info url: %@", info[@"PHImageFileDataKey"]);
//    }];
//}

@end
