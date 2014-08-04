//
//  AddStockKHSPViewController.m
//  VinaphoneSale
//
//  Created by comic on 7/23/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddStockKHSPViewController.h"
#import "Constant.h"
#import "AFHTTPRequestOperationManager.h"
#import "VnpSaleUtils.h"
#import "StockEntity.h"
#import "AddStockKHSPTableViewCell.h"
#import "MBProgressHUD.h"
@implementation AddStockKHSPViewController
@synthesize collections=_collections;
@synthesize tblData=_tblData;
-(BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)viewDidLoad {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];

    
}
-(void)doBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction) doAddEntity:(id) sender {
    if ([((UIButton*)sender).superview.superview isKindOfClass:[AddStockKHSPTableViewCell class]]) {
        AddStockKHSPTableViewCell *cell = (AddStockKHSPTableViewCell*)((UIButton*)sender).superview.superview;
        StockEntity *entity=[self findItem:cell.stockEntity fromArray:_editEntity.stockDetails];
        int iNo=[cell.txtNo.text integerValue];
        int inputNo=[cell.txtInputNo.text integerValue];
        if (inputNo>iNo) inputNo=iNo;
        if (inputNo <= 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Số lượng nhập phải lớn hơn 0" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: nil];
            [alert show];
        }else{
        if (entity==nil) {
            entity=[cell.stockEntity copy];
            entity.status=2;
            entity.toSerial=entity.fromSerial+inputNo-1;
            entity.quantity = inputNo;
            [_editEntity.stockDetails insertObject:entity atIndex:0];
        }else {
            entity.toSerial=entity.toSerial+inputNo;
        }
        [self.delegate addStockController:self addItem:entity];
        [self.tblStockView reloadData];
    }
    }
}
-(StockEntity*) findItem:(StockEntity*) item fromArray:(NSArray*) array {
    for (int i=0;i<array.count;i++) {
        StockEntity *entity=[array objectAtIndex:i];
        if (entity.fromSerial==item.fromSerial) {
            return entity;
        }
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated {
    [self loadDataFromStock];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y+30);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    CGPoint pointInTable = [textField.superview convertPoint:textField.frame.origin toView:self.tblStockView];
    CGPoint contentOffset = self.tblStockView.contentOffset;
    
    contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height);
    
    [self.tblStockView setContentOffset:contentOffset animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if ([textField.superview.superview isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = (UITableViewCell*)textField.superview.superview;
        NSIndexPath *indexPath = [self.tblStockView indexPathForCell:cell];
        
        [self.tblStockView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

-(void) loadDataFromStock {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"Đang tải dữ liệu";

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters;
    parameters = @{@"STOCK_ID":[NSString stringWithFormat:@"%ld",(long)_editEntity.stockID],
                   @"ATT_SET_ID":[NSString stringWithFormat:@"%ld",(long)_editEntity.attributeID],
                   @"ISSUE_DATE":_editEntity.createDate};

    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_GET_STOCK_SERIAL] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              @try {
                  NSDictionary *response=responseObject;
                  NSString *code=[response objectForKey:@"code"];
                  switch (code.integerValue) {
                      case -2:
                          [self.navigationController popToRootViewControllerAnimated:YES];
                          break;
                      case 0:
                      {
                          NSLog(@"%@",response);
                          _tblData=[[NSMutableArray alloc] initWithCapacity:10];
                          NSArray *dataKichHoat=[response objectForKey:@"data_list_stock"];
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
                              entity.transDate=[dic objectForKey:@"TRANS_DATE"];
                              entity.status = [[dic objectForKey:@"STATUS"]intValue];
                              [_tblData addObject:entity];

                          }
                          [self.tblStockView reloadData];
                          if (_tblData.count == 0) {
                              
                              [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Không có sản phẩm trong kho" cancelButtionTitle:@"Đồng ý"];
                          }
                        
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
    return _tblData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"khspStockCell";
    AddStockKHSPTableViewCell *viewCell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    StockEntity *entity=[self findItem:[_tblData objectAtIndex:indexPath.row] fromArray:_editEntity.stockDetails];
    if (entity==nil) {
        StockEntity *en=[_tblData objectAtIndex:indexPath.row];
        [viewCell setData:en withDefineData:_collections];
    }else{
        StockEntity *stockEntity=[_tblData objectAtIndex:indexPath.row];
        viewCell.txtAttributeSet.text=stockEntity.productName;
        viewCell.txtFromSerial.text=[NSString stringWithFormat:@"%lld",stockEntity.fromSerial];
        viewCell.txtToSerial.text=[NSString stringWithFormat:@"%lld",stockEntity.toSerial];
        viewCell.txtNo.text=[NSString stringWithFormat:@"%lld",stockEntity.toSerial-entity.toSerial];
        viewCell.txtInputNo.text=[NSString stringWithFormat:@"%lld",stockEntity.toSerial-entity.toSerial];
        viewCell.stockEntity=entity;
    }
    if(_editEntity.productReleaseID!=0) {
        viewCell.btnCancel.enabled=NO;
    }
    viewCell.btnAdd.tag=indexPath.row;
    viewCell.txtInputNo.delegate=self;
    return viewCell;
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}
@end