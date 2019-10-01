//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "USPhotoVM.h"
#import "USPhoto.h"


@implementation USPhotoVM {
}
#pragma mark - Init

- (instancetype)initWithPhoto:(USPhoto *)photo {
    self = [super init];
    if (self) {
        self.photo = photo;
    }
    return self;
}

+ (instancetype)presenterWithPhoto:(USPhoto *)photo {
    return [[self alloc] initWithPhoto:photo];
}

- (NSURL *)URLForDisplayInThumb {
    return [[NSURL alloc] initWithString:self.photo.urls.thumb];
}

- (CGSize)photoSizeForColectionView {
    return CGSizeMake(self.photo.width, self.photo.height);
}

@end