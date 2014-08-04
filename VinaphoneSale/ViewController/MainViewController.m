//
//  MainViewController.m
//  VinaphoneSale
//
//  Created by comic on 7/15/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "VnpSaleUtils.h"
#import "FunctionEntity.h"
#import "MainCellView.h"
#import "TraCuuGiaoDichViewController.h"
#import "QuanLyDiemBanViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize functions=_functions, data=_data;
-(BOOL)prefersStatusBarHidden {
    return YES;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array=[self.data objectForKey:@"data_permit"];
    _functions=[[NSMutableArray alloc] init];
    for(int i=0; i<array.count; i++) {
        NSString *path=[[array objectAtIndex:i] objectForKey:@"PATH"];
        NSString *permission=[[array objectAtIndex:i] objectForKey:@"RIGHT_CODE"];
        NSRange isRange = [permission rangeOfString:@"S" options:NSCaseInsensitiveSearch];
        if (![path isEqualToString:@"/danhmuc_smartphone"] && isRange.location>0) {
            FunctionEntity *entity=[[FunctionEntity alloc] initWithData:[array objectAtIndex:i]];
            [_functions addObject:entity];
        }
    }
    


}
-(void)doLogout:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"functionCell";
    MainCellView *mainCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    FunctionEntity *entity=[_functions objectAtIndex:indexPath.item];
    mainCell.icon.image = [UIImage imageNamed:entity.icon];
    mainCell.title.text=entity.title;
    mainCell.backgroundColor=entity.backgroundColor;
    mainCell.entity=entity;
    return mainCell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [_functions count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FunctionEntity *entity=[_functions objectAtIndex:indexPath.item];
    
    if ([entity.path isEqualToString:@"/client/bh_tructiep"]) {
        TraCuuGiaoDichViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"traCuuGiaoDichViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([entity.path isEqualToString:@"/client/khhh"]) {
        
        TraCuuGiaoDichViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"khspViewController"];
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if ([entity.path isEqualToString:@"/client/ql_diemban"]){
        QuanLyDiemBanViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"quanLyDBViewController"];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else{
        //unknowController
        [[[UIAlertView alloc] initWithTitle:@"Thong bao"
                                    message:[NSString stringWithFormat:@"Chuc nang dang xay dung:%@%ld", entity.path,(long)indexPath.item]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}
@end
