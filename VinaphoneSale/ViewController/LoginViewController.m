//
//  LoginScreen1ViewController.m
//  VINAPHONEBSS
//
//  Created by CHANGE MY LIFE on 12/11/13.
//  Copyright (c) 2013 TechMobile. All rights reserved.
//

#import "LoginViewController.h"
#include "Constant.h"
#import "AFNetworking.h"
#import "MainViewController.h"
#import "VnpSaleUtils.h"
#import "MBProgressHUD.h"
@implementation LoginViewController
-(BOOL)prefersStatusBarHidden {
    return YES;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    self.txtUserName.delegate=self;
    self.txtPassword.delegate=self;
    self.txtPin.delegate=self;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.navigationItem.title=@"Thoát";
    // getting an NSString
    NSString *userName = [prefs stringForKey:@"userLogin"];
    NSString *password = [prefs stringForKey:@"passLogin"];
    self.txtUserName.text=userName;
    self.txtPassword.text=password;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    self.txtUserName.text= NULL;
//    self.txtPassword.text= NULL;
//    self.txtPin.text = NULL;
//}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}
-(void)hideKeyboard
{
    [self.txtUserName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtPin resignFirstResponder];
    
}
-(void)doLogin:(id)sender {
    [self hideKeyboard];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strUser=self.txtUserName.text;
    NSString *strPassword=self.txtPassword.text;
    if (strUser==nil) {
        strUser=@"";
    }
    if (strPassword==nil) {
        strPassword=@"";
    }
    if (![strUser isEqualToString:@""] && ![strPassword isEqualToString:@""]) {
        NSString *strPin=self.txtPin.text;
        
        
        if (strPin==nil) {
            strPin=@"";
        }
       
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"user_name": strUser,@"password":strPassword,
                                     @"otp":strPin,@"version":VERSION,@"system":@"ios"};
        
        [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_LOGIN] parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *response=responseObject;
                  NSLog(@"LOGIN:%@",response);
                  NSString *code=[response objectForKey:@"code"];
                  //Truyền dữ liệu qua view khác
                  NSDictionary  *dataUser;
                  dataUser = [response objectForKey:@"data"];

                  NSUserDefaults *passingValue = [NSUserDefaults standardUserDefaults];
                  [passingValue setObject:dataUser forKey:@"data"];
                  
                  if (code!=nil){
                       if (code.integerValue==0 && [code.lowercaseString isEqualToString: @"otp"]) {
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"OTP không đúng" cancelButtionTitle:@"Đồng ý"];
                      } else if (code.integerValue==0 && [code.lowercaseString isEqualToString: @"otp_date"]) {
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"OTP đã hết hạn" cancelButtionTitle:@"Đồng ý"];
                      } else if (code.integerValue==0 && [code.lowercaseString isEqualToString: @"old_version"]) {
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Phiên bản sử dụng không đúng. Vui lòng update phiên bản mới" cancelButtionTitle:@"Đồng ý"];
                      }else if (code.integerValue==0) {
                          NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                          [prefs setObject:self.txtUserName.text forKey:@"userLogin"];
                          [prefs setObject:self.txtPassword.text forKey:@"passLogin"];
                          
                          MainViewController *mainView=[self.storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
                          mainView.data=response;
                          [self.navigationController pushViewController:mainView animated:YES];
                      }else if (code.integerValue==-2) {
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Tài khoản hoặc mật khẩu không đúng." cancelButtionTitle:@"Đồng ý"];

                      }else {
                          NSString *message=[NSString stringWithFormat:@"Lỗi không xác định. Mã lỗi:%ld",(long)code.integerValue];
                          [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:message cancelButtionTitle:@"Đồng ý"];
                      }
                  }else{
                      NSString *message=[NSString stringWithFormat:@"Lỗi không xác định. Mã lỗi:%@",code.lowercaseString];
                      [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:message cancelButtionTitle:@"Đồng ý"];
                  }
        
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [VnpSaleUtils showAlertwithNetworkError:error];
        
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
              } ];
    }
}
-(void)doGetOTP:(id)sender{
    [self hideKeyboard];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"USER_NAME": self.txtUserName.text};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_GETOTP] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *response=responseObject;
              NSLog(@"GETOTP:%@",response);
              NSString *code=[response objectForKey:@"code"];
              if (code!=nil && code.integerValue==0){
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:@"Mã OTP đã được gửi qua tin nhắn. Vui lòng kiểm tra hộp thư SMS." cancelButtionTitle:@"Đồng ý"];
              }else {
                  NSString *message=[NSString stringWithFormat:@"Lỗi không xác định. Mã lỗi:%ld",(long)code.integerValue];
                  [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:message cancelButtionTitle:@"Đồng ý"];
              }
              [MBProgressHUD hideHUDForView:self.view animated:YES];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          } ];
}
@end
