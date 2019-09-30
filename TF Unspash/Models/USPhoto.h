//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

// USPhoto.h

// To parse this JSON:
//
//   NSError *error;
//   USPhoto *photo = [USPhoto fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class USPhoto;
@class USPhotoLinks;
@class USUrls;
@class USUser;
@class USUserLinks;
@class USProfileImage;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface USPhoto : NSObject
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, assign)         NSInteger width;
@property (nonatomic, assign)         NSInteger height;
@property (nonatomic, copy)           NSString *color;
@property (nonatomic, copy)           NSString *theDescription;
@property (nonatomic, nullable, copy) id altDescription;
@property (nonatomic, strong)         USUrls *urls;
@property (nonatomic, strong)         USPhotoLinks *links;
@property (nonatomic, copy)           NSArray *categories;
@property (nonatomic, assign)         NSInteger likes;
@property (nonatomic, assign)         BOOL isLikedByUser;
@property (nonatomic, copy)           NSArray *currentUserCollections;
@property (nonatomic, strong)         USUser *user;

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;

@end

@interface USPhotoLinks : NSObject
@property (nonatomic, copy) NSString *self;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *downloadLocation;
@end

@interface USUrls : NSObject
@property (nonatomic, copy) NSString *raw;
@property (nonatomic, copy) NSString *full;
@property (nonatomic, copy) NSString *regular;
@property (nonatomic, copy) NSString *small;
@property (nonatomic, copy) NSString *thumb;
@end

@interface USUser : NSObject
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *username;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *firstName;
@property (nonatomic, copy)           NSString *lastName;
@property (nonatomic, nullable, copy) id twitterUsername;
@property (nonatomic, nullable, copy) id portfolioURL;
@property (nonatomic, nullable, copy) id bio;
@property (nonatomic, copy)           NSString *location;
@property (nonatomic, strong)         USUserLinks *links;
@property (nonatomic, strong)         USProfileImage *profileImage;
@property (nonatomic, copy)           NSString *instagramUsername;
@property (nonatomic, assign)         NSInteger totalCollections;
@property (nonatomic, assign)         NSInteger totalLikes;
@property (nonatomic, assign)         NSInteger totalPhotos;
@property (nonatomic, assign)         BOOL isAcceptedTos;
@end

@interface USUserLinks : NSObject
@property (nonatomic, copy) NSString *self;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *photos;
@property (nonatomic, copy) NSString * likes;
@property (nonatomic, copy) NSString *portfolio;
@property (nonatomic, copy) NSString *following;
@property (nonatomic, copy) NSString *followers;
@end

@interface USProfileImage : NSObject
@property (nonatomic, copy) NSString *small;
@property (nonatomic, copy) NSString *medium;
@property (nonatomic, copy) NSString *large;
@end

NS_ASSUME_NONNULL_END