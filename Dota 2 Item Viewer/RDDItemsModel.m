//
//  RDDItemsModel.m
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import "RDDItemsModel.h"
#import "RDDItem.h"
static NSString* const kLocations = @"locations";

@implementation RDDItemsModel
@synthesize delegate;


-(id)init{
	self = [super init];
	return self;
	
}

-(void)getSteamInventoryBySteamId:(NSString *)steamId{
	
	NSString *urlWithSteamId = [NSString stringWithFormat:@"http://steamcommunity.com/id/%@/inventory/json/570/2", steamId];

	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlWithSteamId]];
	NSMutableArray* items = [NSMutableArray array];
		
	__block NSDictionary *json;
	[NSURLConnection sendAsynchronousRequest:request
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   json = [NSJSONSerialization JSONObjectWithData:data
																	  options:0
																		error:nil];
							  							   
							   NSArray* keys = [json allKeys];
							   for(NSString* key in keys) {
								   if ([key isEqualToString:@"rgDescriptions"]) {
									   NSDictionary* itemsDescription = [json objectForKey:key];
									   
									   NSArray *itemsCollected = [itemsDescription allKeys];
									   for (NSString* itemCollected in itemsCollected) {
										   
										   RDDItem* item = [[RDDItem alloc] init];
										   item.name =[ [itemsDescription objectForKey:itemCollected] objectForKey:@"name"];
										   item.type = [ [itemsDescription objectForKey:itemCollected] objectForKey:@"type"];
										   NSString *url = [NSString stringWithFormat:@"%@%@",@"http://cdn.steamcommunity.com/economy/image/", [[itemsDescription objectForKey:itemCollected] objectForKey:@"icon_url"] ];
										   
										   item.iconUrl = url;
										   NSString *largeurl = [NSString stringWithFormat:@"%@%@",@"http://cdn.steamcommunity.com/economy/image/", [[itemsDescription objectForKey:itemCollected] objectForKey:@"icon_url_large"] ];
										   
										   item.largeUrl = largeurl;
										   
										   item.marketable =[ [itemsDescription objectForKey:itemCollected] objectForKey:@"marketable"];
										   
										   item.tradable =[ [itemsDescription objectForKey:itemCollected] objectForKey:@"tradable"];
										
										  
										   
										   [items addObject:item];

										   

									   }
									    
									   									   
								   }
							   }
							  
							   [delegate finishPrint:items];
						   }];

}

@end
