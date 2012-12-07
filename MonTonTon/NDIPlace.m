//
//  NDIPlace.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIPlace.h"

@implementation NDIPlace

@synthesize name=_name, description=_description, coordinate=_coordinate;

- (NSString *) title {
    return self.name;
}
- (NSString *) subtitle {
    return self.description;
}

@end
