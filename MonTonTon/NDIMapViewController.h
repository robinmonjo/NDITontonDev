//
//  NDIMapViewController.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/4/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NDIMapViewController : UIViewController {
@private
    MKMapView *_mapView;
    
}

@property (nonatomic, retain) MKMapView *mapView;

@end
