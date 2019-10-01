//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "ListPhotosViewController.h"
#import "PhotoCollectionViewCell.h"
#import "UnsplashAPI.h"
#import "WaterFallLayout.h"
#import "USPhotoVM.h"
#import "SupportFunctions.h"
#import "UIViewController+ProcessView.h"

#define PHOTO_CELL_ID @"PhotoCollectionCellId"

#define NUMBER_OF_PHOTO_COLUMNS 2

@interface ListPhotosViewController() <UICollectionViewDataSource, UICollectionViewDelegate, WaterFallLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView * clvPhotos;

@end

@implementation ListPhotosViewController {
    NSInteger numberOfColumn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    [self loadListPhotos];
}

- (void)loadListPhotos {
    [self showLoading];
    [UnsplashAPI getListPhotosWithCompletionHandler:^(NSArray *photos, NSString *error) {
        [self hideLoading];
        if (error){
            return;
        }
        if (photos){
            self.photos = map(photos, ^id(USPhoto * value) {
                return [USPhotoVM presenterWithPhoto:value];
            });
        }
    }];
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.clvPhotos reloadData];
    });
}

- (void)setupCollectionView {
    [_clvPhotos registerNib:[UINib nibWithNibName:[PhotoCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:PHOTO_CELL_ID];
    _clvPhotos.delegate = self;
    _clvPhotos.dataSource = self;
    numberOfColumn = 2;

    if ([_clvPhotos.collectionViewLayout isKindOfClass:WaterFallLayout.class]){
        ((WaterFallLayout *)_clvPhotos.collectionViewLayout).delegate = self;
    }
}

#pragma mark  - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_ID forIndexPath:indexPath];

    USPhotoVM *photoPresenter = self.photos[indexPath.row];
    [cell bindDataWith:photoPresenter];
    return cell;
}

#pragma mark - Water fall layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.photos[indexPath.row] photoSizeForColectionView];
}


- (NSInteger)waterFallLayoutNumberOfColumns {
    return NUMBER_OF_PHOTO_COLUMNS;
}

@end
