//
//  FunctionEntity.m
//  VinaphoneSale
//
//  Created by comic on 7/17/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionEntity.h"
#import "VnpSaleUtils.h"
@implementation FunctionEntity
@synthesize title=_title,permission=_permission,icon=_icon,backgroundColor=_backgroundColor,path=_path;
-(instancetype)initWithData: (NSDictionary*) data {
    _path=[data objectForKey:@"PATH"];
    _permission=[data objectForKey:@"RIGHT_CODE"];
    _icon=[VnpSaleUtils getImageIconWithPath:_path permission:_permission];
    _backgroundColor=[VnpSaleUtils getBackgroundColorWithPath:_path permission:_permission];
    _title=[VnpSaleUtils getTitleWithPath:_path permission:_permission];
    return self;
}

@end