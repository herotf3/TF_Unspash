//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import "ListPhotosViewController.h"
#import "PhotoCollectionViewCell.h"
#import "WaterFallLayout.h"
#import "UIViewController+ProcessView.h"
#import "PhotoDetailViewController.h"
#import "ZoomTransitionController.h"

#define PHOTO_CELL_ID @"PhotoCollectionCellId"

@interface ListPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterFallLayoutDelegate, ListPhotosViewModelsDelegate, ZoomAnimatorDelegate>

@property(weak, nonatomic) IBOutlet UICollectionView *clvPhotos;
@property(strong, nonatomic) NSArray<BasePhotoVM*>* photos;

@property(nonatomic, strong) NSIndexPath *selectedIndexPath;
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
    NSLog(@"number item:%ld",self.photos.count);
    return [self.photos count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_ID forIndexPath:indexPath];
    [cell bindWithPhotoVM:self.photos[indexPath.row]];

    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    if ([_photos[indexPath.row] isKindOfClass:USPhotoVM.class]){
        PhotoDetailViewController *detailVC = [PhotoDetailViewController new];
        detailVC.photoVM = (USPhotoVM *) self.photos[indexPath.row];
        
        detailVC.view.frame = self.view.frame;
        [detailVC.view setNeedsLayout];
        [detailVC.view layoutIfNeeded];

        // set transition animation delegate
        UINavigationController * nav = self.navigationController;
        if (nav){
            nav.delegate = detailVC.transitionController;
            detailVC.transitionController.fromDelegate = self;
            detailVC.transitionController.toDelegate = detailVC;
        }

        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


#pragma mark - Water fall layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize imageSize = [self.photos[indexPath.row] photoSize];
    return imageSize;

}


- (NSInteger)waterFallLayoutNumberOfColumns {
    return numberOfColumn;
}

#pragma mark - List Photos VM Delegate

- (void)onFetching {
    [self showLoading];
}

- (void)didFetchCompleted {
    self.photos = [NSArray arrayWithArray:self.listPhotoVM.photoViewModels];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideLoading];
        [self.clvPhotos reloadData];
        NSLog(@"-----Reload data");
    });
}

- (IBAction)onActionIncreaseColumn:(id)sender {
    numberOfColumn++;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
        [self.clvPhotos reloadData];
    }];
}

#pragma mark - ZoomAnimator delegate
- (CGRect)referenceImageViewFrameInTransitionView:(ZoomAnimator *)animator {
    PhotoCollectionViewCell * photoCell = (PhotoCollectionViewCell *) [self.clvPhotos cellForItemAtIndexPath:self.selectedIndexPath];
    CGRect unConvertFrame = photoCell.frame;
    CGRect cellFrame = [self.clvPhotos convertRect:unConvertFrame toView:self.view];

    if (CGRectGetMinY(cellFrame) < self.clvPhotos.contentInset.top){
        return CGRectMake(cellFrame.origin.x, self.clvPhotos.contentInset.top, cellFrame.size.width, cellFrame.size.height);
    }
    return cellFrame;
}

- (UIImageView *)referenceImageView:(ZoomAnimator *)animator {
    PhotoCollectionViewCell * photoCell = (PhotoCollectionViewCell *) [self.clvPhotos cellForItemAtIndexPath:self.selectedIndexPath];
    return photoCell.imageView;
}


@end
