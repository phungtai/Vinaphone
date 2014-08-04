//
//  VnpSaleUtils.h
//  VinaphoneSale
//
//  Created by comic on 7/16/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VnpSaleUtils:NSObject
{
    
}
+(NSString *) getImageIconWithPath: (NSString*) path permission:(NSString*) permission;
+(UIColor *) getBackgroundColorWithPath: (NSString*) path permission:(NSString*) permission;
+(UIColor*)colorWithHexString:(NSString*)hex;
+(NSString *) getTitleWithPath: (NSString*) path permission:(NSString*) permission;
+(void) showDialogWithTitle: (NSString*) title message:(NSString*) message cancelButtionTitle:(NSString*)cancelTitle ;
+(void) showAlertwithNetworkError: (NSError*) error;
@end