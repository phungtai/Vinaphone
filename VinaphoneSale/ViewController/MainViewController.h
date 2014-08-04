//
//  MainViewController.h
//  VinaphoneSale
//
//  Created by comic on 7/15/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
   
}
@property (strong, nonatomic)  NSDictionary *data;
@property (strong, nonatomic)  NSMutableArray *functions;
-(IBAction) doLogout:(id)sender;

@end