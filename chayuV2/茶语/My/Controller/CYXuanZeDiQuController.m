//
//  CYXuanZeDiQuController.m
//  茶语
//
//  Created by Chayu on 16/7/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYXuanZeDiQuController.h"
#import "FMDB.h"
#import "CYXuanZeQuYuCell.h"
#import "CYPersonalCenterViewController.h"

@interface CYXuanZeDiQuController ()<UITableViewDelegate,UITableViewDataSource>
{
    FMDatabase *fmdb;
    NSMutableArray *dataArr;
}

- (IBAction)goback:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CYXuanZeDiQuController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    [self openTheFMDB];
    if (_quyutype == CYQuYuTypeSheng) {
        [self loadAddressData:@"0" IsProvince:YES OrIsCity:NO OrIsArea:NO WithFirst:YES];
    }else if(_quyutype == CYQuYuTypeShi){
        [self loadAddressData:_quyuId IsProvince:NO OrIsCity:YES OrIsArea:NO WithFirst:YES];
    }else{
        [self loadAddressData:_quyuId IsProvince:NO OrIsCity:NO OrIsArea:YES WithFirst:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openTheFMDB
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chayu" ofType:@"db"];
    fmdb = [FMDatabase databaseWithPath:filePath];
    [fmdb open];
}

-(void)loadAddressData:(NSString *)parentid
            IsProvince:(BOOL)isProvince
              OrIsCity:(BOOL)isCity
              OrIsArea:(BOOL)isArea
             WithFirst:(BOOL)isFirst
{
    
    NSString *querySql = [NSString stringWithFormat:@"select * from tea_area where parentid = %@",parentid];
    FMResultSet *set = [fmdb executeQuery:querySql];
    while ([set next]) {
        NSMutableDictionary *Info = [NSMutableDictionary dictionary];
        [Info setObject: [set stringForColumn:@"name"] forKey:@"name"];
        [Info setObject: [set stringForColumn:@"areaid"] forKey:@"areaid"];
        if (isProvince) {
            [dataArr addObject:Info];
        }
        if (isCity) {
            [dataArr addObject:Info];
        }
        if (isArea) {
            [dataArr addObject:Info];
        }
        
    }
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *info = dataArr[indexPath.row];
    CYXuanZeQuYuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYXuanZeQuYuCell"];
    cell.titleLbl.text = [info objectForKey:@"name"];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = dataArr[indexPath.row];
    if (_quyutype != CYQuYuTypeQu) {
        CYXuanZeDiQuController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"CYXuanZeDiQuController"];
            vc.quyuId =[info objectForKey:@"areaid"];
        NSMutableDictionary *quyuDic = [NSMutableDictionary dictionary];
        if (_quyutype == CYQuYuTypeSheng) {
             vc.quyutype = CYQuYuTypeShi;
            [quyuDic setObject:[info objectForKey:@"name"] forKey:@"shengName"];
            [quyuDic setObject:[info objectForKey:@"areaid"] forKey:@"shengId"];
        }else{
             vc.quyutype = CYQuYuTypeQu;
            [quyuDic addEntriesFromDictionary:_quyuInfo];
            [quyuDic setObject:[info objectForKey:@"name"] forKey:@"shiName"];
            [quyuDic setObject:[info objectForKey:@"areaid"] forKey:@"shiId"];
        }
       
        vc.quyuInfo = quyuDic;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        NSMutableDictionary *quyuDic = [NSMutableDictionary dictionary];
        [quyuDic addEntriesFromDictionary:_quyuInfo];
        [quyuDic setObject:[info objectForKey:@"name"] forKey:@"quName"];
        [quyuDic setObject:[info objectForKey:@"areaid"] forKey:@"quId"];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"XUANZEQUYUNOTIFI" object:quyuDic];
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *aimVC = nil;
        for (NSInteger i=vcArr.count-1; i>=0; i--) {
            if ([vcArr[i] isKindOfClass:[CYPersonalCenterViewController class]]) {
                aimVC = vcArr[i];
                break;
            }
        }
        if (aimVC) {
            [self.navigationController popToViewController:aimVC animated:YES];
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
