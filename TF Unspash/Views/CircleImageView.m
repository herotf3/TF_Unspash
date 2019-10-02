//
// Created by CPU11808 on 10/2/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "CircleImageView.h"


@implementation CircleImageView {
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
}

@end