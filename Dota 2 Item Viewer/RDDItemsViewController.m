//
//  RDDItemsViewController.m
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import "RDDItemsViewController.h"
#import "RDDItem.h"
#import "RDDItemsModel.h"
#import "IconDownloader.h"
#import "RDDDetailsViewController.h"

#define kCustomRowCount     7

@interface RDDItemsViewController ()<UIScrollViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate>{
	
}
@property(retain, nonatomic)NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;


@end

@implementation RDDItemsViewController
@synthesize data;
@synthesize filteredItemsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
	
	
	
    return self;
}

-(void)printItems{
	
	
	[self.tableView reloadData];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	//To show the Indicator
    [RKiOS7Loading showHUDAddedTo:self.view animated:YES];
    
    

	// Don't show the scope bar or cancel button until editing begins
    [_searchBar setShowsScopeBar:NO];
    [_searchBar sizeToFit];
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + _searchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];

	
	self.searchBar.delegate = self;
	self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor blackColor];
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(sortItems)];
	self.navigationItem.rightBarButtonItem = anotherButton;
	

	[self.tableView setBackgroundColor: [UIColor clearColor]];
	[self.tableView setOpaque: YES];
	RDDItemsModel *myitemsModel = [[RDDItemsModel alloc]init];
	[myitemsModel setDelegate:self];
	self.tableView.dataSource = self;
	[myitemsModel getSteamInventoryBySteamId:_validSteamID];
	self.searchBar.showsCancelButton = YES;
	// Initialize the filteredCandyArray with a capacity equal to the candyArray's capacity
    filteredItemsArray = [NSMutableArray arrayWithCapacity:[data count]];
	
	// Reload the table
    [[self tableView] reloadData];
	
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredItemsArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    NSArray *tempArray = [data filteredArrayUsingPredicate:predicate];
    
    filteredItemsArray = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}



#pragma mark Search methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
   
	[self.tableView setContentOffset:CGPointMake(0, 0 ) animated:YES];
    [self.searchBar resignFirstResponder];
	
}

-(void)sortItems{

	 [self.searchBar becomeFirstResponder];
}



-(void)finishPrint:(NSMutableArray *)items{
	data = items;
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	//Call the method to hide the Indicator after 3 seconds
    [self performSelector:@selector(stopRKLoading) withObject:nil afterDelay:0];
	[self.tableView reloadData];
}

-(void)stopRKLoading
{
    [RKiOS7Loading hideHUDForView:self.view animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Table View Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RDDItem *item = nil;
	
    RDDDetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
	
	if(tableView == self.searchDisplayController.searchResultsTableView)
	{
		item = [filteredItemsArray objectAtIndex:[indexPath row]];
	}else{
		item = [data objectAtIndex:[indexPath row]];
	}
	
	controller.item = item;
	[self.navigationController pushViewController:controller animated:YES];
	
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	RDDItem *object = nil;
	
	if(tableView == self.searchDisplayController.searchResultsTableView)
	{
		object = [filteredItemsArray objectAtIndex:[indexPath row]];
		cell.backgroundColor = [UIColor blackColor];
		cell.textLabel.textColor = [UIColor whiteColor];
	}else{
		object = [data objectAtIndex:[indexPath row]];
	}
	
	cell.textLabel.text =  object.name;
	cell.detailTextLabel.text = object.type;
	
	// Only load cached images; defer new downloads until scrolling ends
	if (!object.appIcon)
	{
		if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
		{
			[self startIconDownload:object forIndexPath:indexPath];
		}
		// if a download is deferred or in progress, return a placeholder image
		cell.imageView.image = [UIImage imageNamed:@"Placeholder"];
	}
	else
	{
		cell.imageView.image = object.appIcon;
	}
	
    // Configure the cell
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredItemsArray count];
    }
	else
	{
        return [data count];
    }
}


#pragma mark - UIScrollViewDelegate Lazy loading


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	
	
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

- (void)loadImagesForOnscreenRows
{
		
    if ([self.data count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            RDDItem *appRecord = [self.data objectAtIndex:indexPath.row];
            
            if (!appRecord.appIcon)
				// Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark Downloading Images

- (void)startIconDownload:(RDDItem *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.imageView.image = appRecord.appIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        [self.imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
