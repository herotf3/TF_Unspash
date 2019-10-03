//
//  TestingViewController.m
//  TF Unspash
//
//  Created by CPU11808 on 9/30/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <Photos/Photos.h>
#import "TestingViewController.h"
#import "UnsplashAPI.h"


@interface TestingViewController () <PHPhotoLibraryChangeObserver>
@property PHFetchResult<PHAsset*> *fetchResult;
@property PHAssetCollection * assetCollection;
@property (nonatomic) PHCachingImageManager * imageManager;
@property CGSize thumbnailSize;

@end

@implementation TestingViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];

    [self loadPhotos];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}


- (void)loadPhotos {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status){
            case PHAuthorizationStatusNotDetermined:
                NSLog(@"Not determined yet");
                break;
            case PHAuthorizationStatusRestricted:
            case PHAuthorizationStatusDenied:
                NSLog(@"Not allowed");
                break;
            case PHAuthorizationStatusAuthorized:
                NSLog(@"Access Photo permission successfully");
                PHFetchOptions * allPhotoOption = [PHFetchOptions new];
                self.fetchResult = [PHAsset fetchAssetsWithOptions:allPhotoOption];
                [self showPhoto];
                break;
        }
    }];
    NSLog(@"number asset : %ld",self.fetchResult.count);
}

- (PHCachingImageManager *)imageManager{
    if (_imageManager==nil){
        _imageManager = [PHCachingImageManager new];
    }
    return _imageManager;
}

-(void) showPhoto{
    PHImageRequestOptions* options = [PHImageRequestOptions new];
    [PHImageManager.defaultManager requestImageForAsset:[_fetchResult objectAtIndex:1] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options: options
                                          resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        CGFloat w = result.size.width;
        CGFloat h = result.size.height;

        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView* imageView = [[UIImageView alloc] initWithImage:result];
            imageView.frame = CGRectMake(0, 0, w, h);
            [self.view addSubview:imageView];
        });
    }];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {

}


@end
