//
//  KHSPEntity.m
//  VinaphoneSale
//
//  Created by comic on 7/19/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHSPEntity.h"
#import "StockEntity.h"
@implementation KHSPEntity
- (KHSPEntity*) initWithDictionary:(NSDictionary*) dic{
    KHSPEntity *entity=[[KHSPEntity alloc] init];
    entity.approID=[[dic objectForKey:@"APPROVER_ID"] integerValue];
    entity.attributeID=[[dic objectForKey:@"ATTRIBUTE_SET_ID"] integerValue];
    entity.createDate=[dic objectForKey:@"CREATE_DATE"];
    entity.description=[dic objectForKey:@"DESCRIPTION"];
    entity.distributorID=[[dic objectForKey:@"DISTRIBUTOR_ID"] integerValue];
    entity.issueDate=[dic objectForKey:@"ISSUE_DATE"];
    entity.issueNo=[dic objectForKey:@"ISSUE_NO"];
    entity.productReleaseID=[[dic objectForKey:@"PRODUCT_RELEASE_ID"] integerValue];
    entity.reasonID=[[dic objectForKey:@"REASON_ID"] integerValue];
    entity.resellerID=[[dic objectForKey:@"RESELLER_ID"] integerValue];
    entity.staffID=[[dic objectForKey:@"STAFF_ID"] integerValue];
    entity.status=[[dic objectForKey:@"STATUS"] integerValue];
    entity.stockID=[[dic objectForKey:@"STOCK_ID"] integerValue];
    entity.type=[[dic objectForKey:@"TYPE"] integerValue];
    entity.userName=[dic objectForKey:@"USER_NAME"];
    return entity;
}
- (NSDictionary*) getDictionary{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.approID ] forKey:@"APPROVER_ID"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.attributeID ] forKey:@"ATTRIBUTE_SET_ID"];
    [dic setValue: self.createDate forKey:@"CREATE_DATE"];
    [dic setValue:self.description forKey:@"DESCRIPTION"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.distributorID ] forKey:@"DISTRIBUTOR_ID"];
    [dic setValue: self.issueDate  forKey:@"ISSUE_DATE"];
    [dic setValue:self.issueNo  forKey:@"ISSUE_NO"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.productReleaseID ] forKey:@"PRODUCT_RELEASE_ID"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.reasonID ] forKey:@"REASON_ID"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.resellerID ] forKey:@"RESELLER_ID"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.staffID ] forKey:@"STAFF_ID"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.status ] forKey:@"STATUS"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.stockID ] forKey:@"STOCK_ID"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long) self.type ] forKey:@"TYPE"];
    [dic setValue:self.userName forKey:@"USER_NAME"];
    return dic;
}
-(NSString*) getJSONString {
    NSError * err;
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for(int i=0;i<self.stockDetails.count; i++) {
        StockEntity *entity=[self.stockDetails objectAtIndex:i];
        entity.issueDate=self.issueDate;
        [array addObject:entity.getDictionary];
    }
    NSMutableArray *product=[[NSMutableArray alloc] init];
    
    [product addObject:self.getDictionary];
    
    [dictionary setValue:array forKey:@"PRO_RELEASE_DETAIL"];
    [dictionary setValue:product forKey:@"PRO_RELEASE"];
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (err==nil) {
        return myString;
        
    }else {
        return nil;
    }
}

@end