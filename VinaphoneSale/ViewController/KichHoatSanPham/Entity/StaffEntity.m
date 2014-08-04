//
//  StaffEntity.m
//  VinaphoneSale
//
//  Created by comic on 7/21/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaffEntity.h"

@implementation StaffEntity

+(NSString*) getDisplayValue:(NSArray*) data withStaffID:(NSInteger)staffID {
    for (int i=0; i<data.count; i++) {
        StaffEntity *entity=[data objectAtIndex:i];
        if (entity.staffID==staffID) {
            return entity.displayValue;
        }
    }
    return @"";
}
+(NSInteger) getSelectedIndex:(NSArray*) data withCode:(NSInteger)staffID {
    for (int i=0; i<data.count; i++) {
        StaffEntity *entity=[data objectAtIndex:i];
        if (entity.staffID==staffID) {
            return i;
        }
    }
    return 0;
}

@end