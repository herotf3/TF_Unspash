//
//  PhotoDetailViewController.m
//  TF Unspash
//
//  Created by CPU11808 on 10/2/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "USPhotoVM.h"
#import "FullViewPhotoViewController.h"
#import "CustomAnimatedTransitioning.h"
#import "ZoomTransitionController.h"

@interface PhotoDetailViewController () <UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>
@property(weak, nonatomic) IBOutlet UIImageView *imvMainPhoto;
@property(weak, nonatomic) IBOutlet UILabel *lbCreateAtDate;
@property(weak, nonatomic) IBOutlet UIView *userInfoView;
@property(weak, nonatomic) IBOutlet UILabel *lbTotalLikes;
@property(weak, nonatomic) IBOutlet UILabel *userName;
@property(weak, nonatomic) IBOutlet UILabel *lbInstagram;
@property(weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property(weak, nonatomic) IBOutlet UILabel *lbTotalLikeOfUser;
@property(weak, nonatomic) IBOutlet UILabel *lbTotalUserPhoto;
@property (weak, nonatomic) IBOutlet UIView *contentViewOfScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeightConstraint;

@property(nonatomic, strong) CustomAnimatedTransitioning * transition;
@property (nonatomic, strong) UIPanGestureRecognizer * panGestureRecognizer;
@end

@implementation PhotoDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitionController = [ZoomTransitionController new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindData];

    _transition = [CustomAnimatedTransitioning new];

    self.panGestureRecognizer = [UIPanGestureRecognizer new];
    self.panGestureRecognizer.delegate = self;
    [self.panGestureRecognizer addTarget:self action:@selector(didPanWithGesture:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGFloat w = _imvMainPhoto.frame.size.width;
    CGFloat h = w * (_photoVM.photoSize.height / _photoVM.photoSize.width);
    self.photoHeightConstraint.constant = h;
}


- (void)didPanWithGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self.scrollView setScrollEnabled:NO];
            self.transitionController.isInteractive = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateEnded:
            if (self.transitionController.isInteractive) {
                [self.scrollView setScrollEnabled:YES];
                self.transitionController.isInteractive = NO;
                [self.transitionController didPanWithGesture:gestureRecognizer];
            }
            break;
        default:
            if (self.transitionController.isInteractive) {
                [self.transitionController didPanWithGesture:gestureRecognizer];
            }
    }
}

- (void)bindData {
    [_imvMainPhoto sd_setImageWithURL:[self.photoVM photoURLForLargeDisplay] placeholderImage:_photoVM.photoPlaceHolder];
    
    [_imvAvatar sd_setImageWithURL:_photoVM.userAvatar placeholderImage:nil];
    _lbTotalLikes.text = _photoVM.totalLike;
    _userName.text = _photoVM.userName;
    _lbInstagram.text = _photoVM.instagramUsername;
    _lbCreateAtDate.text = _photoVM.createDateText;
    _lbTotalLikeOfUser.text = _photoVM.totalLikeOfUser;
    _lbTotalUserPhoto.text = _photoVM.totalUserPhoto;

}

- (IBAction)onActionDidTouchPhoto:(id)sender {
    FullViewPhotoViewController *fullPhotoVC = [[FullViewPhotoViewController alloc] initWithFrame: self.view.frame viewModel:self.photoVM];
    fullPhotoVC.photoVM = self.photoVM;
    fullPhotoVC.transitioningDelegate = self;
    fullPhotoVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:fullPhotoVC animated:YES completion:nil];
}

#pragma mark - Transitioning delegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    self.transition.originFrame = [self.imvMainPhoto.superview convertRect:self.imvMainPhoto.frame toView:nil];    // get the frame in screen's coordinate
    self.transition.presenting = YES;

    return self.transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transition.presenting = NO;
    return self.transition;
}

#pragma mark - ZoomAnimator delegate

- (CGRect)referenceImageViewFrameInTransitionView:(ZoomAnimator *)animator {
    CGRect frame = self.imvMainPhoto.frame;
    if (self.navigationController && self.navigationController.navigationBar){
        frame.origin.y += self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y; 
    }
    frame.size.height = self.photoHeightConstraint.constant;
    frame = [self.imvMainPhoto.superview convertRect:frame toView:nil];
    return frame;
}

- (UIImageView *)referenceImageView:(ZoomAnimator *)animator {
    return self.imvMainPhoto;
}

#pragma mark - Pan gesture delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]){
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *) gestureRecognizer;
        CGPoint velocity = [panGesture velocityInView:self.view];
        //Only begin if gesture is pan down
        if (UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation)){
            return velocity.x >= 0; // vertical axis is x in landscape
        }else{
            return velocity.y >= 0;
        }
    }
    //other gesture
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // Check for scroll gesture in scroll view
    if (otherGestureRecognizer == self.scrollView.panGestureRecognizer){
        if (self.scrollView.contentOffset.y <= 0)
            return YES;
    }
    return NO;
}


@end
