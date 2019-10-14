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
@property (strong, nonatomic) UIScrollView * scrollView;

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

    CGRect frameForImv = self.view.frame;
    CGFloat h = self.view.frame.size.height;
    CGFloat w = h * _photoVM.photoSize.width /_photoVM.photoSize.height;
    frameForImv.size = CGSizeMake(w, h) ;
    self.imvPhoto.frame = frameForImv;
    self.scrollView.contentSize = frameForImv.size;
    
    [self.imvPhoto sd_setImageWithURL:[self.photoVM photoURLForFullDisplay] placeholderImage:[self.photoVM photoPlaceHolder]];
}


- (void)layoutViews {
    self.scrollView.frame = self.view.frame;

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imvPhoto];
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
        _closeButton.frame = CGRectMake(8, 20, 50, 50);
        _closeButton.clipsToBounds = NO;

    }
    return _closeButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setBounces:NO];
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//        CGFloat bottomInset = UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
//        [_scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, bottomInset, 0)];

    }
    return _scrollView;
}


- (void)closeViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGRect)referenceImageViewFrameInTransitionView:(ZoomAnimator *_Nullable)animator {

    return [self.imvPhoto.superview convertRect:self.imvPhoto.frame toView:nil];
}

- (UIImageView *_Nullable)referenceImageView:(ZoomAnimator *_Nullable)animator {
    return self.imvPhoto;
}


@end
