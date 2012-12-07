//
//  NDIPlace.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NDIPlace : NSObject <MKAnnotation> {
@private
    NSString *_name;
    NSString *_description;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (NSString *) title;
- (NSString *) subtitle;

@end
