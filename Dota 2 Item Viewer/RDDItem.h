//
//  RDDItem.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDDItem : NSObject

@property(retain, nonatomic)NSString* name;
@property(retain, nonatomic)NSString* iconUrl;
@property(retain, nonatomic)NSString* largeUrl;
@property(retain, nonatomic)UIImage* appIcon;
@property(retain, nonatomic)UIImage* largeImage;
@property(retain, nonatomic)NSString* type;
@property(retain, nonatomic)NSNumber *tradable;
@property(retain, nonatomic)NSNumber *marketable;
@end
