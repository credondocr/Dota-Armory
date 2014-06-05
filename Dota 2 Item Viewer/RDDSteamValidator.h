//
//  RDDSteamValidator.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDDSteamValidator : NSObject

-(BOOL)isValidSteamAccount:(NSString *) steamId;
@end
