//
//  PhotoDetailViewController.h
//  TF Unspash
//
//  Created by CPU11808 on 10/2/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USPhotoVM;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetailViewController : UIViewController

@property (nonatomic, strong) USPhotoVM* photoVM;

@end

NS_ASSUME_NONNULL_END
