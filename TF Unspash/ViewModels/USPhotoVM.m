//
// Created by CPU11808 on 10/1/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
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

+ (instancetype)photoVMWithPhoto:(USPhoto *)photo {
    return [[self alloc] initWithPhoto:photo];
}

- (NSURL *)URLForDisplayInThumb {
    return [[NSURL alloc] initWithString:self.photo.urls.thumb];
}

- (NSURL *)URLForDisplayInLarge {
    return [[NSURL alloc] initWithString:self.photo.urls.full];
}


- (UIImage *)placeHolderImage {
    return nil;
}

- (NSString *)totalLike {
    return @(self.photo.likes).stringValue;
}


- (NSString *)userName {
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.photo.user.firstName, self.photo.user.lastName];
    return fullName;
}

- (NSURL *)userAvatar {
    return [[NSURL alloc] initWithString:self.photo.user.profileImage.medium];
}


- (NSString *)instagramUsername {
    return [NSString stringWithFormat:@"Instagram: %@", self.photo.user.instagramUsername];
}

- (NSString *)createDateText {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    NSDate *date = [dateFormatter dateFromString:self.photo.createdAt];

    NSDateFormatter *myFormat = [NSDateFormatter new];
    myFormat.dateFormat = @"HH:mm MMM dd, yyyy";
    return [myFormat stringFromDate:date];
}


- (NSString *)totalLikeOfUser {
    return @(self.photo.user.totalLikes).stringValue;
}

- (NSString *)totalUserPhoto {
    return @(self.photo.user.totalPhotos).stringValue;
}

- (BOOL)isCurated {
    return [self.photo isCurated];
}
@end
