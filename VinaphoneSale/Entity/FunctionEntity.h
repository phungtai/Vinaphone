//
//  FunctionEntity.h
//  VinaphoneSale
//
//  Created by comic on 7/17/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface FunctionEntity : NSObject
@property (strong, nonatomic)  NSString *path;
@property (strong, nonatomic)  NSString *permission;
@property (strong, nonatomic)  NSString *icon;
@property (strong, nonatomic)  NSString *title;
@property (strong, nonatomic)  UIColor *backgroundColor;
-(instancetype)initWithData: (NSDictionary*) data ;
@end