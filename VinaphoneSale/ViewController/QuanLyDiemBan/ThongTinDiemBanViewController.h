//
//  ThongTinDiemBanViewController.h
//  VinaphoneSale
//
//  Created by Mac on 8/2/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLDBEntity.h"
#import "ThongTinDiemBanTableView.h"
@interface ThongTinDiemBanViewController : UIViewController{
    ThongTinDiemBanTableView *tableView;

}
@property(nonatomic, strong) IBOutlet UIButton *btnEdit;
@property (nonatomic,strong) QLDBEntity *editEtity;
-(void)loadInitView;
-(IBAction)doBack:(id)sender;

@end
