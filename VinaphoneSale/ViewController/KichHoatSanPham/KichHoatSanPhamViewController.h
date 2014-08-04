//
//  KichHoatSanPhamViewController.h
//  VinaphoneSale
//
//  Created by comic on 7/18/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionDefine.h"
#import "ThongTinChungKHSPViewController.h"
@interface KichHoatSanPhamViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDataSource,UITableViewDelegate,ThongTinChungKHSPViewControllerDelegate>{

    NSInteger selectedStatus;
    KHSPEntity *selectedEntity;

}
- (IBAction)dateDidTouchDown:(id)sender;
-(void) searchKichHoatList:(int) isFirst;
-(void) loadComboBoxData: (NSDictionary*) data;
@property (strong,nonatomic) NSMutableArray *tblData;
@property (strong,nonatomic) CollectionDefine *collections;
@property (weak, nonatomic) IBOutlet UITextField *txtFromDate;
@property (weak, nonatomic) IBOutlet UITextField *txtToDate;
@property (weak, nonatomic) IBOutlet UITextField *txtStatus;
@property (weak, nonatomic) IBOutlet UITableView *tblKHSP;
-(IBAction) doBack:(id) sender;
- (IBAction)doSearch:(id)sender;

- (IBAction)statusDidTouchDown:(id)sender;
-(void)updateFromDate:(id)sender;
- (void)updateToDate:(id)sender ;

@end