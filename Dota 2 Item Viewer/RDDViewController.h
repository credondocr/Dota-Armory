//
//  RDDViewController.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDDItemsModel.h"


@interface RDDViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *search;

@property (weak, nonatomic) IBOutlet UITextField *steamId;





- (IBAction)searchSteamInventory:(id)sender;

@end
