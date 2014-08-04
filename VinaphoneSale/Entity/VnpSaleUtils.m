//
//  VnpSaleUtils.m
//  VinaphoneSale
//
//  Created by comic on 7/16/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnpSaleUtils.h"
@implementation VnpSaleUtils
+(NSString*) getImageIconWithPath: (NSString*) path permission:(NSString*) permission{
    if ([path isEqualToString:@"/client/bh_tructiep"]) {
        return @"banhangtructiep.png";
    }else if ([path isEqualToString:@"/client/cstb"]) {
        return @"hoamangthuebao.png";
    }else if ([path isEqualToString:@"/client/dktt"]) {
        return @"dangkythongtin.png";
    }else if ([path isEqualToString:@"/client/khhh"]) {
        return @"unlock.png";
    }else if ([path isEqualToString:@"/client/ql_diemban"]) {
        return @"quanlydiemban.png";
    }else if ([path isEqualToString:@"/client/ql_tuyen"]) {
        return @"quanlytuyen.png";
    }else if ([path isEqualToString:@"/client/thucuoc"]) {
        return @"thucuoc.png";
    }else if ([path isEqualToString:@"/client/tracuu_tkdc"]) {
        return @"tracuu_tkdatcoc.png";
    }else if ([path isEqualToString:@"/danhmuc_smartphone"]) {
        return @"change_pwd.png";
    }
    
    return @"icon_search.png";
}

+(UIColor*) getBackgroundColorWithPath: (NSString*) path permission:(NSString*) permission{
    if ([path isEqualToString:@"/client/bh_tructiep"]) {
        return [self colorWithHexString:@"1BA1E2"];
    }else if ([path isEqualToString:@"/client/cstb"]) {
        return [self colorWithHexString:@"00A000"];
    }else if ([path isEqualToString:@"/client/dktt"]) {
        return [self colorWithHexString:@"A100A8"];
    }else if ([path isEqualToString:@"/client/khhh"]) {
        return [self colorWithHexString:@"6A00FF"];
    }else if ([path isEqualToString:@"/client/ql_diemban"]) {
        return [self colorWithHexString:@"D34927"];
    }else if ([path isEqualToString:@"/client/ql_tuyen"]) {
        return [self colorWithHexString:@"0A55BE"];
    }else if ([path isEqualToString:@"/client/thucuoc"]) {
        return [self colorWithHexString:@"29DD00"];
    }else if ([path isEqualToString:@"/client/tracuu_tkdc"]) {
        return [self colorWithHexString:@"E22E0A"];
    }
    return [self colorWithHexString:@""];
}

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
+(NSString*) getTitleWithPath: (NSString*) path permission:(NSString*) permission {
    if ([path isEqualToString:@"/client/bh_tructiep"]) {
        return @"Bán hàng trực tiếp";
    }else if ([path isEqualToString:@"/client/cstb"]) {
        return @"Chọn số thuê bao";
    }else if ([path isEqualToString:@"/client/dktt"]) {
        return @"Đăng ký thông tin";
    }else if ([path isEqualToString:@"/client/khhh"]) {
        return @"Kích hoạt hàng hoá";
    }else if ([path isEqualToString:@"/client/ql_diemban"]) {
        return @"Quản lý điểm bán";
    }else if ([path isEqualToString:@"/client/ql_tuyen"]) {
        return @"Quản lý tuyến";
    }else if ([path isEqualToString:@"/client/thucuoc"]) {
        return @"Thu cước";
    }else if ([path isEqualToString:@"/client/tracuu_tkdc"]) {
        return @"Tra cứu TKDC";
    }else if ([path isEqualToString:@"/danhmuc_smartphone"]) {
        return @"Đổi mật khẩu";
        
    }
    return @"Tiêu đề";
}
+(void) showDialogWithTitle: (NSString*) title message:(NSString*) message cancelButtionTitle:(NSString*)cancelTitle {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:cancelTitle
                      otherButtonTitles:nil] show];
}
+(void)showAlertwithNetworkError:(NSError *)error {
    NSString *message=[NSString stringWithFormat:@"Lỗi không xác định. Mã lỗi:%ld",(long)error.code];
    [VnpSaleUtils showDialogWithTitle:@"Thông báo" message:message cancelButtionTitle:@"Đồng ý"];
}

@end
