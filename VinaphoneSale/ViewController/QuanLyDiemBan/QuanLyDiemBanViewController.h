//
//  QuanLyDiemBanViewController.h
//  VinaphoneSale
//
//  Created by Mac on 8/1/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLDBEntity.h"
@interface QuanLyDiemBanViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    int selectedIndex;
    QLDBEntity *selectedEntity;

}
@property (nonatomic, strong) IBOutlet UITableView *tblQlDiemBan;
@property (nonatomic, strong) NSMutableArray *tblAgent;
@property (nonatomic, strong) NSDictionary *reponse;
@property (nonatomic, strong) NSMutableArray *tblData;
- (IBAction)doback:(id)sender;
@end
