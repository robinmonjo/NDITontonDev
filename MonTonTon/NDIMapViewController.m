//
//  NDIMapViewController.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/4/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIMapViewController.h"
#import "NDIPlaceAnnotation.h"

@interface NDIMapViewController ()

@end

@implementation NDIMapViewController

@synthesize mapView=_mapView, displayedPlaces=_displayedPlaces;


- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}

//more: http://developer.apple.com/library/ios/#documentation/MapKit/Reference/MKMapViewDelegate_Protocol/MKMapViewDelegate/MKMapViewDelegate.html
//http://developer.apple.com/library/ios/#documentation/MapKit/Reference/MKMapView_Class/MKMapView/MKMapView.html

- (void) dropPins {
    for (NDIPlaceAnnotation *anno in self.displayedPlaces) {
        [self.mapView addAnnotation:anno];
    }
    CLLocationCoordinate2D zoomLocation = ((NDIPlaceAnnotation*)[self.displayedPlaces lastObject]).coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    [self.mapView setRegion:viewRegion animated:YES];
}


@end
