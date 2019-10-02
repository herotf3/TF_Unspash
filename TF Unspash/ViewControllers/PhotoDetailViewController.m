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

@interface PhotoDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imvMainPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lbCreateAtDate;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalLikes;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *lbInstagram;
@property (weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalLikeOfUser;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalUserPhoto;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindData];
}

- (void)bindData {
    [_imvAvatar sd_setImageWithURL:_photoVM.userAvatar placeholderImage:nil];

    [_imvMainPhoto sd_setImageWithURL:[self.photoVM URLForDisplayInLarge] placeholderImage:_photoVM.placeHolderImage];
    _lbTotalLikes.text = _photoVM.totalLike;
    _userName.text = _photoVM.userName;
    _lbInstagram.text = _photoVM.instagramUsername ;
    _lbCreateAtDate.text = _photoVM.createDateText;
    _lbTotalLikeOfUser.text = _photoVM.totalLikeOfUser;
    _lbTotalUserPhoto.text = _photoVM.totalUserPhoto;

}


@end
