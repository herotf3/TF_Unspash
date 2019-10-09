//
// Created by CPU11808 on 10/4/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePhotoVM.h"

@interface BasePhotoVM()

@end

@implementation BasePhotoVM {

}

/** Subclass need override these methods
 * */

- (UIImage *)iconForType {
    return nil;
}

- (void)setImageIntoImageView:(UIImageView *)imageView {
}

/** Clear cache or reset any resource before binding from view model into view (cell)
 * */
- (void)prepareForReuse {
}

- (CGSize)photoSize {
    return CGSizeZero;
}
@end