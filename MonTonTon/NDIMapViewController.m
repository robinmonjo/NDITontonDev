//
//  NDIMapViewController.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/4/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIMapViewController.h"

@interface NDIMapViewController ()

@end

@implementation NDIMapViewController

@synthesize mapView=_mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    [self.mapView setRegion:viewRegion animated:YES];
}

//more: http://developer.apple.com/library/ios/#documentation/MapKit/Reference/MKMapViewDelegate_Protocol/MKMapViewDelegate/MKMapViewDelegate.html
//http://developer.apple.com/library/ios/#documentation/MapKit/Reference/MKMapView_Class/MKMapView/MKMapView.html


@end
