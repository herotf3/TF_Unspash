//
//  TestingViewController.m
//  TF Unspash
//
//  Created by CPU11808 on 9/30/19.
//  Copyright © 2019 CPU11808. All rights reserved.
//

#import "TestingViewController.h"
#import "UnsplashAPI.h"


@interface TestingViewController ()

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadPhotosData];
}

- (void)loadPhotosData {
    [UnsplashAPI getListPhotosWithCompletionHandler:^(NSArray *photos, NSString *error) {
        if (error) {
            return;
        }
        if (photos) {
            self.photos = photos;
        }
    }];
}


@end
