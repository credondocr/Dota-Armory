//
//  RDDDetailsViewController.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 6/1/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDDItem.h"
@interface RDDDetailsViewController : UIViewController

@property(strong, nonatomic)RDDItem *item;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tradableLable;
@property (weak, nonatomic) IBOutlet UILabel *marketableLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

