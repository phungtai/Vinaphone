//
//  QLDBEntity.m
//  VinaphoneSale
//
//  Created by Mac on 8/2/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import "QLDBEntity.h"

@implementation QLDBEntity
-(QLDBEntity *)initWithDictionary:(NSDictionary *)dic{
    QLDBEntity *entity = [[QLDBEntity alloc]init];
    entity.address = [dic objectForKey:@"ADDRESS"];
    entity.agentCityID = [[dic objectForKey:@"AGENT_CITY_ID"] integerValue];
    entity.agentCode = [dic objectForKey:@"AGENT_CODE"];
    entity.agentCityID = [[dic objectForKey:@"AGENT_COUNTY_ID"] integerValue];
    entity.agentID = [[dic objectForKey:@"AGENT_ID"]integerValue];
    entity.agentStateID = [[dic objectForKey:@"AGENT_STATE_ID"]integerValue];
    entity.agentType = [[dic objectForKey:@"AGENT_TYPE"]integerValue];
    entity.assignStaffID = [[dic objectForKey:@"ASSIGN_STAFF_ID"]integerValue];
    entity.contactBirdDay = [dic objectForKey:@"CONTACT_BIRDDAY"];
    entity.contactEmail = [dic objectForKey:@"CONTACT_EMAIL"];
    entity.contactName = [dic objectForKey:@"CONTACT_NAME"];
    entity.contactPhone = [[dic objectForKey:@"CONTACT_PHONE"] longLongValue];
    entity.contactTel = [[dic objectForKey:@"CONTACT_TEL"]longLongValue];
    entity.contractTitle = [dic objectForKey:@"CONTRACT_TITLE"];
    entity.contractDate = [dic objectForKey:@"CONTRACT_DATE"];
    entity.contractNumber = [[dic objectForKey:@"CONTRACT_NUMBER"]integerValue];
    entity.createDate = [dic objectForKey:@"CREATE_DATE"];
    entity.displayValue = [dic objectForKey:@"DISPLAY_VALUE"];
    entity.eloadNumber = [dic objectForKey:@"ELOAD_NUMBER"];
    entity.fromDate = [dic objectForKey:@"FROM_DATE"];
    entity.image = [dic objectForKey:@"IMAGE"];
    entity.isApprove = [[dic objectForKey:@"IS_APPROVE"] integerValue];
    entity.latitude = [[dic objectForKey:@"LATITUDE_ID"] longLongValue];
    entity.longitude = [[dic objectForKey:@"LONGITUDE_ID"] longLongValue];
    entity.reSeller = [[dic objectForKey:@"RESELLER_ID"] integerValue];
    entity.signboard = [[dic objectForKey:@"SIGNBOARD"] integerValue];
    entity.signboardDate = [dic objectForKey:@"SIGNBOARD_DATE"];
    entity.staff_ID = [[dic objectForKey:@"STAFF_ID"]integerValue];
    entity.status = [[dic objectForKey:@"STATUS"] integerValue];
    entity.tin = [[dic objectForKey:@"TIN"] integerValue];
    entity.toDate = [dic objectForKey:@"TO_DATE"];
    entity.userName = [dic objectForKey:@"USER_NAME"];
    return entity;
}
@end
