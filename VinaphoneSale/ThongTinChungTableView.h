//
//  ThongTinChungTableViewController.h
//  VinaphoneSale
//
//  Created by comic on 7/21/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThongTinChungTableView : UITableView
@property (weak, nonatomic) IBOutlet UILabel *txtCreateDate;
@property (weak, nonatomic) IBOutlet UITextField *txtSoCV;
@property (weak, nonatomic) IBOutlet UITextField *txtProduct;
@property (weak, nonatomic) IBOutlet UITextField *txtAction;
@property (weak, nonatomic) IBOutlet UITextField *txtReseller;
@property (weak, nonatomic) IBOutlet UITextField *txtDistributor;
@property (weak, nonatomic) IBOutlet UITextField *txtStock;
@property (weak, nonatomic) IBOutlet UITextField *txtStaff;
@property (weak, nonatomic) IBOutlet UITextField *txtReason;
@property (weak, nonatomic) IBOutlet UITextField *txtStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtApproID;
@end