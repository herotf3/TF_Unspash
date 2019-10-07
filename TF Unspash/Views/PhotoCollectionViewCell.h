//
//  PhotoCollectionViewCell.h
//  TF Unspash
//
//  Created by CPU11808 on 9/30/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USPhotoVM.h"

@class BasePhotoVM;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconTypeImv;

- (void)bindWithPhotoVM:(BasePhotoVM *)photoVM;

@end

NS_ASSUME_NONNULL_END
