//
//  NDIModel.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//


#import "NDIPlace.h"
#import <Foundation/Foundation.h>

@interface NDIModel : NSObject {
@private
    NSMutableArray *_places;
    
}

@property (nonatomic, retain) NSMutableArray *places;


+ (NDIModel *) sharedInstance;

- (void) addPlace:(NDIPlace *) place;
- (NSMutableArray *) getPlaces;
- (NDIPlace *) getPlaceWithName:(NSString *) name;

@end
