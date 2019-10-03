//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import <Foundation/Foundation.h>


enum EndPoint {
    UnsplashEndPointGetPhotos
};

@interface UnsplashEndPoint : NSObject

@property(nonatomic) enum EndPoint endPointRequest;

@property(nonatomic, strong) NSDictionary<NSString *, NSString *> *parameter;
@property(nonatomic, strong) NSDictionary<NSString *, NSString *> *urlParameter;

// init
- (instancetype)initWithEndPoint:(enum EndPoint)endPointRequest;

+ (instancetype)initWithEndPoint:(enum EndPoint)endPointRequest;

- (instancetype)initWithEndPointRequest:(enum EndPoint)endPointRequest bodyParameters:(NSDictionary *)params urlParameter:(NSDictionary *)urlParams;

+ (instancetype)initWithEndPointRequest:(enum EndPoint)endPointRequest bodyParameters:(NSDictionary *)params urlParameter:(NSDictionary *)urlParams;


// GETTER
- (NSString *)method;

- (NSString *)absolutePath;

- (NSMutableDictionary *)httpHeader;

- (NSURLRequest *)urlRequest;

@end