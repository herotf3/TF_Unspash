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

@interface PhotoDetailViewController () <UIViewControllerTransitioningDelegate>
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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeightConstraint;

@property(nonatomic, strong) CustomAnimatedTransitioning * transition;
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
}

- (void)bindData {
    CGFloat w = _imvMainPhoto.frame.size.width;
    CGFloat h = w * (_photoVM.photoSize.height / _photoVM.photoSize.width);
    self.photoHeightConstraint.constant = h;
    
    [_imvMainPhoto sd_setImageWithURL:[self.photoVM photoURLForLargeDisplay] placeholderImage:_photoVM.photoPlaceHolder];
    
    [_imvAvatar sd_setImageWithURL:_photoVM.userAvatar placeholderImage:nil];
    _lbTotalLikes.text = _photoVM.totalLike;
    _userName.text = _photoVM.userName;
    _lbInstagram.text = _photoVM.instagramUsername;
    _lbCreateAtDate.text = _photoVM.createDateText;
    _lbTotalLikeOfUser.text = _photoVM.totalLikeOfUser;
    _lbTotalUserPhoto.text = _photoVM.totalUserPhoto;

}

- (IBAction)onActionDismiss:(id)sender {
    if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
    frame = [self.imvMainPhoto.superview convertRect:frame toView:nil];
    return frame;
}

- (UIImageView *)referenceImageView:(ZoomAnimator *)animator {
    return self.imvMainPhoto;
}


@end
