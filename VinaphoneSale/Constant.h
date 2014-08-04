//
//  Constant.h
//  VinaphoneSale
//
//  Created by comic on 7/15/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//
#define VERSION @"1.0"
//#define kBaseUrl @"http://192.168.200.7:6989/vnp_qlsp"
#define kBaseUrl @"http://113.185.0.90:6080/vnp_qlsp"
#define URL_LOGIN @"/login"
#define URL_GETOTP @"/setOtpPass"
#define URL_DEFINE_ACTIVE_PRODUCT @"/getProductRelease"
#define URL_SEARCH_ACTIVE_PRODUCT @"/searchProductRelease"
#define URL_GET_STOCK_SERIAL @"/getListStockSerial"
#define URL_GET_PRODUCT_DETAIL @"/getProReleaseDetail"
#define URL_DESTROY_PRODUCT_RELEASE @"/destroyProductRelease"
#define URL_ACTIVE_PRODUCT_RELEASE @"/activeProduct"
#define URL_INSERT_PRODUCT_RELEASE @"/insertProductRelease"
#define URL_GET_AGENT_BY_STAFF_SERVLET @"/getAgentByStaffServlet" //Lấy danh sách điểm bán
#define URL_INSERT_AGENT @"/insertAgent" // Tạo điểm bán mới
#define URL_UPDATE_AGENT @"/updateAgent" //update điểm bán
#define   MAX_LENGTH 15

#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define BeginIgnoreAllEvent() [[UIApplication sharedApplication] beginIgnoringInteractionEvents]
#define EndIgnoreAllEvent() [[UIApplication sharedApplication] endIgnoringInteractionEvents]