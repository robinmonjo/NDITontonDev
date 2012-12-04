//
//  NDIServerCallManager.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/1/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NDIServerCallManager;

@protocol NDIServerCallManagerDelegate <NSObject>

- (void) serverCallManager:(NDIServerCallManager *)manager didFailWithStatusCode:(NSInteger)statusCode;
- (void) serverCallManager:(NDIServerCallManager *)manager didFailWithError:(NSError *)error;
- (void) serverCallManager:(NDIServerCallManager *)manager didFinishLoading:(NSData *)result;

@end


@interface NDIServerCallManager : NSObject

@property (nonatomic, assign) id<NDIServerCallManagerDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *urlConnection;
@property (nonatomic, retain) NSMutableData *receivedData;

- (void) launchPOSTRequestAtPath:(NSString *)path withDictionary:(NSDictionary *)dictionary;
- (void) launchPUTRequestAtPath:(NSString *)path withDictionary:(NSDictionary *)dictionary;
- (void) launchDELETERequestAtPath:(NSString *)path;
- (void) launchGETRequestAtPath:(NSString *)path;

@end
