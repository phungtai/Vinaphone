//
//  KHSPTableViewCell.h
//  VinaphoneSale
//
//  Created by comic on 7/19/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KHSPTableViewCell: UITableViewCell
@property (weak, nonatomic)IBOutlet UIButton *btnXem;
@property (weak, nonatomic)IBOutlet UILabel *txtSoCV;
@property (weak, nonatomic)IBOutlet UILabel *txtCreateDate;
@property (weak, nonatomic)IBOutlet UILabel *txtReseller;
@property (weak, nonatomic)IBOutlet UILabel *txtStock;
@property (weak, nonatomic)IBOutlet UILabel *txtStaff;
@property (weak, nonatomic)IBOutlet UILabel *txtStatus;

@end