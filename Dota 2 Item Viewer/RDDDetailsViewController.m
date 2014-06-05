//
//  RDDDetailsViewController.m
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 6/1/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import "RDDDetailsViewController.h"

@interface RDDDetailsViewController ()

@end

@implementation RDDDetailsViewController
@synthesize item;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.name.text = item.name;
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.largeUrl]]];
	self.image.image = image;
	
	if ([item.marketable boolValue]) {
		self.marketableLable.enabled = true;
		
	}
	
	if ([item.tradable boolValue]) {
		self.tradableLable.enabled = TRUE;
		
	}
	
	self.typeLabel.text = item.type;
	
		
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
