//
//  NDIServerCallManager.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/1/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIServerCallManager.h"

@implementation NDIServerCallManager

#define TIME_OUT 30

@synthesize delegate, urlConnection=_urlConnection, receivedData=_receivedData;

- (id) init {
    if (self = [super init]) {
        self.receivedData = [NSMutableData data];
    }
    return self;
}


#pragma mark - private methods

- (NSMutableURLRequest *) generateURLRequestWithHTTPMethod:(NSString*)httpMetthod dictionary:(NSDictionary *)dict atPath:(NSString *)path {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIME_OUT];
    if (dict) { //a delete or a get doesn't need body
        NSData *requestBodyData = [@"body" dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *requestLenght = [NSString stringWithFormat:@"%i", requestBodyData.length];
        request.HTTPBody = requestBodyData;
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:requestLenght forHTTPHeaderField:@"Content-Lenght"];
    }
    request.HTTPMethod = httpMetthod;
    request.HTTPShouldHandleCookies = NO;
    return request;
}

- (void) startConnectionWithRequest:(NSMutableURLRequest *)request {
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - Public methods
- (void) launchPOSTRequestAtPath:(NSString *)path withDictionary:(NSDictionary *)dictionary {
    NSMutableURLRequest *request = [self generateURLRequestWithHTTPMethod:@"POST" dictionary:dictionary atPath:path];
    [self startConnectionWithRequest:request];
}

- (void) launchPUTRequestAtPath:(NSString *)path withDictionary:(NSDictionary *)dictionary {
    NSMutableURLRequest *request = [self generateURLRequestWithHTTPMethod:@"PUT" dictionary:dictionary atPath:path];
    [self startConnectionWithRequest:request];
}

- (void) launchDELETERequestAtPath:(NSString *)path {
    NSMutableURLRequest *request = [self generateURLRequestWithHTTPMethod:@"DELETE" dictionary:nil atPath:path];
    [self startConnectionWithRequest:request];
}

- (void) launchGETRequestAtPath:(NSString *)path {
    NSMutableURLRequest *request = [self generateURLRequestWithHTTPMethod:@"GET" dictionary:nil atPath:path];
    [self startConnectionWithRequest:request];
}


#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"username"
                                                             password:@"pwd"
                                                          persistence:NSURLCredentialPersistenceNone];
	[challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode != 200 && httpResponse.statusCode != 201) {
        [connection cancel];
        [self.delegate serverCallManager:self didFailWithStatusCode:httpResponse.statusCode];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.receivedData = nil;
    [self.delegate serverCallManager:self didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    id result = self.receivedData;
    [self.delegate serverCallManager:self didFinishLoading:result];
    [self.receivedData setLength:0];
}

@end
