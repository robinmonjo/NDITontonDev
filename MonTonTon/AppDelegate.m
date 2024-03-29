//
//  AppDelegate.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/1/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "AppDelegate.h"
#import "NDISlideShowViewController.h"
#import "NDIMapViewController.h"
#import "NDITableViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self loadTestModel];
    
    NDIMapViewController *mapVC = [[NDIMapViewController alloc] init];
    UINavigationController *navMap = [[UINavigationController alloc] initWithRootViewController:mapVC];

    NDITableViewController *tableVC = [[NDITableViewController alloc] init];
    tableVC.mapViewController = mapVC;
    UINavigationController *navTable = [[UINavigationController alloc] initWithRootViewController:tableVC];
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.delegate = self;
    splitVC.viewControllers = [NSArray arrayWithObjects:navTable, navMap, nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = splitVC;
    
    [self.window makeKeyAndVisible];
    
    /*NDIServerCallManager *netManager = [[NDIServerCallManager alloc] init];
    netManager.delegate = self;
    [netManager launchGETRequestAtPath:@"http://www.eurosport.fr"];*/
    
    return YES;
}

- (void) loadTestModel {
    
    NDIPlace *place = [[NDIPlace alloc] init];
    place.name = @"santiago";
    place.description = @"the place to beach";
    place.coordinate = CLLocationCoordinate2DMake(39.281516, -76.580806);
    [[NDIModel sharedInstance] addPlace:place];
    
    NDIPlace *place1 = [[NDIPlace alloc] init];
    place1.name = @"jelio";
    place1.description = @"great place for ...";
    place1.coordinate = CLLocationCoordinate2DMake(19.281516, -36.580806);
    [[NDIModel sharedInstance] addPlace:place1];
    
    NDIPlace *place2 = [[NDIPlace alloc] init];
    place2.name = @"gabrute";
    place2.description = @"tlace to beach";
    place2.coordinate = CLLocationCoordinate2DMake(99.281516, 16.580806);
    [[NDIModel sharedInstance] addPlace:place2];
    
    NDIPlace *place3 = [[NDIPlace alloc] init];
    place3.name = @"santiagoLosA";
    place3.description = @"the place to beach";
    place3.coordinate = CLLocationCoordinate2DMake(239.281516, -126.580806);
    [[NDIModel sharedInstance] addPlace:place3];
    
    NDIPlace *place4 = [[NDIPlace alloc] init];
    place4.name = @"tignes";
    place4.description = @"ski place to beach";
    place4.coordinate = CLLocationCoordinate2DMake(67.281516, 24.580806);
    [[NDIModel sharedInstance] addPlace:place4];
    
    NDIPlace *place5 = [[NDIPlace alloc] init];
    place5.name = @"serto";
    place5.description = @"sarte ce to beach";
    place5.coordinate = CLLocationCoordinate2DMake(39.281516, -76.580806);
    [[NDIModel sharedInstance] addPlace:place5];
    
    
}

//----------------------------------------------------------

- (void) serverCallManager:(NDIServerCallManager *)manager didFailWithStatusCode:(NSInteger)statusCode {
    NSLog(@"status code %i", statusCode);
}
- (void) serverCallManager:(NDIServerCallManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"fail %@", error.debugDescription);
}
- (void) serverCallManager:(NDIServerCallManager *)manager didFinishLoading:(NSData *)result {
    NSLog(@"---< %@",[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]);
}

//-----------------------------------------------------------

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
