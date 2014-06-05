//
//  RDDItemsModel.h
//  Dota 2 Item Viewer
//
//  Created by Cesar Redondo on 5/31/14.
//  Copyright (c) 2014 Redondo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDDItem.h"


@class RDDItemsModel;

@protocol ItemsDelegate <NSObject>

@required
-(void) finishPrint:(NSMutableArray *) items;

@end

@interface RDDItemsModel : NSObject{
}
@property (nonatomic,assign) id<ItemsDelegate> delegate;

-(void)getSteamInventoryBySteamId:(NSString *)steamId;



@end
