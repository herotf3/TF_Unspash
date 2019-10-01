//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "USPhoto.h"
#import "USPhotoVM.h"


@interface ListPhotosViewController : UIViewController

@property (nonatomic, strong) NSArray<USPhotoVM*> * photos;
@end
