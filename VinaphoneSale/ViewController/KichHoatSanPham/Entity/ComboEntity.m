//
//  KHSPResellerEntity.m
//  VinaphoneSale
//
//  Created by comic on 7/21/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComboEntity.h"

@implementation ComboEntity
+(NSString*) getDisplayValue:(NSArray*) data withCode:(NSInteger) code {
    for (int i=0; i<data.count; i++) {
        ComboEntity *entity=[data objectAtIndex:i];
        if (entity.code==code) {
            return entity.displayValue;
        }
    }
    return @"";
}
+(NSInteger) getSelectedIndex:(NSArray*) data withCode:(NSInteger)code {
    for (int i=0; i<data.count; i++) {
        ComboEntity *entity=[data objectAtIndex:i];
        if (entity.code==code) {
            return i;
        }
    }
    return 0;
}
+(NSArray*) initComboWithData:(NSArray*) data keyCode:(NSString*)code keyValue:(NSString*) displayValue {
    NSMutableArray *combo=[[NSMutableArray alloc] initWithCapacity:10];
//    ComboEntity *allEntity=[ComboEntity alloc];
//    allEntity.code=-1;
//    allEntity.displayValue=@"Tất cả";
//    [combo addObject:allEntity];
    for (int i=0; i<data.count; i++) {
        ComboEntity *entity=[ComboEntity alloc];
        entity.code=[[[data objectAtIndex:i] objectForKey:code] integerValue];
        entity.displayValue=[[data objectAtIndex:i] objectForKey:displayValue];
        [combo addObject:entity];
    }
    return combo;
}
@end