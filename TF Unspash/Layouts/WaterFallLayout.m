//
//  WaterFallLayout.m
//  TF Unspash
//
//  Created by CPU11808 on 10/1/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import "WaterFallLayout.h"

#define DEFAULT_NUMBER_COLUMNS 1

#define DEFAULT_ITEM_SIZE 180

@interface WaterFallLayout ()

@property(nonatomic) CGFloat cellPadding;
@property(nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributeCache;
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGFloat contentWidth;

@end

@implementation WaterFallLayout

#pragma mark - Initialize

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (void)initProperties {
    self.cellPadding = 6;
    self.attributeCache = [NSMutableArray new];
    self.contentHeight = 0;
}

- (NSInteger)numberOfColumn {
    if (self.delegate) {
        return [self.delegate waterFallLayoutNumberOfColumns];
    } else
        return DEFAULT_NUMBER_COLUMNS;
}

- (CGFloat)contentWidth {
    if (self.collectionView) {
        UIEdgeInsets insets = self.collectionView.contentInset;
        self.contentWidth = self.collectionView.bounds.size.width - (insets.left + insets.right);
    } else {
        self.contentWidth = 0;
    }
    return _contentWidth;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

#pragma mark - Overiding Collection view layout

- (void)prepareLayout {
    [super prepareLayout];

    if (self.attributeCache.count != 0 || !self.collectionView) {
        // Only calculate layout attribute when if cache is empty and collectionView exits
        return;
    }

    CGFloat colWidth = _contentWidth / self.numberOfColumn;
    CGFloat xOffsets[self.numberOfColumn];
    for (int col = 0; col < self.numberOfColumn; col++) {
        xOffsets[col] = col * colWidth;
    }

    CGFloat yOffsets[self.numberOfColumn];
    for (int i = 0; i < self.numberOfColumn; i++)
        yOffsets[i] = 0;

    NSInteger col = 0;
    // Frame calculation for all item
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

//        CGFloat photoHeight = 180;
        CGSize photoSize = CGSizeMake(DEFAULT_ITEM_SIZE, DEFAULT_ITEM_SIZE);
        if (_delegate)
            photoSize = [_delegate collectionView:self.collectionView sizeForItemAtIndexPath:indexPath];

        // Get the height so that keep the ratio received from delegate's item size (W,H)
        // h = padding + w * (H / W)
        CGFloat height = _cellPadding * 2 + colWidth * (photoSize.height / photoSize.width);

        CGRect frame = CGRectMake(xOffsets[col], yOffsets[col], colWidth, height);
        CGRect insetFrame = CGRectInset(frame, _cellPadding, _cellPadding);

        //Caching attribute
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = insetFrame;
        [self.attributeCache addObject:attr];

        _contentHeight = MAX(_contentHeight, CGRectGetMaxY(frame));
        yOffsets[col] = yOffsets[col] + height;

        col = (col < self.numberOfColumn - 1) ? (col + 1) : 0;
    }
}

//return layout information for all items whose view intersects the specified rectangle
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray <UICollectionViewLayoutAttributes *> *visibleLayoutAttr = [NSMutableArray new];

    for (UICollectionViewLayoutAttributes *attributes in self.attributeCache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [visibleLayoutAttr addObject:attributes];
        }
    }
    return visibleLayoutAttr;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.attributeCache[indexPath.row];
}


@end
