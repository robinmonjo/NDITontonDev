//
//  NDISlideShowViewController.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/3/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDISlideShowViewController : UIViewController <UIScrollViewDelegate> {
@private
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    BOOL pageControlBeingUsed;
    NSMutableArray *views;
    
    NSString *textTitle;
    
}

@property (nonatomic, retain) NSString *textTitle;



@end
