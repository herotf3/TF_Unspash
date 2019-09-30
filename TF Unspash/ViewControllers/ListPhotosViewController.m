//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "ListPhotosViewController.h"
#import "PhotoCollectionViewCell.h"

#define PHOTO_CELL_ID @"PhotoCollectionCellId"

@interface ListPhotosViewController() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView * clvPhotos;

@end

@implementation ListPhotosViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
}

- (void)setupCollectionView {
    [_clvPhotos registerNib:[UINib nibWithNibName:[PhotoCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:PHOTO_CELL_ID];
    _clvPhotos.delegate = self;
    _clvPhotos.dataSource = self;
}

#pragma mark  - Collection data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_ID forIndexPath:indexPath];
    //cell.imageView.image = UIImage
    return cell;
}


@end
