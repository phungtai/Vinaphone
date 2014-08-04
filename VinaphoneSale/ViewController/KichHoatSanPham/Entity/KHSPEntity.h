//
//  KHSPEntity.h
//  VinaphoneSale
//
//  Created by comic on 7/19/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHSPEntity : NSObject
@property (strong, nonatomic)  NSString *createDate;
@property (strong, nonatomic)  NSString *description;
@property (strong, nonatomic)  NSString *issueDate;
@property (strong, nonatomic)  NSString *issueNo;// so cong van 
@property (strong, nonatomic)  NSString *userName;
@property NSInteger approID;// nguoi phe duyet
@property NSInteger attributeID;//loai san pham
@property NSInteger distributorID;//nha phan phoi
@property NSInteger reasonID;//Ly do
@property NSInteger resellerID;// don vi kich hoat
@property NSInteger staffID;// nguoi kich hoat
@property NSInteger status;// trang thai: 1: hoan tat, 2: tao moi
@property NSInteger stockID;// kho
@property NSInteger type; //
@property NSInteger productReleaseID;// khoa chinh don hang
@property NSMutableArray *stockDetails;
- (KHSPEntity*) initWithDictionary:(NSDictionary*) dic;
-(NSString*) getJSONString;
-(NSDictionary*) getDictionary ;
@end