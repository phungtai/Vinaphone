//
//  QuanLyDiemBanViewController.m
//  VinaphoneSale
//
//  Created by Mac on 8/1/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import "QuanLyDiemBanViewController.h"
#import "QuanLyDiemBanTableViewCell.h"
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constant.h"
#import "VnpSaleUtils.h"
#import "MainViewController.h"
#import "QLDBEntity.h"
#import "ThongTinDiemBanViewController.h"
@interface QuanLyDiemBanViewController ()

@end

@implementation QuanLyDiemBanViewController
@synthesize tblQlDiemBan,tblAgent,reponse, tblData= _tblData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tblData = [[NSMutableArray alloc]initWithCapacity:10];
    [self searchAgent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) searchAgent{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters;
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,URL_GET_AGENT_BY_STAFF_SERVLET] parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              reponse = responseObject;
              NSLog(@"%@",reponse);
              NSString *code = [reponse objectForKey:@"code"];
              switch ([code intValue]) {
                  //Lỗi mạng
                  case -2:
                      [self.navigationController popToRootViewControllerAnimated:YES];
                      break;
                  //Bình thường
                  case 0:
                  {

                      [self getDataFromServer];
                      [self.tblQlDiemBan reloadData];
                      
                  }
                      break;
                  default:
                      break;
              }
           [MBProgressHUD hideHUDForView:self.view animated:YES];
          }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [VnpSaleUtils showAlertwithNetworkError:error];
          }];
     }
- (IBAction)doback:(id)sender {
    NSLog(@"doback");
    [self.navigationController popViewControllerAnimated:YES];
 //   MainViewController *contro = [[MainViewController alloc] init];
 //   [self.navigationController popToViewController:contro animated:YES];
}
-(void)getDataFromServer{
    NSArray *data = [reponse objectForKey:@"data"];
    NSDictionary *dic;
    for (int i = 0; i < data.count; i++) {
        dic = [data objectAtIndex:i];
        QLDBEntity *entity = [[QLDBEntity alloc] initWithDictionary:dic];
        [_tblData addObject:entity];
    }
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tblData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"tbvQLDiemBan";
    QuanLyDiemBanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    QLDBEntity *entity = [_tblData objectAtIndex:indexPath.row];
    cell.stt.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.txtMaDB.text = [NSString stringWithFormat:@"%d", entity.agentID];
    cell.txtNguoiDD.text = entity.contactName;
    cell.txtAdress.text =  entity.address;
    selectedIndex = indexPath.row;
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"editTTDiemBan"]) {
        ThongTinDiemBanViewController *control = segue.destinationViewController;
      //  control.delegate = self;
        selectedEntity = [_tblData objectAtIndex:selectedIndex];
        control.editEtity = selectedEntity;
        
    }else if ([segue.identifier isEqualToString:@"addTTDiemBan"]){
        ThongTinDiemBanViewController *control = segue.destinationViewController;
      //  control.delegate = self;
    }
}
@end
