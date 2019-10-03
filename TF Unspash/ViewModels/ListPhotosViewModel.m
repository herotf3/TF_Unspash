//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ListPhotosViewModel.h"
#import "UnsplashAPI.h"
#import "SupportFunctions.h"
#import "ListPhotosViewController.h"

#define N_PHOTO_PER_PAGE 24

#define ORDER_LATEST @"latest"

@interface ListPhotosViewModel ()

@property(nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) dispatch_queue_t serialAccessQueue;

@property(nonatomic) NSInteger page;
@property(nonatomic, strong) PHFetchResult<PHAsset *> *fetchResult;
@end

@implementation ListPhotosViewModel

- (instancetype)initWithDelegate:(id <ListPhotosViewModelsDelegate>)delegate {
    self = [super init];
    if (self) {
        self.serialAccessQueue = dispatch_queue_create("array_photosVM_queue", NULL);
        self.delegate = delegate;
    }

    return self;
}

+ (instancetype)modelWithDelegate:(id <ListPhotosViewModelsDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (void)fetchData {
    self.photos = [NSMutableArray new];
    [self.delegate onFetching];

    // Get latest photos
    [UnsplashAPI getListPhotosInPage:self.page withNumberPhotoPerPage:N_PHOTO_PER_PAGE orderBy:ORDER_LATEST completion:^(NSArray *photos, NSString *errorMsg) {
        if (errorMsg) {
            return;
        }
        if (photos) {
            NSArray * tempArr;
            tempArr = map(photos, ^id(USPhoto *value) {
                return [USPhotoVM photoVMWithPhoto:value];
            });

            dispatch_async(self.serialAccessQueue, ^{
                [self.photos addObjectsFromArray:tempArr];
                [self.delegate didFetchCompleted];
            });
        }

    }];

    [self getLocalPhotos];
}

- (void)getLocalPhotos {
    
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

                dispatch_async(self.serialAccessQueue, ^{
                    for (int i=0;i<_fetchResult.count;i++){
                        [self.photos addObject:_fetchResult[i]];
                    }
                    [self.delegate didFetchCompleted];
                });

                break;
        }
    }];
    
}

-(void) getCuratedPhotos{
    //Get curated photos
    [UnsplashAPI getListCuratedPhotosInPage:self.page withNumberPhotoPerPage:N_PHOTO_PER_PAGE orderBy:ORDER_LATEST completion:^(NSArray *photos, NSString *errorMsg) {
        if (errorMsg) {
            return;
        }
        if (photos) {
            NSArray * tempArr;
            tempArr = map(photos, ^id(USPhoto *value) {
                return [USPhotoVM photoVMWithPhoto:value];
            });

            dispatch_async(self.serialAccessQueue, ^{
                [self.photos addObjectsFromArray:tempArr];
                [self.delegate didFetchCompleted];
            });
        }


    }];
}

//-(NSArray<NSIndexPath *> *) calculateIndexPathsToReloadFrom:(NSArray*) newPhotos {
//    NSInteger startIndex = self.photos.count - newPhotos.count;
//    NSInteger endIndex = startIndex + newPhotos.count;
//    NSMutableArray *indexPaths = [NSMutableArray new];
//    for (NSInteger i=startIndex;i<endIndex; i++){
//        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//    }
//    return indexPaths;
//}

- (NSArray <USPhotoVM *> *)photoViewModels {
    return _photos;
}

@end
