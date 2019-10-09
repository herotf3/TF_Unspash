//
//  PhotoDetailViewController.h
//  TF Unspash
//
//  Created by CPU11808 on 10/2/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomTransitioningAnimator.h"

@class USPhotoVM;
@class ZoomTransitionController;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetailViewController : UIViewController <ZoomAnimatorDelegate>

@property(nonatomic, strong) USPhotoVM *photoVM;

@property(nonatomic, strong) ZoomTransitionController* transitionController;
@end

NS_ASSUME_NONNULL_END
