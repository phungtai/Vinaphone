//
//  KHSPEntity.h
//  VinaphoneSale
//
//  Created by comic on 7/19/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComboEntity : NSObject
@property NSInteger  code;
@property (strong, nonatomic)  NSString *displayValue;
+(NSString*) getDisplayValue:(NSArray*) data withCode:(NSInteger)code;
+(NSInteger) getSelectedIndex:(NSArray*) data withCode:(NSInteger)code;
+(NSArray*) initComboWithData:(NSArray*) data keyCode:(NSString*)code keyValue:(NSString*) displayValue;
@end