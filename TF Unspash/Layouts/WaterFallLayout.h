//
//  WaterFallLayout.h
//  TF Unspash
//
//  Created by CPU11808 on 10/1/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WaterFallLayoutDelegate <NSObject>
@required
- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)waterFallLayoutNumberOfColumns;
@end

@interface WaterFallLayout : UICollectionViewLayout

@property(weak, nonatomic, nullable) id <WaterFallLayoutDelegate> delegate;

- (NSInteger)numberOfColumn;
@end

NS_ASSUME_NONNULL_END
