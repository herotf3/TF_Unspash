//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPhotosViewModel.h"
#import "UnsplashAPI.h"
#import "SupportFunctions.h"
#import "ListPhotosViewController.h"
#import "UIViewController+ProcessView.h"
#import "USPhotoVM.h"

#define N_PHOTO_PER_PAGE 30

#define ORDER_LATEST @"latest"

@interface  ListPhotosViewModel()

@property (nonatomic, strong) NSArray<USPhotoVM*> *photos;

@property(nonatomic) NSInteger page;
@end

@implementation ListPhotosViewModel

- (instancetype)initWithDelegate:(id <ListPhotosViewModelsDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}

+ (instancetype)modelWithDelegate:(id <ListPhotosViewModelsDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}


- (void)fetchData {
    [self.delegate onFetching];

    [UnsplashAPI getListPhotosInPage:self.page withNumberPhotoPerPage:N_PHOTO_PER_PAGE orderBy:ORDER_LATEST completion:^(NSArray *photos, NSString *errorMsg) {
        if (errorMsg){
            return;
        }
        if (photos){
            self.photos = map(photos, ^id(USPhoto * value) {
                return [USPhotoVM photoVMWithPhoto:value];
            });
        }

        [self.delegate didFetchCompleted];
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

// Data source
- (NSInteger)numberOfPhoto {
    return self.photos.count;
}

- (USPhotoVM *)photoVMAtIndexPath:(NSIndexPath *)indexPath {
    return self.photos[indexPath.row];
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_photos[indexPath.row] photoSizeForColectionView] ;
}

@end
