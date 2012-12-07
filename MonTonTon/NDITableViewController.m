//
//  NDITableViewController.m
//  MonTonTon
//
//  Created by Robin Monjo on 12/6/12.
//  Copyright (c) 2012 Robin Monjo. All rights reserved.
//

#import "NDITableViewController.h"

@interface NDITableViewController ()

- (void) showSearchBar;

@end

@implementation NDITableViewController

@synthesize searchBar=_searchBar, searchButton=_searchButton, cancelSearchButton=_cancelSearchButton, tableData=_tableData, filteredTableData=_filteredTableData, mapViewController=_mapViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableData = [NDIModel sharedInstance].places;
        
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    _searchBarIsOn = NO;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"Type a search term";
    
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    
    self.searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar)];
    self.cancelSearchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(showSearchBar)];
    
    
    self.navigationItem.rightBarButtonItem = self.searchButton;
    
    //[self.tableView reloadData];
}

- (void) showSearchBar {
    _searchBarIsOn = !_searchBarIsOn;
    
    if (_searchBarIsOn) {
        self.navigationItem.rightBarButtonItem = self.cancelSearchButton;
        self.tableView.tableHeaderView = self.searchBar;
        [self.searchBar becomeFirstResponder];
    }
    else {
        self.navigationItem.rightBarButtonItem = self.searchButton;
        self.tableView.tableHeaderView = nil;
        [self.searchBar resignFirstResponder];
        _isFiltering = NO;
        [self.tableView reloadData];
    }
    
    [self.tableView scrollRectToVisible:[[self.tableView tableHeaderView] bounds] animated:YES];
}

#pragma mark - SearchBar delegate protocol
- (void) searchBarSearchButtonClicked:(UISearchBar*) theSearchBar {
    NSLog(@"searching");

}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text {
    
    if(text.length == 0) {
        _isFiltering = NO;
    }
    else {
        _isFiltering = YES;
        self.filteredTableData = [NSMutableArray array];
        
        for (NDIPlace *place in self.tableData) {
            NSRange rangeName = [place.name rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange rangeDescr = [place.description rangeOfString:text options:NSCaseInsensitiveSearch];
            if(rangeName.location != NSNotFound || rangeDescr.location != NSNotFound) {
                [self.filteredTableData addObject:place];
            }
        }
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isFiltering) {
        return self.filteredTableData.count;
    }
    else {
        return self.tableData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_isFiltering) {
        cell.textLabel.text = ((NDIPlace *)[self.filteredTableData objectAtIndex:indexPath.row]).name;
        cell.detailTextLabel.text = ((NDIPlace *)[self.filteredTableData objectAtIndex:indexPath.row]).description;
    }
    else {
        cell.textLabel.text = ((NDIPlace *)[self.tableData objectAtIndex:indexPath.row]).name;
        cell.detailTextLabel.text = ((NDIPlace *)[self.tableData objectAtIndex:indexPath.row]).description;
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NDIPlace *selectedPlace = [[NDIModel sharedInstance] getPlaceWithName:cell.textLabel.text];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.mapViewController.displayedPlaces removeObject:selectedPlace];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.mapViewController.displayedPlaces addObject:selectedPlace];
    }
    [self.mapViewController refreshDroppedPins];
}

@end
