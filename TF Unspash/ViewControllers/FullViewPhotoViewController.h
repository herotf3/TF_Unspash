//
//  FullViewPhotoViewController.h
//  TF Unspash
//
//  Created by CPU11808 on 10/7/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomAnimator.h"

@class USPhotoVM;
@class ZoomTransitionController;

NS_ASSUME_NONNULL_BEGIN

@interface FullViewPhotoViewController : UIViewController <ZoomAnimatorDelegate>

@property(nonatomic, strong) USPhotoVM *photoVM;

@property(nonatomic, strong) ZoomTransitionController * transitionController;

- (instancetype)initWithFrame:(CGRect)rect viewModel:(USPhotoVM *)model;
@end

NS_ASSUME_NONNULL_END
