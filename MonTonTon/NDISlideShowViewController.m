//
//  NDISlideShowViewController.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/3/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDISlideShowViewController.h"

@interface NDISlideShowViewController ()

@end

@implementation NDISlideShowViewController


#define NB_PAGE 7

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //Setting up scroll view
    CGRect scrollFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    scrollView.backgroundColor = [UIColor underPageBackgroundColor];
    [scrollView setScrollEnabled:YES];
    [scrollView setPagingEnabled:YES];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    views = [NSMutableArray arrayWithCapacity:NB_PAGE];
    
    for (NSInteger i = 0; i < NB_PAGE; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor redColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = 1;
        label.text = [NSString stringWithFormat:@"SLIDE %i",i];
        
        [views addObject:label];
        
        [scrollView addSubview:label];
    }
        
    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] init];

    
    [pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    
    pageControl.numberOfPages = NB_PAGE;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    
    [self alignSubviews];
}

- (void)alignSubviews {
	// Position all the content views at their respective page positions
	scrollView.contentSize = CGSizeMake(NB_PAGE*scrollView.bounds.size.width,
										scrollView.bounds.size.height);
	NSUInteger i = 0;
	for (UIView *v in views) {
		v.frame = CGRectMake(i * scrollView.bounds.size.width, 0,
							 scrollView.bounds.size.width, scrollView.bounds.size.height);
		i++;
	}
    
    CGSize requiredSize = [pageControl sizeForNumberOfPages:NB_PAGE];
    CGRect frame;
    frame.origin.x = self.view.bounds.size.width/2 - requiredSize.width/2;
    frame.origin.y = scrollView.bounds.size.height - 30;
    frame.size = CGSizeMake(requiredSize.width, requiredSize.height);
    [pageControl setFrame:frame];
}

//UIPageControl action
- (void) changePage {
    CGRect frame;
    frame.origin.x = scrollView.frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = scrollView.frame.size;
    [scrollView scrollRectToVisible:frame animated:YES];
    
    pageControlBeingUsed = YES;
}

//Scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(pageControlBeingUsed) return;
    pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration {
	pageControl.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
										 duration:(NSTimeInterval)duration {
	[self alignSubviews];
	scrollView.contentOffset = CGPointMake(pageControl.currentPage * scrollView.bounds.size.width, 0);
}


@end
