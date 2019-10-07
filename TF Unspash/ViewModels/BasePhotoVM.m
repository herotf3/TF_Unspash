//
// Created by CPU11808 on 10/4/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePhotoVM.h"


@implementation BasePhotoVM {

}

/** Subclass need override these methods
 * */
- (NSURL *)photoURLForDisplayInThumb {
    return nil;
}

- (UIImage *)iconForType {
    return nil;
}

- (void)setImageIntoImageView:(UIImageView *)imageView {
}

- (CGSize)photoSize {
    return CGSizeZero;
}
@end