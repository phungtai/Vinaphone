//
//  AddStockKHSPTableViewCell.m
//  VinaphoneSale
//
//  Created by comic on 7/24/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddStockKHSPTableViewCell.h"
#import "StockEntity.h"
#import "CollectionDefine.h"
#import "ComboEntity.h"
@implementation AddStockKHSPTableViewCell

-(void) setData:(StockEntity *) entity withDefineData:(CollectionDefine*) collections{
    self.txtAttributeSet.text=entity.productName;
    self.txtFromSerial.text=[NSString stringWithFormat:@"%lld",entity.fromSerial];
    self.txtToSerial.text=[NSString stringWithFormat:@"%lld",entity.toSerial];
    self.txtNo.text=[NSString stringWithFormat:@"%lld",entity.toSerial-entity.fromSerial+1];
    self.txtInputNo.text=[NSString stringWithFormat:@"%lld",entity.toSerial-entity.fromSerial+1];
    self.stockEntity=entity;
  //  self.txtStatus.text = [NSString stringWithFormat:@"%ld",(long)entity.status];
}
@end