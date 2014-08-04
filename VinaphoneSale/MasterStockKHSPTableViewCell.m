//
//  AddStockKHSPTableViewCell.m
//  VinaphoneSale
//
//  Created by comic on 7/24/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterStockKHSPTableViewCell.h"
#import "StockEntity.h"
#import "CollectionDefine.h"
#import "ComboEntity.h"
@implementation MasterStockKHSPTableViewCell

-(void) setData:(StockEntity *) entity withDefineData:(CollectionDefine*) collections{
    self.txtAttributeSet.text=entity.productName;
    self.txtFromSerial.text=[NSString stringWithFormat:@"%lld",entity.fromSerial];
    self.txtCreateDate.text=entity.issueDate;
    self.txtToSerial.text=[NSString stringWithFormat:@"%lld",entity.toSerial];
    self.txtNo.text=[NSString stringWithFormat:@"%lld",entity.toSerial-entity.fromSerial+1];
    if (entity.status == 0) {
        self.txtStatus.text = @"Lỗi";
    }else if (entity.status == 1){
        self.txtStatus.text = @"Hoàn tất";
    }else{
        self.txtStatus.text = @"Tạo mới";
    }
    

}
@end