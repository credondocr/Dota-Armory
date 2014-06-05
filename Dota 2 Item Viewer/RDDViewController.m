//
//  RDDViewController.m
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import "RDDViewController.h"
#import "RDDSteamValidator.h"
#import "RDDItemsViewController.h"
#define kCustomRowCount     7
@interface RDDViewController ()
@property(strong, nonatomic)RDDSteamValidator *validator;
@end

@implementation RDDViewController

- (void)viewDidLoad
{
	_validator = [[RDDSteamValidator alloc]init];
    [super viewDidLoad];
	
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (IBAction)searchSteamInventory:(id)sender {
	
		
	if ([_validator isValidSteamAccount:_steamId.text]) {
		
		RDDItemsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"itemsView"];
		controller.validSteamID = _steamId.text;
		[self.navigationController pushViewController:controller animated:YES];
		
	}
	else{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Invalid"
															message:@"You must check your steam id."
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
			[alert show];
			
	}
	
}





- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[[self view] endEditing:YES];
}

@end
