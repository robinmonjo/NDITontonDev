//
//  NDIPlaceAnnotation.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIPlaceAnnotation.h"

@implementation NDIPlaceAnnotation

@synthesize coordinate=_coordinate, title=_title, subTitle=_subTitle;

- (id)initWithLatitude:(CGFloat)lat latitude:(CGFloat)lon {
    if (self = [super init]) {
        self.coordinate = CLLocationCoordinate2DMake(lat, lon);
    }
    
    return self;
}


@end
