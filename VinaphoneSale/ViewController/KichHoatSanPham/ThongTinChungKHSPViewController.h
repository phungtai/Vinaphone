//
//  KichHoatSanPhamViewController.h
//  VinaphoneSale
//
//  Created by comic on 7/18/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ThongTinChungTableView.h"
#import "CollectionDefine.h"
#import "KHspEntity.h"
#import "MasterStockKHSPViewController.h"
@class ThongTinChungKHSPViewController;
@protocol ThongTinChungKHSPViewControllerDelegate <NSObject>
- (void) updateItemController:(ThongTinChungKHSPViewController *)controller destroyItem:(KHSPEntity *)item;
- (void) updateItemController:(ThongTinChungKHSPViewController *)controller activeItem:(KHSPEntity *)item;
- (void) updateItemController:(ThongTinChungKHSPViewController *)controller addItem:(KHSPEntity *)item;
- (void) addDoneButton:(UITextField *)textField;
@end
@interface ThongTinChungKHSPViewController : UIViewController <UIPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,MasterStockKHSPViewControllerDelegate, UITableViewDelegate>{
    ThongTinChungTableView *tableView;
    KHSPEntity *selectedIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btCancel;
@property (nonatomic, weak) id <ThongTinChungKHSPViewControllerDelegate> delegate;
@property (strong,nonatomic) CollectionDefine *collections;
@property (strong,nonatomic) KHSPEntity *editEntity;
-(IBAction) doBack:(id) sender;
- (void) pickerViewInit:(id)sender ;
-(void) hideKeyboard ;
-(void) moveNext;
-(IBAction) doDestroyProductRelease :(id) sender;
-(IBAction) doSaveProduct:(id) sender;
@end