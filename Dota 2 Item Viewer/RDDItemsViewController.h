//
//  RDDItemsViewController.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDDItemsModel.h"
#import "RKiOS7Loading.h"
#import <QuartzCore/QuartzCore.h>
@interface RDDItemsViewController : UITableViewController<ItemsDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property(retain, nonatomic) NSString *validSteamID;
@property(retain, nonatomic)NSMutableArray *data;

@property (strong,nonatomic) NSMutableArray *filteredItemsArray;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

-(void)printItems;
@end
