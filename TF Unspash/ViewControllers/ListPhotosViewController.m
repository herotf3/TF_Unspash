//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "ListPhotosViewController.h"
#import "PhotoCollectionViewCell.h"
#import "WaterFallLayout.h"
#import "UIViewController+ProcessView.h"
#import "PhotoDetailViewController.h"
#import "USPhoto.h"

#define PHOTO_CELL_ID @"PhotoCollectionCellId"

#define NUMBER_OF_PHOTO_COLUMNS 2

@interface ListPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterFallLayoutDelegate, ListPhotosViewModelsDelegate>
@property(weak, nonatomic) IBOutlet UICollectionView *clvPhotos;

@end

@implementation ListPhotosViewController {
    NSInteger numberOfColumn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    self.listPhotoVM = [[ListPhotosViewModel alloc] initWithDelegate:self];
    [self.listPhotoVM fetchData];
}

- (void)setupCollectionView {
    [_clvPhotos registerNib:[UINib nibWithNibName:[PhotoCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:PHOTO_CELL_ID];
    _clvPhotos.delegate = self;
    _clvPhotos.dataSource = self;
    numberOfColumn = 2;

    if ([_clvPhotos.collectionViewLayout isKindOfClass:WaterFallLayout.class]) {
        ((WaterFallLayout *) _clvPhotos.collectionViewLayout).delegate = self;
    }
}

#pragma mark  - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.listPhotoVM.photoViewModels count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_ID forIndexPath:indexPath];

    [cell bindDataWith:self.listPhotoVM.photoViewModels[indexPath.row]];
    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *detailVC = [PhotoDetailViewController new];
    detailVC.photoVM = self.listPhotoVM.photoViewModels[indexPath.row];

    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - Water fall layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    USPhotoVM *photoVM = self.listPhotoVM.photoViewModels[indexPath.row];
    return CGSizeMake(photoVM.photo.width, photoVM.photo.height);
}


- (NSInteger)waterFallLayoutNumberOfColumns {
    return NUMBER_OF_PHOTO_COLUMNS;
}

#pragma mark - List Photos VM Delegate

- (void)onFetching {
    [self showLoading];
}

- (void)didFetchCompleted {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideLoading];
        [self.clvPhotos reloadData];
    });
}


@end
