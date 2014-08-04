//
//  ThongTinChungKHSPViewController.m
//  VinaphoneSale
//
//  Created by comic on 7/21/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThongTinChungKHSPViewController.h"
#import "ThongTinChungTableView.h"
#import "KichHoatSanPhamViewController.h"
#import "ComboEntity.h"
#import "MasterStockKHSPViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "Constant.h"
#import "VnpSaleUtils.h"
#import "StaffEntity.h"

@implementation ThongTinChungKHSPViewController
NSString *staffID; // Biến lưu staffID
NSString *staffName; // Luu staffName
@synthesize editEntity=_editEntity;
-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_editEntity != nil) {
        NSLog(@"%ld",(long)_editEntity.approID);
    }
    NSUserDefaults *passingValue = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [passingValue objectForKey:@"data"];
    for (int i = 0; i <arr.count; i++) {
        staffID = [[arr objectAtIndex:i]objectForKey:@"STAFF_ID"];
        staffName = [[arr objectAtIndex:i]objectForKey:@"FULL_NAME"];
    }

    selectedIndex=[[KHSPEntity alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(moveNext)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipe];
    UISwipeGestureRecognizer *swipeBack=[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(doBack:)];
    [swipeBack setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeBack];

    tableView=[self.childViewControllers.lastObject tableView];
    //XEM
    if (_editEntity.productReleaseID!=0 && _editEntity.status!=2) {
        self.btCancel.hidden=YES;
        self.btnSave.hidden=YES;
//        _editEntity.staffID = [staffID intValue];
//        tableView.txtStaff.text = staffName;
    }
    if (_editEntity.productReleaseID!=0) { //EDIT
        [self.btnSave setImage:[UIImage imageNamed:@"accept.png"] forState:UIControlStateNormal];
       
        tableView.txtCreateDate.text=_editEntity.createDate;
        tableView.txtProduct.text=[[_collections.productTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.productTypes withCode:_editEntity.attributeID]]displayValue];
        tableView.txtProduct.enabled=NO;
        tableView.txtSoCV.enabled=NO; //Số CV
        tableView.txtSoCV.text=_editEntity.issueNo;
        tableView.txtDistributor.text=[[_collections.distributorTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.distributorTypes withCode:_editEntity.distributorID]] displayValue];
        tableView.txtDistributor.enabled=NO;
        
        tableView.txtReason.text=[[_collections.reasonTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.reasonTypes withCode:_editEntity.reasonID]] displayValue];
        tableView.txtReason.enabled=NO; // Lý do
//        [tableView.txtReason addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        
        tableView.txtStock.text=[[_collections.stockTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.stockTypes withCode:_editEntity.stockID]] displayValue];
        tableView.txtStock.enabled=NO;
        
        tableView.txtAction.text=[[_collections.actionTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.actionTypes withCode:_editEntity.type]] displayValue];
        tableView.txtAction.enabled=NO;
        
        tableView.txtReseller.text=[[_collections.resellerTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.resellerTypes withCode:_editEntity.resellerID]] displayValue];
        tableView.txtReseller.enabled=NO;
        
        tableView.txtStaff.text=[[_collections.staffTypes objectAtIndex:[StaffEntity getSelectedIndex:_collections.staffTypes withCode:_editEntity.staffID]] displayValue];
        tableView.txtStaff.enabled=NO;
        
        tableView.txtStatus.text=[[_collections.statusTypes objectAtIndex:[ComboEntity getSelectedIndex:_collections.statusTypes withCode:_editEntity.status]] displayValue];
        tableView.txtStatus.enabled=NO;
        if(selectedIndex.approID==0){
            tableView.txtApproID.text=@"";
        }else {
            tableView.txtApproID.text=[[_collections.staffTypes objectAtIndex:[StaffEntity getSelectedIndex:_collections.staffTypes withCode:_editEntity.approID]] displayValue];
        
        }
        tableView.txtApproID.enabled=NO; // Người duyệt
//        [tableView.txtApproID addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
    }else {
        _editEntity=[[KHSPEntity alloc] init];
        selectedIndex=[[KHSPEntity alloc] init];
        self.btCancel.hidden=YES;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        tableView.txtCreateDate.text=[dateFormatter stringFromDate:[NSDate date]];
        _editEntity.createDate=[dateFormatter stringFromDate:[NSDate date]];
        _editEntity.issueDate=[dateFormatter stringFromDate:[NSDate date]];
        tableView.txtSoCV.delegate=self;
        
        tableView.txtProduct.text=[[_collections.productTypes objectAtIndex:0] displayValue];
        [tableView.txtProduct addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        _editEntity.attributeID=[[_collections.productTypes objectAtIndex:0] code];
        
        [tableView.txtProduct setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtProduct.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        
        [tableView.txtDistributor addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        tableView.txtDistributor.text=[[_collections.distributorTypes objectAtIndex:1] displayValue];
        selectedIndex.distributorID=1;
        _editEntity.distributorID=[[_collections.distributorTypes objectAtIndex:1] code];
        [tableView.txtDistributor setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtDistributor.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        
        [tableView.txtReason addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        tableView.txtReason.text=[[_collections.reasonTypes objectAtIndex:0] displayValue];
        _editEntity.reasonID=[[_collections.reasonTypes objectAtIndex:0] code];
        [tableView.txtReason setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtReason.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        
        [tableView.txtStock addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        tableView.txtStock.text=[[_collections.stockTypes objectAtIndex:0] displayValue];
        [tableView.txtStock setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtStock.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        _editEntity.stockID=[[_collections.stockTypes objectAtIndex:0] code];
        
        [tableView.txtAction addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        tableView.txtAction.text=[[_collections.actionTypes objectAtIndex:0] displayValue];
        _editEntity.type=[[_collections.actionTypes objectAtIndex:0] code];
        [tableView.txtAction setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtAction.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        
        [tableView.txtReseller addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        tableView.txtReseller.text=[[_collections.resellerTypes objectAtIndex:0] displayValue];
        [tableView.txtReseller setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtReseller.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        _editEntity.resellerID=[[_collections.resellerTypes objectAtIndex:0] code];
        
        [tableView.txtStaff addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        tableView.txtStaff.text= staffName;
        [tableView.txtStaff setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtStaff.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        //_editEntity.staffID=[[_collections.staffTypes objectAtIndex:0] staffID];
        _editEntity.staffID = [staffID intValue];
        selectedIndex.staffID=[StaffEntity getSelectedIndex:_collections.staffTypes withCode: _editEntity.staffID];

        tableView.txtStatus.enabled=NO;
        selectedIndex.status=[ComboEntity getSelectedIndex:_collections.statusTypes withCode:2];
        tableView.txtStatus.text=[[_collections.statusTypes objectAtIndex:selectedIndex.status ] displayValue];
        _editEntity.status=2;
        
        [tableView.txtApproID addTarget:self action:@selector(pickerViewInit:) forControlEvents:UIControlEventEditingDidBegin];
        [tableView.txtApproID setRightViewMode:UITextFieldViewModeAlways];
        tableView.txtApproID.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
        
        tableView.txtApproID.text=@"";

        
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    // Kiem tra khi da chon hang vao kho thi khong cho chon lai cac truong:
    // Loai san pham, Loai tac dong, Nha cung ung, Kho
    if (_editEntity.stockDetails!=nil && _editEntity.stockDetails.count!=0) {
        tableView.txtProduct.enabled=NO;
        tableView.txtAction.enabled=NO;
        tableView.txtReseller.enabled=NO;
        tableView.txtStock.enabled=NO;
    }
}
-(void)doBack:(id)sender {
    [tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction) doDestroyProductRelease :(id) sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Bạn có chắc chắn muốn hủy đơn hàng" delegate:self cancelButtonTitle:@"Không hủy" otherButtonTitles:@"Đồng ý", nil];
    [alert setTag:2];
    [alert show];
    
    }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1){
                [self updateNewData];
            }
            break;
        case 2:
            if (buttonIndex == 1) {
                [self CancelData];
            }
            break;
        default:

        if (buttonIndex == 1) {
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
                  if ([code isKindOfClass:[NSString class]] && [((NSString*)code).lowercaseString isEqualToString:@"success"]){
                      [self.delegate updateItemController:self activeItem:_editEntity];
                      [self doBack:nil];
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
    if (_editEntity.productReleaseID!=0 ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nhập mã OTP" message:@"Vui lòng nhập mã OTP bạn vừa nhận" delegate:self cancelButtonTitle:@"Bỏ qua" otherButtonTitles:@"Hoàn thành", nil] ;
        alertView.tag = 3;
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
    }else if (_editEntity.productReleaseID==0 && _editEntity.stockDetails.count == 0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Lỗi" message:@"Thông tin chi tiết chưa có mặt hàng" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if (_editEntity.productReleaseID==0 && _editEntity.stockDetails.count != 0) {
//        else if (_editEntity.stockDetails.count != 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:@"Bạn có chắc chắn muốn lưu" delegate:self cancelButtonTitle:@"Hủy" otherButtonTitles:@"Đồng ý", nil];
        NSLog(@"%d", alert.cancelButtonIndex);
        [alert setTag:1];
        [alert show];
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField==tableView.txtSoCV) {
        _editEntity.issueNo=textField.text;
    }
}
// PICKER
- (void) pickerViewInit:(id)sender {
    UIPickerView *picker = [[UIPickerView alloc]init];
    picker.delegate=self;
    picker.showsSelectionIndicator=YES;
    if (sender==tableView.txtProduct) {
        picker.tag=1;
        [picker selectRow:selectedIndex.attributeID inComponent:0 animated:YES];
        [tableView.txtProduct setInputView:picker];
        _editEntity.attributeID=[[_collections.productTypes objectAtIndex:selectedIndex.attributeID] code]
        ;
        [self addDoneButton:tableView.txtProduct];

    }else if (sender==tableView.txtAction) {
        picker.tag=2;
        [picker selectRow:selectedIndex.type inComponent:0 animated:YES];
        [tableView.txtAction setInputView:picker];
        _editEntity.type=[[_collections.actionTypes objectAtIndex:selectedIndex.type] code];
        [self addDoneButton:tableView.txtAction];
        
    }else if (sender==tableView.txtDistributor) {
        picker.tag=3;
        [picker selectRow:selectedIndex.distributorID inComponent:0 animated:YES];
        [tableView.txtDistributor setInputView:picker];
        _editEntity.distributorID=[[_collections.distributorTypes objectAtIndex:selectedIndex.distributorID] code];
        [self addDoneButton:tableView.txtDistributor];
    }else if (sender==tableView.txtReseller) {
        picker.tag=4;
        [picker selectRow:selectedIndex.resellerID inComponent:0 animated:YES];
        [tableView.txtReseller setInputView:picker];
        _editEntity.resellerID=[[_collections.resellerTypes objectAtIndex:selectedIndex.resellerID] code];
        [self addDoneButton:tableView.txtReseller];
    }else if (sender==tableView.txtStock) {
        picker.tag=5;
        [picker selectRow:selectedIndex.stockID inComponent:0 animated:YES];
        [tableView.txtStock setInputView:picker];
        _editEntity.stockID=[[_collections.stockTypes objectAtIndex:selectedIndex.stockID] code];
        [self addDoneButton:tableView.txtStock];
    }else if (sender==tableView.txtStaff) {
        picker.tag=6;
        [picker selectRow:selectedIndex.staffID inComponent:0 animated:YES];
        [tableView.txtStaff setInputView:picker];
        _editEntity.staffID=[[_collections.staffTypes objectAtIndex:selectedIndex.staffID] staffID];
        [self addDoneButton:tableView.txtStaff];
    }else if (sender==tableView.txtReason) {
        picker.tag=7;
        [picker selectRow:selectedIndex.reasonID inComponent:0 animated:YES];
        [tableView.txtReason setInputView:picker];
        _editEntity.reasonID=[[_collections.reasonTypes objectAtIndex:selectedIndex.reasonID] code];
        [self addDoneButton:tableView.txtReason];
    }else if (sender==tableView.txtStatus) {
        picker.tag=8;
        [picker selectRow:selectedIndex.status inComponent:0 animated:YES];
        [tableView.txtStatus setInputView:picker];
        _editEntity.status=[[_collections.statusTypes objectAtIndex:selectedIndex.status] code];
        [self addDoneButton:tableView.txtStatus];
    }else if (sender==tableView.txtApproID) {
        picker.tag=9;
        [picker selectRow:selectedIndex.approID  inComponent:0 animated:YES];
        [tableView.txtApproID setInputView:picker];
        if (selectedIndex.approID==0) {
            _editEntity.approID=0;
        }else{
            _editEntity.approID=[[_collections.staffTypes objectAtIndex:selectedIndex.approID-1] staffID];
        }
        [self addDoneButton:tableView.txtApproID];
    }
    
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
            return _collections.productTypes.count;
            break;
        case 2:
            return _collections.actionTypes.count;
            break;
        case 3:
            return _collections.distributorTypes.count;
            break;
        case 4:
            return _collections.resellerTypes.count;
            break;
        case 5:
            return _collections.stockTypes.count;
            break;
        case 6:
            return _collections.staffTypes.count;
            break;
        case 7:
            return _collections.reasonTypes.count;
            break;
        case 8:
            return _collections.statusTypes.count;
            break;
        case 9:
            return _collections.staffTypes.count+1;
            break;
    }
    return 0;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
            return [[_collections.productTypes objectAtIndex:row] displayValue];
            break;
        case 2:
            return [[_collections.actionTypes objectAtIndex:row] displayValue];
            break;
        case 3:
            return [[_collections.distributorTypes objectAtIndex:row] displayValue];
            break;
        case 4:
            return [[_collections.resellerTypes objectAtIndex:row] displayValue];
            break;
        case 5:
            return [[_collections.stockTypes objectAtIndex:row] displayValue];
            break;
        case 6:
            return [[_collections.staffTypes objectAtIndex:row] displayValue];
            break;
        case 7:
            return [[_collections.reasonTypes objectAtIndex:row] displayValue];
            break;
        case 8:
            return [[_collections.statusTypes objectAtIndex:row] displayValue];
            break;
        case 9:
            if (row==0) {
                return @"";
            }else {
                return [[_collections.staffTypes objectAtIndex:row-1] displayValue];
            }
            break;
    }
    return @"";
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
            selectedIndex.attributeID=row;
            _editEntity.attributeID=[[_collections.productTypes objectAtIndex:row] code];
            tableView.txtProduct.text=[[_collections.productTypes objectAtIndex:row] displayValue];
            break;
        case 2:
            _editEntity.type=[[_collections.actionTypes objectAtIndex:row] code];
            tableView.txtAction.text=[[_collections.actionTypes objectAtIndex:row] displayValue];
            selectedIndex.type=row;
            break;
        case 3:
            _editEntity.distributorID=[[_collections.distributorTypes objectAtIndex:row] code];
            tableView.txtDistributor.text=[[_collections.distributorTypes objectAtIndex:row] displayValue];
            selectedIndex.distributorID=row;
            break;
        case 4:
            _editEntity.resellerID=[[_collections.resellerTypes objectAtIndex:row] code];
            tableView.txtReseller.text=[[_collections.resellerTypes objectAtIndex:row] displayValue];
            selectedIndex.resellerID=row;
            break;
        case 5:
            _editEntity.stockID=[[_collections.stockTypes objectAtIndex:row] code];
            tableView.txtStock.text=[[_collections.stockTypes objectAtIndex:row] displayValue];
            selectedIndex.stockID=row;
            break;
        case 6:
            _editEntity.staffID=[[_collections.staffTypes objectAtIndex:row] staffID];
            tableView.txtStaff.text=[[_collections.staffTypes objectAtIndex:row] displayValue];
            selectedIndex.staffID=row;
            break;
        case 7:
            _editEntity.reasonID=[[_collections.reasonTypes objectAtIndex:row] code];
            tableView.txtReason.text=[[_collections.reasonTypes objectAtIndex:row] displayValue];
            selectedIndex.reasonID=row;
            break;
        case 8:
            _editEntity.status=[[_collections.statusTypes objectAtIndex:row] code];
            tableView.txtStatus.text=[[_collections.statusTypes objectAtIndex:row] displayValue];
            selectedIndex.status=row;
            break;
        case 9:
            if (row!=0) {
                tableView.txtApproID.text=[[_collections.staffTypes objectAtIndex:row-1] displayValue];
                _editEntity.approID=[[_collections.staffTypes objectAtIndex:row-1] staffID];
            }else {
                tableView.txtApproID.text=@"";
            }
            
            selectedIndex.approID=row;
            NSLog(@"%d",row);
            break;

    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //khspProDetailSegue
    if ([segue.identifier isEqualToString:@"khspProDetailSegue"]) {
        MasterStockKHSPViewController *controller=segue.destinationViewController;
        controller.delegate=self;
        controller.collections=self.collections;
        controller.editEntity=self.editEntity;
    }
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}
-(void)moveNext{
    MasterStockKHSPViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ttct_khsp_Controller"];
    controller.collections=self.collections;
    controller.delegate=self;
    controller.editEntity=self.editEntity;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void) updateItemController:(MasterStockKHSPViewController *)controller destroyItem:(KHSPEntity *)item;
{
    [self.delegate updateItemController:self destroyItem:item];
}
- (void) updateItemController:(MasterStockKHSPViewController *)controller activeItem:(KHSPEntity *)item;
{
    [self.delegate updateItemController:self activeItem:item];
}
-(void)updateItemController:(MasterStockKHSPViewController *)controller addItem:(KHSPEntity *)item {
    [self.delegate updateItemController:self addItem:item];
    
}

- (void) addDoneButton:(UITextField *)textField{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(hideKeyboard)];
    
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpace,doneButton, nil]];
    textField.inputAccessoryView=keyboardDoneButtonView;
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
//                  _editEntity.issueNo = tableView.txtSoCV.text;
//                  _editEntity.reasonID = [[_collections.reasonTypes objectAtIndex:selectedIndex.reasonID] code];
//                  _editEntity.resellerID = [[_collections.resellerTypes objectAtIndex:selectedIndex.resellerID]code];
                  [self.delegate updateItemController:self addItem:_editEntity];
                  [self doBack:nil];
              }else {
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Có lỗi khi lưu đơn hàng. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
              }
              
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } ];
    
}
-(void) CancelData{
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
                  [self doBack:nil];
              }else {
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Có lỗi khi huỷ đơn hàng. Vui lòng thử lại sau." cancelButtionTitle:@"Đồng ý"];
              }
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } ];

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= MAX_LENGTH || returnKey;
    }
@end