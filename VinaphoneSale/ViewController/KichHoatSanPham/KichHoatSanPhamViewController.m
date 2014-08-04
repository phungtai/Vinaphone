//
//  KichHoatSanPhamViewController.m
//  VinaphoneSale
//
//  Created by comic on 7/18/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "KichHoatSanPhamViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ComboEntity.h"
#import "KHSPEntity.h"
#import "KHSPTableViewCell.h"
#import "VnpSaleUtils.h"
#import "StaffEntity.h"
#import "ThongTinChungKHSPViewController.h"
#import "MBProgressHUD.h"
@implementation KichHoatSanPhamViewController
NSString *isSellable;
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
    // Kiểm tra giá trị isSellable
    NSUserDefaults *passingValue = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [passingValue objectForKey:@"data"];
    for (int i = 0; i <arr.count; i++) {
        isSellable = [[arr objectAtIndex:i]objectForKey:@"IS_SELLABLE"];
    }
    [self.txtFromDate setRightViewMode:UITextFieldViewModeAlways];
    self.txtFromDate.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar1.png"]];
    [self.txtToDate setRightViewMode:UITextFieldViewModeAlways];
    self.txtToDate.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar1.png"]];
    [self.txtStatus setRightViewMode:UITextFieldViewModeAlways];
    self.txtStatus.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *now=[NSDate date];
    self.txtToDate.text = [dateFormatter stringFromDate:now];
    self.txtFromDate.text=[dateFormatter stringFromDate:[now dateByAddingTimeInterval:-2*24*60*60]];
    _tblData=[[NSMutableArray alloc] initWithCapacity:10];
    [self searchKichHoatList:1];
}
//-(void)viewWillAppear:(BOOL)animated{
//    [self searchKichHoatList:2];
//}


-(void) loadComboBoxData: (NSDictionary*) data {
    _collections=[[CollectionDefine alloc] init];
    // LOAD STATUS
    _collections.statusTypes= [ComboEntity initComboWithData:[data objectForKey:@"data_trangthai_kichhoat"] keyCode:@"CODE" keyValue:@"DISPLAY_VALUE"];
    // RESELLER
    _collections.resellerTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_donvi_kichhoat"] keyCode:@"RESELLER_ID" keyValue:@"DISPLAY_VALUE"];
    // STOCK
    _collections.stockTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_khohang"] keyCode:@"STOCK_ID" keyValue:@"DISPLAY_VALUE"];
    //PRODUCT
    _collections.productTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_loai_sanpham"] keyCode:@"ATTRIBUTE_SET_ID" keyValue:@"DISPLAY_VALUE"];
        //ACTION
    _collections.actionTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_loai_tacdong"] keyCode:@"CODE" keyValue:@"VALUE"];
        //REASON
    _collections.reasonTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_lydo"] keyCode:@"REASON_ID" keyValue:@"REASON_CODE"];
    _collections.distributorTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_nha_cungung"] keyCode:@"DISTRIBUTOR_ID" keyValue:@"DISPLAY_VALUE"];
    _collections.statusDetailTypes=[ComboEntity initComboWithData:[data objectForKey:@"data_trangthai_chitiet"] keyCode:@"CODE" keyValue:@"DISPLAY_VALUE"];
    
    NSMutableArray *combo=[[NSMutableArray alloc] initWithCapacity:10];
    NSArray *array=[data objectForKey:@"data_nguoikichhoat"];
    for (int i=0; i<array.count; i++) {
        StaffEntity *entity=[StaffEntity alloc];
        entity.staffID=[[[array objectAtIndex:i] objectForKey:@"STAFF_ID"] integerValue];
        entity.staffCode=[[array objectAtIndex:i] objectForKey:@"STAFF_CODE"];
        entity.displayValue=[[array objectAtIndex:i] objectForKey:@"DISPLAY_VALUE"];
        [combo addObject:entity];
    }
    _collections.staffTypes=combo;
    self.txtStatus.text = @"Tất cả";
}


-(void) searchKichHoatList: (int) isFirst {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters;
    NSString *strStatus;
    if (selectedStatus==0) {
        strStatus=@"all";
    }else {
        strStatus=[NSString stringWithFormat:@"%ld",(long)[[_collections.statusTypes objectAtIndex:selectedStatus-1] code]];
    }
    if (isFirst==1) {
        parameters = @{@"IS_FISRT": [NSString stringWithFormat:@"%ld",(long)isFirst],@"FROM_DATE" :self.txtFromDate.text, @"TO_DATE":self.txtToDate.text, @"STATUS":strStatus};
        [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_DEFINE_ACTIVE_PRODUCT] parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *response=responseObject;
                  NSLog(@"%@",response);
                  NSString *code=[response objectForKey:@"code"];
                  switch (code.integerValue) {
                      case -2:
                          [self.navigationController popToRootViewControllerAnimated:YES];
                          break;
                      case 0:
                      {
                          [self loadComboBoxData:response];
                          NSArray *dataKichHoat=[response objectForKey:@"data_kichhoat"];
                          [_tblData removeAllObjects];
                          NSDictionary *dic;
                          for (int i=0; i<dataKichHoat.count; i++) {
                              
                              dic=[dataKichHoat objectAtIndex:i];
                              KHSPEntity *entity=[[KHSPEntity alloc] initWithDictionary:dic];
                              [_tblData addObject:entity];
                            

                          }
                          [self.tblKHSP reloadData];
                  }
                          break;
                      default:
                          break;
                  }
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [VnpSaleUtils showAlertwithNetworkError:error];
                  [MBProgressHUD hideHUDForView:self.view animated:YES];

              } ];
    }else {
        parameters = @{@"FROM_DATE" :self.txtFromDate.text, @"TO_DATE":self.txtToDate.text, @"STATUS":strStatus};
        [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_SEARCH_ACTIVE_PRODUCT] parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *response=responseObject;
                  NSString *code=[response objectForKey:@"code"];
                  switch (code.integerValue) {
                      case -2:
                          [self.navigationController popToRootViewControllerAnimated:YES];
                          break;
                      case 0:
                      {
                          
                          NSArray *dataKichHoat=[response objectForKey:@"data_kichhoat"];
                          [_tblData removeAllObjects];
                          for (int i=0; i<dataKichHoat.count; i++) {
                              
                              NSDictionary *dic=[dataKichHoat objectAtIndex:i];
                              KHSPEntity *entity=[[KHSPEntity alloc] initWithDictionary:dic];
                              
                              entity.userName=[dic objectForKey:@"USER_NAME"];
                              [_tblData addObject:entity];
                          }
                          [self.tblKHSP reloadData];
                      }
                          break;
                      case -1:
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Hệ thống có lỗi. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
                          break;
                  }
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [VnpSaleUtils showAlertwithNetworkError:error];
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              } ];
    }
    
}

- (IBAction)doSearch:(id)sender {
    [self hideKeyboard];
    [self searchKichHoatList:2];
}


//PICKER VIEW
- (IBAction)statusDidTouchDown:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc]init];
    picker.delegate=self;
    picker.showsSelectionIndicator=YES;
    [picker selectRow:selectedStatus inComponent:0 animated:YES];
    [self.txtStatus setInputView:picker];
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(hideKeyboard)];
    

    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpace,doneButton, nil]];
    self.txtStatus.inputAccessoryView=keyboardDoneButtonView;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _collections.statusTypes.count+1;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(row==0) return @"Tất cả";
    return [[_collections.statusTypes objectAtIndex:row-1] displayValue];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedStatus=row;
    if(row==0) {
            self.txtStatus.text = @"Tất cả";
    }else{
        self.txtStatus.text = [[_collections.statusTypes objectAtIndex:row-1] displayValue];
    }
}
// PICKER DATE
- (void)updateFromDate:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)self.txtFromDate.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.txtFromDate.text = [dateFormatter stringFromDate:picker.date];
    
}
- (void)updateToDate:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)self.txtToDate.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.txtToDate.text = [dateFormatter stringFromDate:picker.date];
    
}


- (IBAction)dateDidTouchDown:(id)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    if (sender==self.txtFromDate ) {
        [datePicker setDate:[dateFormatter dateFromString:self.txtFromDate.text]];
        [datePicker addTarget:self action:@selector(updateFromDate:)  forControlEvents:UIControlEventValueChanged];
        [self.txtFromDate setInputView:datePicker];
        
    }else if (sender==self.txtToDate) {
        [datePicker setDate:[dateFormatter dateFromString:self.txtToDate.text]];
        [datePicker addTarget:self action:@selector(updateToDate:)  forControlEvents:UIControlEventValueChanged];
        [self.txtToDate setInputView:datePicker];
        
    }
}
//#####################################
//TABLE VIEW
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tblData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"khspCell";
    KHSPTableViewCell *viewCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KHSPEntity *entity=[_tblData objectAtIndex:indexPath.row];
    viewCell.btnXem.tag=indexPath.row;
    if(entity.status==2) {
        [viewCell.btnXem setTitle:@"Sửa" forState:UIControlStateNormal];
        [viewCell.btnXem setTitle:@"Sửa" forState:UIControlStateSelected];
        [viewCell.btnXem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else {
        [viewCell.btnXem setTitle:@"Xem" forState:UIControlStateNormal];
        [viewCell.btnXem setTitle:@"Xem" forState:UIControlStateSelected];
        [viewCell.btnXem setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    viewCell.txtSoCV.text=entity.issueNo;
    viewCell.txtCreateDate.text=entity.createDate;
    viewCell.txtStaff.text=[NSString stringWithFormat:@"%ld" ,(long)entity.staffID ];
    viewCell.txtStatus.text=[ComboEntity getDisplayValue:_collections.statusTypes withCode:entity.status];
    viewCell.txtReseller.text=[ComboEntity getDisplayValue:_collections.resellerTypes withCode:entity.resellerID];
    for (int i=0; i<_collections.staffTypes.count; i++) {
        StaffEntity *staff=[_collections.staffTypes objectAtIndex:i];
        if (staff.staffID==entity.staffID) {
            viewCell.txtStaff.text=staff.displayValue;
            break;
        }
               }
    viewCell.txtStock.text=[ComboEntity getDisplayValue:_collections.stockTypes withCode:entity.stockID];
 
    return viewCell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addKHSPSegue"]) {
        ThongTinChungKHSPViewController *controller=segue.destinationViewController;
        controller.delegate=self;
        controller.collections=self.collections;
        
    }else if ([segue.identifier isEqualToString:@"editKHSPSegue"]) {
        ThongTinChungKHSPViewController *controller=segue.destinationViewController;
        controller.delegate=self;
        controller.collections=self.collections;
        UIButton *btnXem=sender;
        selectedEntity=[_tblData objectAtIndex:btnXem.tag];
        controller.editEntity=selectedEntity;
    }
}

-(void)doBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}
- (void) updateItemController:(ThongTinChungKHSPViewController *)controller destroyItem:(KHSPEntity *)item;
{
    for (int i=0; i<_tblData.count; i++) {
        KHSPEntity *entity=[_tblData objectAtIndex:i];
        if (entity.productReleaseID==item.productReleaseID) {
            entity.status=0;
        }
    }
    [self.tblKHSP reloadData];
}
- (void) updateItemController:(ThongTinChungKHSPViewController *)controller activeItem:(KHSPEntity *)item;
{
    for (int i=0; i<_tblData.count; i++) {
        KHSPEntity *entity=[_tblData objectAtIndex:i];
        if (entity.productReleaseID==item.productReleaseID) {
            entity.status=3;
        }
    }
    [self.tblKHSP reloadData];
}
-(void)updateItemController:(ThongTinChungKHSPViewController *)controller addItem:(KHSPEntity *)item{
    [self searchKichHoatList:2];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"addKHSPSegue"]) {
        if ([isSellable intValue] == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Bạn không có quyền hạn này" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: nil];
            [alert show];
            return NO;
        }
            }
    return YES;
}
@end