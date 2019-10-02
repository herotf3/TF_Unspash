//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPhotosHandler.h"
#import "UnsplashAPI.h"
#import "SupportFunctions.h"
#import "ListPhotosViewController.h"
#import "UIViewController+ProcessView.h"
#import "USPhotoVM.h"

@interface  ListPhotosHandler()

@property (nonatomic, strong) NSArray<USPhotoVM*> *photos;

@end

@implementation ListPhotosHandler

- (instancetype)initWithViewController:(ListPhotosViewController *)viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }

    return self;
}

+ (instancetype)vmWithViewController:(ListPhotosViewController *)viewController {
    return [[self alloc] initWithViewController:viewController];
}


- (void)fetchData {
    [self.viewController showLoading];
    [UnsplashAPI getListPhotosWithCompletionHandler:^(NSArray *photos, NSString *error) {
        [self.viewController hideLoading];
        if (error){
            return;
        }
        if (photos){
            self.photos = map(photos, ^id(USPhoto * value) {
                return [USPhotoVM photoVMWithPhoto:value];
            });
        }
    }];
}

//Binding
- (void)setPhotos:(NSArray<USPhotoVM *> *)photos{
    self.viewController.photos = photos;
    _photos = photos;
    [self.viewController didFinishLoadData];
}

@end
