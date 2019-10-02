//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListPhotosViewModelsDelegate  <NSObject>
-(void) onFetching;
-(void) didFetchCompleted;
@end

@class ListPhotosViewController;
@class USPhotoVM;

@interface ListPhotosViewModel : NSObject

@property (nonatomic, weak, nullable) id<ListPhotosViewModelsDelegate> delegate;


- (instancetype _Nonnull )initWithDelegate:(id <ListPhotosViewModelsDelegate> _Nullable)delegate;

+ (instancetype _Nonnull )modelWithDelegate:(id <ListPhotosViewModelsDelegate> _Nullable)delegate;


- (void)fetchData;


- (NSInteger)numberOfPhoto;

- (USPhotoVM *_Nonnull)photoVMAtIndexPath:(NSIndexPath *_Nonnull)path;

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)path;
@end
