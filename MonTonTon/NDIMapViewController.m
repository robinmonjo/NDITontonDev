//
//  NDIMapViewController.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/4/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDIMapViewController.h"
#import "NDIPlaceAnnotationView.h"
#import "NDIPlace.h"
#import "NDISlideShowViewController.h"

@interface NDIMapViewController ()

@end

@implementation NDIMapViewController

@synthesize mapView=_mapView, displayedPlaces=_displayedPlaces;


- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.displayedPlaces = [NSMutableArray array];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = detailButton;
    
    UIImage *image = [UIImage imageNamed:@"effel.jpeg"];
    CGFloat maxSize = image.size.width > image.size.height ? image.size.width : image.size.height;
    CGFloat scaleFactor = maxSize/35;
    UIImage *scaledImage = [UIImage imageWithCGImage:[image CGImage] scale:scaleFactor orientation:UIImageOrientationUp];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:scaledImage];
    
    annotationView.leftCalloutAccessoryView = imageView;
    
    
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NDISlideShowViewController *slideShow = [[NDISlideShowViewController alloc] init];
    slideShow.textTitle = ((NDIPlace *)view.annotation).name;
    UINavigationController *navSlideShow = [[UINavigationController alloc] initWithRootViewController:slideShow];
    navSlideShow.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navSlideShow animated:YES completion:nil];
}

- (void) refreshDroppedPins {
    //no really nice here but NDI so ...
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (NDIPlace *place in self.displayedPlaces) {
        [self.mapView addAnnotation:place];
    }
    
    CLLocationCoordinate2D zoomLocation;
    
    if (self.displayedPlaces.count > 0) {
        zoomLocation = ((NDIPlace*)[self.displayedPlaces lastObject]).coordinate;
    }
    else {
        zoomLocation = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude,
                                                  self.mapView.userLocation.coordinate.longitude);
    }
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    [self.mapView setRegion:viewRegion animated:YES];
}


@end
