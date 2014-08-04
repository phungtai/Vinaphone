//
//  StockEntity.m
//  VinaphoneSale
//
//  Created by comic on 7/23/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockEntity.h"

@implementation StockEntity
-(id) copyWithZone: (NSZone *) zone
{
    StockEntity *entityCopy = [[StockEntity allocWithZone: zone] init];
    
    entityCopy.expDate=self.expDate;
    entityCopy.fromSerial=self.fromSerial;
    entityCopy.toSerial=self.toSerial;
    entityCopy.productName=self.productName;
    entityCopy.transDate=self.transDate;
    entityCopy.issueDate=self.issueDate;
    entityCopy.attributeSetID=self.attributeSetID;
    entityCopy.productID=self.productID;
    entityCopy.productStatus=self.productStatus;
    entityCopy.quantity=self.quantity;
    entityCopy.staffID=self.staffID;
    entityCopy.stockID=self.stockID;
    entityCopy.stockSerialID=self.stockSerialID;
    entityCopy.stockTransID=self.stockTransID;
    entityCopy.status = self.status;
    return entityCopy;
}
-(NSDictionary*) getDictionary {
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];

    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.attributeSetID ] forKey:@"ATTRIBUTE_SET_ID"];
    [dic setObject: self.expDate forKey:@"EXP_DATE"];
    [dic setValue:self.productName forKey:@"PRODUCT_NAME"];
    [dic setObject:[NSString stringWithFormat:@"%lld", self.fromSerial ] forKey:@"FROM_SERIAL"];
    [dic setObject:[NSString stringWithFormat:@"%lld", self.toSerial ] forKey:@"TO_SERIAL"];
    [dic setObject:self.transDate  forKey:@"ORG_TRANS_DATE"];
    [dic setObject:self.issueDate  forKey:@"ISSUE_DATE"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.productID ] forKey:@"PRODUCT_ID"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.productStatus ] forKey:@"PRODUCT_STATUS"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.quantity ] forKey:@"QUANTITY"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.staffID ] forKey:@"STAFF_ID"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.stockSerialID ] forKey:@"STOCK_SERIAL_ID"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.stockID ] forKey:@"STOCK_ID"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.stockTransID ] forKey:@"STOCK_TRANS_ID"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long) self.status] forKey:@"STATUS"];
    return dic;
}

@end