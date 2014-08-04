//
//  StaffEntity.h
//  VinaphoneSale
//
//  Created by comic on 7/21/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffEntity : NSObject
@property NSInteger staffID;
@property (strong, nonatomic)  NSString *staffCode;
@property (strong, nonatomic)  NSString *displayValue;
+(NSString*) getDisplayValue:(NSArray*) data withStaffID:(NSInteger)staffID;
+(NSInteger) getSelectedIndex:(NSArray*) data withCode:(NSInteger)staffID;
@end