//
//  RDDHomeViewController.m
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 6/2/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import "RDDHomeViewController.h"
#import "RDDViewController.h"

@interface RDDHomeViewController ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation RDDHomeViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark menu 

- (IBAction)menuAction:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"Dota_logo"],
                        [UIImage imageNamed:@"globe"]
                        
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    callout.delegate = self;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    
	switch (index) {
		case 0:
		{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [sidebar dismissAnimated:YES completion:nil];
                RDDViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"InventoryView"];
                
                [self.navigationController pushViewController:controller animated:YES];
            });
			

		}
			
			break;
			
		default:{
            [sidebar dismissAnimated:YES completion:nil];
        }
			
	}

}

-(void)callInventoryView{
    
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
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
