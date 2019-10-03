//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnsplashAPI.h"
#import "UnsplashEndPoint.h"
#import "USPhoto.h"
#import "SupportFunctions.h"

@implementation UnsplashAPI

+ (void)getListPhotosWithCompletionHandler:(void (^)(NSArray *photos, NSString *error))completion {
    [self getListPhotosInPage:1 completion:completion];
}

+ (void)getListPhotosInPage:(NSInteger)page completion:(void (^)(NSArray *photos, NSString *errorMsg))completion {
    [self getListPhotosInPage:page withNumberPhotoPerPage:10 completion:completion];
}

+ (void)getListPhotosInPage:(NSInteger)page withNumberPhotoPerPage:(NSInteger)nPerPage completion:(void (^)(NSArray *photos, NSString *errorMsg))completion {
    [self getListPhotosInPage:page withNumberPhotoPerPage:nPerPage orderBy:@"latest" completion:completion];
}


+ (void)getListPhotosInPage:(NSInteger)page
     withNumberPhotoPerPage:(NSInteger)nPerPage orderBy:(NSString *)orderBy
                 completion:(void (^)(NSArray *photos, NSString *errorMsg))completion {
    NSDictionary *urlParams = @{@"page": @(page).stringValue, @"per_page": @(nPerPage).stringValue, @"orderBy": orderBy};
    UnsplashEndPoint *endPoint = [UnsplashEndPoint initWithEndPointRequest:UnsplashEndPointGetPhotos bodyParameters:nil urlParameter:urlParams];
//
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:endPoint.urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error.debugDescription);
            NSLog(@"Request failed with error: %@", error.debugDescription);
            return;
        }

        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"Parse json failed with error: %@", error.debugDescription);
            completion(nil, error.debugDescription);
            return;
        }

//        NSLog(@"Request successfully with response: %@", dataDict);

        NSMutableArray *photos;
        photos = map(dataDict, ^id(id dict) {
            USPhoto *photo = [USPhoto fromJSONDictionary:dict];
            return photo;
        });

        completion(photos, nil);
    }];
    [task resume];
}

+ (void)getListCuratedPhotosInPage:(NSInteger)page withNumberPhotoPerPage:(NSInteger)nPerPage
                           orderBy:(NSString *)orderBy completion:(void (^)(NSArray *photos, NSString *errorMsg))completion
{
    NSDictionary *urlParams = @{@"page": @(page).stringValue, @"per_page": @(nPerPage).stringValue, @"orderBy": orderBy};
    UnsplashEndPoint *endPoint = [UnsplashEndPoint initWithEndPointRequest:UnsplashEndPointGetCuratedPhotos bodyParameters:nil urlParameter:urlParams];
//
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:endPoint.urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error.debugDescription);
            NSLog(@"Request failed with error: %@", error.debugDescription);
            return;
        }

        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"Parse json failed with error: %@", error.debugDescription);
            completion(nil, error.debugDescription);
            return;
        }

//        NSLog(@"Request successfully with response: %@", dataDict);

        NSMutableArray *photos;
        photos = map(dataDict, ^id(id dict) {
            USPhoto *photo = [USPhoto fromJSONDictionary:dict];
            photo.isCurated=YES;
            return photo;
        });

        completion(photos, nil);
    }];
    [task resume];
}


@end
