//
//  NDITableViewController.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDIModel.h"
#import "NDIMapViewController.h"

@interface NDITableViewController : UITableViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
@private
    UISearchBar *_searchBar;
    UIBarButtonItem *_searchButton;
    UIBarButtonItem *_cancelSearchButton;
        
    BOOL _searchBarIsOn;
    BOOL _isFiltering;
    NSMutableArray *_tableData;
    NSMutableArray *_filteredTableData;
    
    NDIMapViewController *_mapViewController;
    
}

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UIBarButtonItem *searchButton;
@property (nonatomic, retain) UIBarButtonItem *cancelSearchButton;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (nonatomic, retain) NSMutableArray *filteredTableData;
@property (nonatomic, retain) NDIMapViewController *mapViewController;

@end
