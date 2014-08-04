//
//  AddStockKHSPViewController.m
//  VinaphoneSale
//
//  Created by comic on 7/23/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterStockKHSPViewController.h"
#import "Constant.h"
#import "AFHTTPRequestOperationManager.h"
#import "VnpSaleUtils.h"
#import "StockEntity.h"
#import "MBProgressHUD.h"
#import "KHSPEntity.h"
#import "MasterStockKHSPTableViewCell.h"
#import "AddStockKHSPViewController.h"
#import "KichHoatSanPhamViewController.h"

@implementation MasterStockKHSPViewController
@synthesize editEntity=_editEntity;
@synthesize collections=_collections;

-(BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)viewDidLoad {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(doBack:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
    //XEM
    if (_editEntity.productReleaseID!=0 && _editEntity.status!=2) {
        self.btCancel.hidden=YES;
        self.btnSave.hidden=YES;
    }
    if(_editEntity.productReleaseID!=0) {
        [self.btnSave setImage:[UIImage imageNamed:@"accept.png"] forState:UIControlStateNormal];
        self.btnAddStock.hidden=YES;
        if (_editEntity.stockDetails.count == 0) {
            [self loadDataFromStock];
        }        
    }else {
        self.btCancel.hidden=YES;
    }
    
}

-(void)doBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction) doDestroyProductRelease :(id) sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters= @{@"PRO_RELEASE_ID": [NSString stringWithFormat:@"%ld",(long)_editEntity.productReleaseID],@"ISSUE_DATE" :_editEntity.issueDate};
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_DESTROY_PRODUCT_RELEASE] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *response=responseObject;
              NSLog(@"%@",response);
              NSObject *code=[response objectForKey:@"code"];
              if ([code isKindOfClass:[NSString class]] && [((NSString*)code).lowercaseString isEqualToString:@"success"]){
                  [self.delegate updateItemController:self destroyItem:_editEntity];
                  for (int i=0;i<self.navigationController.viewControllers.count;i++) {
                      UIViewController *controller=[self.navigationController.viewControllers objectAtIndex:i];
                      if ([controller isKindOfClass:[KichHoatSanPhamViewController class]]) {
                          [self.navigationController popToViewController:controller
                                                                animated:YES];
                          break;
                          
                      }
                  }
              }else {
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Có lỗi khi huỷ đơn hàng. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
              }
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } ];
    
}
- (IBAction)removeStock:(id)sender {
    if ([((UIButton*)sender).superview.superview isKindOfClass:[MasterStockKHSPTableViewCell class]]) {
        MasterStockKHSPTableViewCell *cell = (MasterStockKHSPTableViewCell*)((UIButton*)sender).superview.superview;
        NSIndexPath *indexPath = [self.tblStockView indexPathForCell:cell];
        [_editEntity.stockDetails removeObjectAtIndex:indexPath.row];
        [self.tblStockView reloadData];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1){
                [self updateNewData];
            }
            break;
        case 2:
    if (buttonIndex==1) {
        UITextField *alertTextField = [alertView textFieldAtIndex:0];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //OTP=21&PRO_RELEASE_ID=4237&ISSUE_DATE=21/07/2014 17:04:39&TYPE=2
        NSDictionary *parameters= @{@"PRO_RELEASE_ID": [NSString stringWithFormat:@"%ld",(long)_editEntity.productReleaseID],@"ISSUE_DATE" :_editEntity.issueDate,@"TYPE":[NSString stringWithFormat:@"%ld",(long)_editEntity.type],@"OTP":alertTextField.text};
        [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_ACTIVE_PRODUCT_RELEASE] parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *response=responseObject;
                  NSLog(@"%@",response);
                  NSObject *code=[response objectForKey:@"code"];
                  if ([code isKindOfClass:[NSString class]]){
                      NSString *codeS=((NSString*)code).lowercaseString;
                      if ([codeS isEqualToString:@"success"]) {
                          [self.delegate updateItemController:self activeItem:_editEntity];
                          for (int i=0;i<self.navigationController.viewControllers.count;i++) {
                              UIViewController *controller=[self.navigationController.viewControllers objectAtIndex:i];
                              if ([controller isKindOfClass:[KichHoatSanPhamViewController class]]) {
                                  [self.navigationController popToViewController:controller
                                                                        animated:YES];
                                  break;
                                  
                              }
                          }
                      }
                  }else if([code isKindOfClass:[NSNumber class]] && ((NSNumber*)code).integerValue==-1){
                      NSString *message=[response objectForKey:@"ERR_MESS"];
                      if ([message isEqualToString:@"OTP"]) {
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Mã OTP không đúng. Vui lòng thử lại" cancelButtionTitle:@"Đồng ý"];
                      }else if([message isEqualToString:@"OTP_DATE"]) {
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Mã OTP hết hạn. Vui lòng lấy lại mã OTP." cancelButtionTitle:@"Đồng ý"];
                      }else{
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Có lỗi khi kích hoạt đơn hàng. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
                      }
                  }else {
                      [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Có lỗi khi kích hoạt đơn hàng. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
                  }
                  
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [VnpSaleUtils showAlertwithNetworkError:error];
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              } ];
    }
            break;
    }
}

-(IBAction) doSaveProduct:(id) sender {
    if (_editEntity.productReleaseID!=0 && _editEntity.stockDetails.count != 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nhập mã OTP" message:@"Vui lòng nhập mã OTP bạn vừa nhận" delegate:self cancelButtonTitle:@"Bỏ qua" otherButtonTitles:@"Hoàn thành", nil] ;
        alertView.tag = 2;
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
    }else if (_editEntity.productReleaseID == 0 && _editEntity.stockDetails.count == 0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Lỗi" message:@"Thông tin chi tiết chưa có mặt hàng" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    else if (_editEntity.productReleaseID==0 && _editEntity.stockDetails.count != 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Bạn có chắc chắn muốn lưu" delegate:self cancelButtonTitle:@"Hủy" otherButtonTitles:@"Đồng ý", nil];
        NSLog(@"%d", alert.cancelButtonIndex);
        [alert setTag:1];
        [alert show];
        
        
    }

}

-(void) loadDataFromStock {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"Đang tải dữ liệu";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters;
    parameters = @{@"PRO_RELEASE_ID":[NSString stringWithFormat:@"%ld",(long)_editEntity.productReleaseID ],
                   @"STOCK_ID":[NSString stringWithFormat:@"%ld",(long)_editEntity.stockID],
                   @"ATT_SET_ID":[NSString stringWithFormat:@"%ld",(long)_editEntity.attributeID],
                   @"ISSUE_DATE":_editEntity.issueDate};
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_GET_PRODUCT_DETAIL] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              @try {
                  NSDictionary *response=responseObject;
                  NSString *code=[response objectForKey:@"code"];
                  switch (code.integerValue) {
                      case -2:{
                          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Bạn đã hết phiên làm viêc" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: nil];
                          alert.tag = 2;
                          [alert show];
                      }
                          break;
                      case 0:
                      {
                          NSLog(@"%@",response);
                          _editEntity.stockDetails=[[NSMutableArray alloc] initWithCapacity:10];
                          NSArray *dataKichHoat=[response objectForKey:@"data_pro_release_detail"];
                          for (int i=0; i<dataKichHoat.count; i++) {
                              StockEntity *entity=[[StockEntity alloc] init];
                              NSDictionary *dic=[dataKichHoat objectAtIndex:i];
                              entity.attributeSetID=[[dic objectForKey:@"ATTRIBUTE_SET_ID"] integerValue];
                              entity.expDate=[dic objectForKey:@"EXP_DATE"] ;
                              entity.fromSerial=[[dic objectForKey:@"FROM_SERIAL"] longLongValue];
                              entity.productID=[[dic objectForKey:@"PRODUCT_ID"] integerValue];
                              entity.productName=[dic objectForKey:@"PRODUCT_NAME"];
                              entity.productStatus=[[dic objectForKey:@"PRODUCT_STATUS"] integerValue];
                              entity.quantity=[[dic objectForKey:@"QUANTITY"] integerValue];
                              entity.staffID=[[dic objectForKey:@"STAFF_ID"] integerValue];
                              entity.stockID=[[dic objectForKey:@"STOCK_ID"] integerValue];
                              entity.stockSerialID=[[dic objectForKey:@"STOCK_SERIAL_ID"] integerValue];
                              
                              entity.stockTransID=[[dic objectForKey:@"STOCK_TRANS_ID"] integerValue];
                              entity.toSerial=[[dic objectForKey:@"TO_SERIAL"] longLongValue];
                              entity.transDate=[dic objectForKey:@"ORG_TRANS_DATE"];
                              entity.issueDate=[dic objectForKey:@"ISSUE_DATE"];
                              entity.status = [[dic objectForKey:@"STATUS"]intValue];
                              [_editEntity.stockDetails addObject:entity];
                          }
                          [self.tblStockView reloadData];
                      }
                          break;
                      case -1:
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Hệ thống có lỗi. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
                          break;
                  }
              }@catch (NSException *exception) {
                  NSString *error=[NSString stringWithFormat:@"Hệ thống có lỗi. Vui lòng thử lại. Chi tiết%@",exception.description];
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:error cancelButtionTitle:@"Đồng ý"];
              }@finally{
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } ];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _editEntity.stockDetails.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"khspStockCell";
    MasterStockKHSPTableViewCell *viewCell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [viewCell setData:[_editEntity.stockDetails objectAtIndex:indexPath.row] withDefineData:_collections];
    if(_editEntity.productReleaseID!=0) {
        
        [viewCell.btnCancel setHidden:YES];
    }
    return viewCell;
}
//Add STOCK Delegate
-(void)addStockController:(AddStockKHSPViewController *)controller addItem:(StockEntity *)items {
    [self.tblStockView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //khspProDetailSegue
    if ([segue.identifier isEqualToString:@"khspAddStockSegue"]) {
        AddStockKHSPViewController *controller=segue.destinationViewController;
        if(_editEntity.stockDetails==nil) _editEntity.stockDetails=[[NSMutableArray alloc] initWithCapacity:10];
        controller.collections=self.collections;
        controller.delegate=self;
        controller.editEntity=self.editEntity;
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"khspAddStockSegue"]) {
        if (_editEntity.issueNo==nil || [_editEntity.issueNo isEqualToString:@""]) {
            [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Vui lòng nhập số công văn trước khi thêm hàng từ kho" cancelButtionTitle:@"Đồng ý"];
            return NO;
        }
    }
    
    return YES;
}
-(void)hideKeyboard
{
    [self.view endEditing:YES];
}
-(void) updateNewData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //OTP=21&PRO_RELEASE_ID=4237&ISSUE_DATE=21/07/2014 17:04:39&TYPE=2
    NSDictionary *parameters= @{@"REQUEST": _editEntity.getJSONString};
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_INSERT_PRODUCT_RELEASE] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *response=responseObject;
              NSLog(@"%@",response);
              NSObject *code=[response objectForKey:@"code"];
              if ([code isKindOfClass:[NSString class]] && ((NSString*)code).integerValue==0){
                  [self.delegate updateItemController:self addItem:_editEntity];
                  for (int i=0;i<self.navigationController.viewControllers.count;i++) {
                      UIViewController *controller=[self.navigationController.viewControllers objectAtIndex:i];
                      if ([controller isKindOfClass:[KichHoatSanPhamViewController class]]) {
                          [self.navigationController popToViewController:controller
                                                                animated:YES];
                          
                          break;
                          
                      }
                  }
                  
              }else {
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Có lỗi khi lưu đơn hàng. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
              }
              
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } ];
}
@end