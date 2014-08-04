//
//  QLDBEntity.h
//  VinaphoneSale
//
//  Created by Mac on 8/2/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QLDBEntity : NSObject
@property(nonatomic,strong) NSString *address; // Địa chỉ điểm bán
@property(nonatomic,strong) NSString *agentCode; // Mã điểm bán
@property(nonatomic,strong) NSString *contactBirdDay; //Sinh nhật người đại diện
@property(nonatomic,strong) NSString *contactEmail; // Email ng dd
@property(nonatomic,strong) NSString *contactName; // Tên người dd
@property(nonatomic,strong) NSString *contractTitle; //CHức danh
@property(nonatomic,strong) NSString *contractDate; //
@property(nonatomic,strong) NSString *createDate; //Ngày thành lập dB
@property(nonatomic,strong) NSString *displayValue; //Tên đb
@property(nonatomic,strong) NSString *eloadNumber; //Số eload
@property(nonatomic,strong) NSString *fromDate; //
@property(nonatomic, retain) UIImage *image;
@property(nonatomic,retain) NSString *signboardDate; //Ngày ký
@property(nonatomic, strong) NSString *toDate;
@property(nonatomic,strong)NSString *userName; //Tên ông đăng nhập


@property NSInteger agentCityID; //Mã thành phố
@property NSInteger agentID; // Mã điểm bán
@property NSInteger agentCountyID; //Mã phương xã
@property NSInteger agentStateID; // mã quận huyện
@property NSInteger agentType; // loại ĐB
@property NSInteger assignStaffID; //
@property NSInteger contractNumber; // số ??? người đại diện
@property NSInteger isApprove; //trương đc giao hay chưa, được giao = 1, ko đc = 0
@property NSInteger signboard; //Biển hiệu
@property NSInteger reSeller; // Người
@property NSInteger staff_ID; //
@property NSInteger status; //
@property NSInteger tin; // số thuế

@property long long contactPhone; // phone người đại diện
@property long long contactTel; // """
@property long long latitude; //
@property long long longitude; //



-(QLDBEntity *) initWithDictionary: (NSDictionary *) dic;
@end
