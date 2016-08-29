//
//  CYQuanZiDetailController.m
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiDetailController.h"
#import "CYQuanZiDetTopCell.h"
#import "CYHuaTiListCell.h"
#import "CYTopicDetailController.h"
#import "CYPostCardViewController.h"
#import "CYShenQingQuanZhuController.h"
@interface CYQuanZiDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *params;
    NSDictionary *groupInfo;
    NSMutableArray *listArr;
    NSInteger page;
    
    OSMessage * _shareMsg;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;



- (IBAction)goback:(id)sender;

@end

@implementation CYQuanZiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shareMsg = [[OSMessage alloc] init];
    
    [self creatkongNavBar];
    params = [NSMutableDictionary dictionary];
    page = 1;
    [params setObject:@"" forKey:@"sort"];
    [params setObject:@(page) forKey:@"p"];
    [params setObject:@"10" forKey:@"pageSize"];
    listArr = [NSMutableArray array];
    _tableView.hidden = YES;
//    [self loadVieData];
     __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadVieData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadVieData:YES];
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadVieData:(BOOL)loadMore
{
    if (_gid.length) {
        
        if (loadMore) {
            page ++;
        }else{
            page = 1;
        }
        [params setObject:@(page) forKey:@"p"];
        [params setObject:_gid forKey:@"gid"];
        __weak __typeof(self) weakSelf = self;
        [CYWebClient Post:@"bbs_group_detail" parametes:params success:^(id responObject) {
            NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            if (loadMore) {
                [weakSelf.tableView.footer endRefreshing];
            }else{
                [weakSelf.tableView.header endRefreshing];
                [listArr removeAllObjects];
                
            }
            _tableView.hidden = NO;
            groupInfo = [responObject objectForKey:@"groupInfo"];
            NSArray *list = [responObject objectForKey:@"list"];
            if (list.count <10 ) {
                weakSelf.tableView.footer = nil;
            }else{
                weakSelf.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf loadVieData:YES];
                }];
            }
        
            [listArr addObjectsFromArray:list];
            [_tableView reloadData];
        } failure:^(id error) {
            
        }];
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

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return [listArr count];
    }
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170.0f;
    }else{
        return 131.0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CYQuanZiDetTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYQuanZiDetTopCell"];
        cell.info = groupInfo;
        cell.fatieBlock = ^(){
            CYPostCardViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPostCardViewController"];
            vc.gid = _gid;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.menuBlock = ^(NSInteger selectIndex){
            if (selectIndex == 0) {
                [params setObject:@"" forKey:@"sort"];
            }else{
                [params setObject:@"1" forKey:@"sort"];
            }
            [self loadVieData:NO];
        };
        
        [cell.shenqingBtn addTarget:self action:@selector(shenqingquanzhu_click:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        CYHuaTiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHuaTiListCell"];
        cell.isQuanZiDetails = YES;
        cell.info = listArr[indexPath.row];
        return cell;
    }
}


- (void)shenqingquanzhu_click:(UIButton *)sender {
    //    2.0_quanzi.group.applay_manger
    CYShenQingQuanZhuController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CYShenQingQuanZhuController"];
    vc.quanziId =_gid;
    vc.quanziName = [groupInfo objectForJSONKey:@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>0) {
        NSDictionary *info = listArr[indexPath.row];
        CYTopicDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYTopicDetailController"];
        vc.gid = [info objectForJSONKey:@"gid"];
        vc.tid  = [info objectForKey:@"tid"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)zhijiefenxiang_click:(UIButton *)sender {
    
    switch (sender.tag) {
        case 320:
        {
            [self sharePengYouQuan:_shareMsg];
            break;
        }
        case 321:
        {
            [self shareWeiXin:_shareMsg];
            break;
        }
        case 322:
        {
            [self shareQQ:_shareMsg];
            break;
        }
            
        default:
            break;
    }
    
}

- (IBAction)navbar_clicked:(id)sender
{
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
    
}


@end
