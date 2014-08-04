//
//  ThongTinDiemBanTableView.h
//  VinaphoneSale
//
//  Created by Mac on 8/4/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThongTinDiemBanTableView : UITableView
@property(nonatomic,strong)IBOutlet UITextField *txtAddress; // Địa chỉ điểm bán
@property(nonatomic,strong)IBOutlet UITextField *txtAgentCode; // Mã điểm bán
@property(nonatomic,strong)IBOutlet UITextField *txtContactBirdDay; //Sinh nhật người đại diện
@property(nonatomic,strong)IBOutlet UITextField *txtContactEmail; // Email ng dd
@property(nonatomic,strong)IBOutlet UITextField *txtContactName; // Tên người dd
@property(nonatomic,strong)IBOutlet UITextField *txtContractTitle; //CHức danh
@property(nonatomic,strong)IBOutlet UITextField *txtContractDate; //
@property(nonatomic,strong)IBOutlet UITextField *txtCreateDate; //Ngày thành lập dB
@property(nonatomic,strong)IBOutlet UITextField *txtDisplayValue; //Tên đb
@property(nonatomic,strong)IBOutlet UITextField *txtEloadNumber; //Số eload
@property(nonatomic,strong)IBOutlet UITextField *txtFromDate; //
@property(nonatomic,retain)IBOutlet UIImage *txtImage;
@property(nonatomic,retain)IBOutlet UITextField *txtSignboardDate; //Ngày ký
@property(nonatomic,strong)IBOutlet UITextField *txtToDate;
@property(nonatomic,strong)IBOutlet UITextField *txtUserName; //Tên ông đăng nhập


@property(nonatomic,strong)IBOutlet UITextField* txtAgentCityID; //Mã thành phố
@property(nonatomic,strong)IBOutlet UITextField* txtAgentID; // Mã điểm bán
@property(nonatomic,strong)IBOutlet UITextField* txtAgentCountyID; //Mã phương xã
@property(nonatomic,strong)IBOutlet UITextField* txtAgentStateID; // mã quận huyện
@property(nonatomic,strong)IBOutlet UITextField* txtAgentType; // loại ĐB
@property(nonatomic,strong)IBOutlet UITextField* txtAssignStaffID; //
@property(nonatomic,strong)IBOutlet UITextField* txtContractNumber; // số ??? người đại diện
@property(nonatomic,strong)IBOutlet UITextField* txtIsApprove; //trương đc giao hay chưa, được giao = 1, ko đc = 0
@property(nonatomic,strong)IBOutlet UITextField* txtSignboard; //Biển hiệu
@property(nonatomic,strong)IBOutlet UITextField* txtReSeller; // Người
@property(nonatomic,strong)IBOutlet UITextField* txtStaff_ID; //
@property(nonatomic,strong)IBOutlet UITextField* txtStatus; //
@property(nonatomic,strong)IBOutlet UITextField* txtTin; // số thuế

@property(nonatomic,strong)IBOutlet UITextField *txtContactPhone; // phone người đại diện
@property(nonatomic,strong)IBOutlet UITextField *txtContactTel; // """
@property(nonatomic,strong)IBOutlet UITextField *txtLatitude; //
@property(nonatomic,strong)IBOutlet UITextField *txtLongitude; //

@end
