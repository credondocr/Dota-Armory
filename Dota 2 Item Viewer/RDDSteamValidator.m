//
//  RDDSteamValidator.m
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import "RDDSteamValidator.h"
#import "XMLReader.h"

@implementation RDDSteamValidator


-(BOOL)isValidSteamAccount:(NSString *)steamId{
	
	NSError *error = nil;
	NSURL* url = [NSURL URLWithString: [NSString stringWithFormat:@"http://steamcommunity.com/id/%@/?xml=1&l=english", steamId ]];
	
	NSString* c = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
	
	
	NSData* xmlData = [c dataUsingEncoding:NSUTF8StringEncoding];
	
	NSDictionary *dics=[XMLReader dictionaryForXMLData:xmlData error:&	error];
	return [[dics objectForKey:@"response"] objectForKey:@"error"] ==nil;
}
@end
