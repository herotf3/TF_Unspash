//
//  FullViewPhotoViewController.m
//  TF Unspash
//
//  Created by CPU11808 on 10/7/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import "FullViewPhotoViewController.h"
#import "UIImageView+WebCache.h"
#import "USPhotoVM.h"

@interface FullViewPhotoViewController ()

@property (strong, nonatomic) UIImageView* imvPhoto;
@property (strong, nonatomic) UIButton * closeButton;

@end

@implementation FullViewPhotoViewController

- (instancetype)initWithFrame:(CGRect)rect viewModel:(USPhotoVM *)photoVM {
    self = [super init];
    if (self) {
        self.view.frame = rect;
        self.photoVM = photoVM;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imvPhoto sd_setImageWithURL:[self.photoVM photoURLForDisplayInLarge] placeholderImage:[self.photoVM photoPlaceHolder]];
}


- (void)layoutViews {
    self.imvPhoto.frame = self.view.frame;
    [self.view addSubview:self.imvPhoto];
    [self.view addSubview:self.closeButton];
}


#pragma mark Lazy init
- (UIImageView *)imvPhoto {
    if (!_imvPhoto){
        _imvPhoto = [UIImageView new];
        [_imvPhoto setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imvPhoto;
}

- (UIButton *)closeButton {
    if(!_closeButton){
        _closeButton = [UIButton new];
        [_closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [_closeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];

        [_closeButton addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.frame = CGRectMake(20, 20, 100, 100);

    }
    return _closeButton;
}

- (void)closeViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
