//
//  MainCellView.h
//  VinaphoneSale
//
//  Created by comic on 7/17/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionEntity.h"
@interface MainCellView: UICollectionViewCell
@property (weak, nonatomic)IBOutlet UIImageView *icon;
@property (weak, nonatomic)IBOutlet UILabel *title;
@property (strong, nonatomic)  FunctionEntity *entity;
@end