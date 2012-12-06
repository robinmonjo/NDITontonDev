//
//  NDIModel.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIModel.h"

@implementation NDIModel

@synthesize places=_places;

static NDIModel *sharedInstance;

+ (NDIModel *) sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id) init {
    if (self = [super init]) {
        self.places = [NSMutableArray array];
    }
    return self;
}

- (void) addPlace:(NDIPlace *) place {
    [self.places addObject:place];
}

- (NSMutableArray *) getPlaces {
    return self.places;
}

- (NDIPlace *) getPlaceWithName:(NSString *) name {
    for (NDIPlace *place in self.places) {
        if ([place.name isEqualToString:name]) {
            return place;
        }
    }
    return nil;
}




@end
