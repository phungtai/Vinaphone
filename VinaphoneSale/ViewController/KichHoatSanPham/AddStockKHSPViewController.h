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
#import "StockEntity.h"

@class AddStockKHSPViewController;
@protocol AddStockKHSPViewControllerDelegate <NSObject>
- (void)addStockController:(AddStockKHSPViewController *)controller addItem:(StockEntity *)items;
@end

@interface AddStockKHSPViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
}
@property (nonatomic, weak) id <AddStockKHSPViewControllerDelegate> delegate;
@property (strong,nonatomic) CollectionDefine *collections;
@property (strong,nonatomic) NSMutableArray *tblData;
@property (weak, nonatomic) IBOutlet UITableView *tblStockView;
@property (weak, nonatomic)IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) KHSPEntity *editEntity;
-(void) loadDataFromStock ;
-(IBAction) doBack:(id) sender;
-(IBAction) doAddEntity:(id) sender;
-(void)hideKeyboard;
-(StockEntity*) findItem:(StockEntity*) item fromArray:(NSArray*) array ;
@end