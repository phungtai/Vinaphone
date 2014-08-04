//
//  ThongTinDiemBanViewController.m
//  VinaphoneSale
//
//  Created by Mac on 8/2/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import "ThongTinDiemBanViewController.h"
#import "ThongTinDiemBanTableView.h"
@interface ThongTinDiemBanViewController ()

@end
@implementation ThongTinDiemBanViewController
@synthesize editEtity,btnEdit;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Load view
    [self loadInitView];
        
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)doBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadInitView{
    if(editEtity.agentID ==0){
        [btnEdit setImage:[UIImage imageNamed:@"accept.png"] forState:UIControlStateNormal];
    }else{
        [btnEdit setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        tableView.txtLongitude.text = [NSString stringWithFormat:@"%lld", editEtity.longitude];
        tableView.txtLatitude.text = [NSString stringWithFormat:@"%lld", editEtity.latitude];
        tableView.txtAddress.text = editEtity.address;
        tableView.txtAgentCode.text = editEtity.agentCode;
        tableView.txtContactBirdDay.text = editEtity.contactBirdDay;
        tableView.txtContactName.text = editEtity.contactName;
        tableView.txtContactEmail.text = editEtity.contactEmail;
        tableView.txtContractTitle.text = editEtity.contractTitle;
        tableView.txtContractDate.text = editEtity.contractDate;
        tableView.txtCreateDate.text = editEtity.createDate;
        tableView.txtDisplayValue.text = editEtity.displayValue;
        tableView.txtEloadNumber.text = editEtity.eloadNumber;
        tableView.txtFromDate.text = editEtity.fromDate;
        tableView.txtSignboardDate.text = editEtity.signboardDate;
        tableView.txtToDate.text = editEtity.toDate;
        tableView.txtUserName.text = editEtity.userName;
        tableView.txtAgentCityID.text = [NSString stringWithFormat:@"%ld",(long)editEtity.agentCityID];
        tableView.txtAgentID.text = [NSString stringWithFormat:@"%ld", (long)editEtity.agentID];
        tableView.txtAgentCountyID.text = [NSString stringWithFormat:@"%ld", (long)editEtity.agentCountyID];
        tableView.txtAgentStateID.text = [NSString stringWithFormat:@"%ld",(long)editEtity.agentStateID];
        
        tableView.txtAgentType.text = [NSString stringWithFormat:@"%ld", (long)editEtity.agentType];
        tableView.txtAssignStaffID.text = [NSString stringWithFormat:@"%ld", (long)editEtity.assignStaffID];
        tableView.txtContractNumber.text = [NSString stringWithFormat:@"%ld", (long)editEtity.contractNumber];
        tableView.txtIsApprove.text = [NSString stringWithFormat:@"%ld", (long)editEtity.isApprove];
        tableView.txtSignboard.text = [NSString stringWithFormat:@"%ld",(long)editEtity.signboard];
        tableView.txtReSeller.text = [NSString stringWithFormat:@"%ld", (long)editEtity.reSeller];
        tableView.txtStaff_ID.text = [NSString stringWithFormat:@"%ld", (long)editEtity.staff_ID];
        tableView.txtStatus.text = [NSString stringWithFormat:@"%ld", (long)editEtity.status];
        tableView.txtTin.text = [NSString stringWithFormat:@"%ld",(long)editEtity.tin];
        tableView.txtContactPhone.text = [NSString stringWithFormat:@"%lld", editEtity.contactPhone];
        tableView.txtContactTel.text = [NSString stringWithFormat:@"%lld", editEtity.contactTel];
        
    }
}
@end
