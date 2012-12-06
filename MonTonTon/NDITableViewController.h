//
//  NDITableViewController.h
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDITableViewController : UITableViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate> {
@private
    UISearchBar *_searchBar;
    UIBarButtonItem *_searchButton;
    UIBarButtonItem *_cancelSearchButton;
        
    BOOL _searchBarIsOn;
    BOOL _isFiltering;
    NSMutableArray *_tableData;
    NSMutableArray *_filteredTableData;
    
}

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UIBarButtonItem *searchButton;
@property (nonatomic, retain) UIBarButtonItem *cancelSearchButton;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (nonatomic, retain) NSMutableArray *filteredTableData;

@end
