//
//  FullViewPhotoViewController.h
//  TF Unspash
//
//  Created by CPU11808 on 10/7/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>

@class USPhotoVM;

NS_ASSUME_NONNULL_BEGIN

@interface FullViewPhotoViewController : UIViewController

@property(nonatomic, strong) USPhotoVM *photoVM;

- (instancetype)initWithFrame:(CGRect)rect viewModel:(USPhotoVM *)model;
@end

NS_ASSUME_NONNULL_END
