//
//  RDDItemDetailViewController.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 6/1/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDDItem.h"
@interface RDDItemDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property(retain, nonatomic) NSString *validSteamID;
@end
