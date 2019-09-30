//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "UnsplashAPI.h"
#import "UnsplashEndPoint.h"
#import "USPhoto.h"

@implementation UnsplashAPI

+ (void)getListPhotosWithCompletionHandler:(void (^)(NSArray *photos, NSString *error))completion {
    UnsplashEndPoint* endPoint = [UnsplashEndPoint initWithEndPoint:UnsplashEndPointGetPhotos];

    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:endPoint.urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error){
           completion(nil,error.debugDescription);
           NSLog(@"Request failed with error: %@",error.debugDescription);
           return;
       }

       NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
       if (error){
           NSLog(@"Parse json failed with error: %@",error.debugDescription);
           completion(nil,error.debugDescription);
           return;
       }

       NSLog(@"Request successfully with response: %@",dataDict);

       NSMutableArray * photos = [NSMutableArray new];
//       for (NSDictionary *photoDict : dataDict[@""])
        photos = map(dataDict, ^id(id dict) {
            USPhoto *  photo = [USPhoto fromJSONDictionary: dict];
            return photo;
        });

        completion(photos,nil);
    }];
    [task resume];
}

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

@end