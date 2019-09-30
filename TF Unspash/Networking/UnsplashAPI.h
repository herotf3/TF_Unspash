//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  Contain available APIs of Unsplash
  Client should only call API from here
 */
@interface UnsplashAPI : NSObject

+(void) getListPhotosWithCompletionHandler:(void(^)(NSArray * photos, NSString *error))completion;

@end