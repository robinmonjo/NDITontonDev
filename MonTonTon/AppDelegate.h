//
//  AppDelegate.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/1/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDIServerCallManager.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, NDIServerCallManagerDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
