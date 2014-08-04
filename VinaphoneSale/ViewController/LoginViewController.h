
//  Created by CHANGE MY LIFE on 12/11/13.
//  Copyright (c) 2013 TechMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
}
@property (weak, nonatomic)IBOutlet UITextField *txtUserName;
@property (weak, nonatomic)IBOutlet UITextField *txtPassword;
@property (weak, nonatomic)IBOutlet UITextField *txtPin;
@property (weak, nonatomic)IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)IBOutlet UIButton *btnLogin;
@property (weak, nonatomic)IBOutlet UIButton *btnOtp;
- (IBAction)doLogin:(id)sender;
- (IBAction)doGetOTP:(id)sender;
@end
