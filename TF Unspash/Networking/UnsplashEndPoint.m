//
// Created by CPU11808 on 9/30/19.
// Copyright (c) 2019 CPU11808. All rights reserved.
//

#import "UnsplashEndPoint.h"
#import "NetworkingManager.h"
#import "AppConfigs.h"


#define UnsplashRootURL @"https://api.unsplash.com"

@interface UnsplashEndPoint ()
@property(nonatomic, copy) NSString *requestMethod;
@property(nonatomic, copy) NSString * routePath;
@property (nonatomic, strong) NSMutableDictionary * header;
@property(nonatomic, strong) NSMutableURLRequest *request;
@end

@implementation UnsplashEndPoint {

}

- (instancetype)initWithEndPoint:(enum EndPoint)endPointRequest {
    self = [super init];
    if (self) {
        self.endPointRequest = endPointRequest;
    }

    return self;
}

+ (instancetype)initWithEndPoint:(enum EndPoint)endPointRequest {
    return [[self alloc] initWithEndPoint:endPointRequest];
}

- (NSString *)method {
    return self.requestMethod;
}

- (NSString *)absolutePath {
    return [NSString stringWithFormat:@"%@%@",UnsplashRootURL,self.routePath];
}

- (NSMutableDictionary *)httpHeader {
    return self.header;
}

- (NSURLRequest *)urlRequest {
    _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.absolutePath]];
    [_request setAllHTTPHeaderFields:self.httpHeader];
    [_request setHTTPMethod:self.method];
    // set params if need
    if (self.parameter){
        [_request setHTTPBody:[self httpBodyForParameters: self.parameter]];
    }

    return self.request;
}

// End point setter with updating some needed info
- (void)setEndPointRequest:(enum EndPoint)endPointRequest {
    _endPointRequest = endPointRequest;
    // setup all needed info for a specific request endpoint
    self.header = [NSMutableDictionary dictionaryWithDictionary: @{
            @"Authorization":[NSString stringWithFormat:@"Client-ID %@",ACCESS_KEY]
    }] ;

    switch (endPointRequest){
        case UnsplashEndPointGetPhotos:
            self.requestMethod = GET;
            self.routePath = @"/photos";
    }
}

- (NSData *)httpBodyForParameters:(NSDictionary *)parameters {
    NSMutableArray *parameterArray = [NSMutableArray array];

    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *param = [NSString stringWithFormat:@"%@=%@", [self percentEscapeString:key], [self percentEscapeString:obj]];
        [parameterArray addObject:param];
    }];

    NSString *string = [parameterArray componentsJoinedByString:@"&"];

    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

/** Percent escapes values to be added to a URL query as specified in RFC 3986.
 
 See http://www.ietf.org/rfc/rfc3986.txt
 @param string The string to be escaped.
 @return The escaped string.
 */
- (NSString *)percentEscapeString:(NSString *)string {
    NSCharacterSet *allowed = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~"];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowed];
}


@end
