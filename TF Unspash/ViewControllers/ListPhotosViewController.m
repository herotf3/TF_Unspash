//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "ListPhotosViewController.h"
#import "PhotoCollectionViewCell.h"
#import "USPhoto.h"
#import "UnsplashAPI.h"

#define PHOTO_CELL_ID @"PhotoCollectionCellId"

@interface ListPhotosViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView * clvPhotos;

@end

@implementation ListPhotosViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    [self loadListPhotos];
}

- (void)loadListPhotos {
    [UnsplashAPI getListPhotosWithCompletionHandler:^(NSArray *photos, NSString *error) {
        if (error){
            return;
        }
        if (photos){
            self.photos = photos;
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
}

#pragma mark  - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_ID forIndexPath:indexPath];

    USPhoto* photo = self.photos[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:photo.urls.thumb] placeholderImage:nil completed:nil];
    [cell setBackgroundColor:UIColor.blueColor];
    return cell;
}

#pragma mark - Collection view flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize result;
    result = CGSizeMake(200, 200);
    return result;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets result;
    result = UIEdgeInsetsZero;
    return result;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}


@end
