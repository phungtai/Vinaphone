//
//  StockEntity.h
//  VinaphoneSale
//
//  Created by comic on 7/23/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockEntity : NSObject<NSCopying>

@property (strong, nonatomic)  NSString *expDate;
@property (strong, nonatomic)  NSString *productName;
@property (strong, nonatomic)  NSString *transDate;
@property (strong, nonatomic)  NSString *issueDate;
@property NSInteger attributeSetID;
@property long long fromSerial;
@property NSInteger productID;
@property NSInteger productStatus;
@property NSInteger quantity;
@property NSInteger staffID;
@property NSInteger stockID;
@property NSInteger stockSerialID;
@property NSInteger stockTransID;
@property long long toSerial;
@property NSInteger status;
-(id) copyWithZone: (NSZone *) zone;
-(NSDictionary*) getDictionary ;
@end