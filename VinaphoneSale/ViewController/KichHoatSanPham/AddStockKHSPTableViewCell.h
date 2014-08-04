//
//  KHSPTableViewCell.h
//  VinaphoneSale
//
//  Created by comic on 7/19/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockEntity.h"
#import "CollectionDefine.h"
@interface AddStockKHSPTableViewCell: UITableViewCell
@property (weak, nonatomic)IBOutlet UILabel *txtAttributeSet;
@property (weak, nonatomic)IBOutlet UILabel *txtFromSerial;
@property (weak, nonatomic)IBOutlet UILabel *txtToSerial;
@property (weak, nonatomic)IBOutlet UILabel *txtNo;
@property (weak, nonatomic)IBOutlet UITextField *txtInputNo;
@property (weak, nonatomic)IBOutlet UIButton *btnAdd;
@property (strong,nonatomic) StockEntity *stockEntity;
@property (strong, nonatomic)IBOutlet UIButton *btnCancel;
-(void) setData:(StockEntity *) entity withDefineData:(CollectionDefine*) collections;
@end