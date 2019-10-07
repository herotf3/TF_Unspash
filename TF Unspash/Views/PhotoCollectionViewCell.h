//
//  PhotoCollectionViewCell.h
//  TF Unspash
//
//  Created by CPU11808 on 9/30/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BasePhotoVM;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconTypeImv;

@property(nonatomic, copy) NSString *localAssetID;

- (void)bindWithPhotoVM:(BasePhotoVM *)photoVM;

- (void)setImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
