//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "USPhoto.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface USPhoto (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

@interface USPhotoLinks (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

@interface USUrls (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

@interface USUser (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

@interface USUserLinks (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

@interface USProfileImage (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

#pragma mark - JSON serialization

USPhoto *_Nullable USPhotoFromData(NSData *data, NSError **error) {
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
    return *error ? nil : [USPhoto fromJSONDictionary:json];

}

USPhoto *_Nullable USPhotoFromJSON(NSString *json, NSStringEncoding encoding, NSError **error) {
    return USPhotoFromData([json dataUsingEncoding:encoding], error);
}

@implementation USPhoto
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
            @"id": @"identifier",
            @"created_at": @"createdAt",
            @"updated_at": @"updatedAt",
            @"width": @"width",
            @"height": @"height",
            @"color": @"color",
            @"description": @"theDescription",
            @"alt_description": @"altDescription",
            @"urls": @"urls",
            @"links": @"links",
            @"categories": @"categories",
            @"likes": @"likes",
            @"liked_by_user": @"isLikedByUser",
            @"current_user_collections": @"currentUserCollections",
            @"user": @"user",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error {
    return USPhotoFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error {
    return USPhotoFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[USPhoto alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _urls = [USUrls fromJSONDictionary:(id) _urls];
        _links = [USPhotoLinks fromJSONDictionary:(id) _links];
        _user = [USUser fromJSONDictionary:(id) _user];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key {
    id resolved = USPhoto.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

@end

@implementation USPhotoLinks
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
            @"self": @"self",
            @"html": @"html",
            @"download": @"download",
            @"download_location": @"downloadLocation",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[USPhotoLinks alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key {
    id resolved = USPhotoLinks.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

@end

@implementation USUrls
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
            @"raw": @"raw",
            @"full": @"full",
            @"regular": @"regular",
            @"small": @"small",
            @"thumb": @"thumb",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[USUrls alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

@implementation USUser
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
            @"id": @"identifier",
            @"updated_at": @"updatedAt",
            @"username": @"username",
            @"name": @"name",
            @"first_name": @"firstName",
            @"last_name": @"lastName",
            @"twitter_username": @"twitterUsername",
            @"portfolio_url": @"portfolioURL",
            @"bio": @"bio",
            @"location": @"location",
            @"links": @"links",
            @"profile_image": @"profileImage",
            @"instagram_username": @"instagramUsername",
            @"total_collections": @"totalCollections",
            @"total_likes": @"totalLikes",
            @"total_photos": @"totalPhotos",
            @"accepted_tos": @"isAcceptedTos",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[USUser alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _links = [USUserLinks fromJSONDictionary:(id) _links];
        _profileImage = [USProfileImage fromJSONDictionary:(id) _profileImage];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key {
    id resolved = USUser.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

@end

@implementation USUserLinks
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
            @"self": @"self",
            @"html": @"html",
            @"photos": @"photos",
            @"likes": @"likes",
            @"portfolio": @"portfolio",
            @"following": @"following",
            @"followers": @"followers",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[USUserLinks alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

@implementation USProfileImage
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
            @"small": @"small",
            @"medium": @"medium",
            @"large": @"large",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[USProfileImage alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
