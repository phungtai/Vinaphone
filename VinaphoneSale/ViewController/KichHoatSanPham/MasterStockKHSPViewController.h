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
#import "KHSPEntity.h"
#import "AddStockKHSPViewController.h"
@class MasterStockKHSPViewController;
@protocol MasterStockKHSPViewControllerDelegate <NSObject>
- (void) updateItemController:(MasterStockKHSPViewController *)controller destroyItem:(KHSPEntity *)item;
- (void) updateItemController:(MasterStockKHSPViewController *)controller activeItem:(KHSPEntity *)item;
- (void) updateItemController:(MasterStockKHSPViewController *)controller addItem:(KHSPEntity *)item;
@end

@interface MasterStockKHSPViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AddStockKHSPViewControllerDelegate,UIAlertViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnAddStock;
@property (strong,nonatomic) CollectionDefine *collections;
@property (nonatomic, weak) id <MasterStockKHSPViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tblStockView;
@property (strong,nonatomic) KHSPEntity *editEntity;
-(void) loadDataFromStock ;
-(IBAction) doBack:(id) sender;
-(void)hideKeyboard;
-(IBAction) doDestroyProductRelease :(id) sender;
-(IBAction) doSaveProduct:(id) sender;
- (IBAction)removeStock:(id)sender;

@end