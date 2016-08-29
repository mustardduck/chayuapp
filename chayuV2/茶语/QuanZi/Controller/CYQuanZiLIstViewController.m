//
//  CYQuanZiLIstViewController.m
//  茶语
//
//  Created by Chayu on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiLIstViewController.h"
#import "CYTopMenuView.h"
#import "CYQuanZiListCell.h"
#import "CYHuaTiListCell.h"
#import "CYQuanZiDetailController.h"
#import "CYTopicDetailController.h"
#import "CYFenLeiListView.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
@interface CYQuanZiLIstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *param;
    NSInteger page;
    NSMutableArray *dataArr;
    
    OSMessage * _shareMsg;
}
@property (nonatomic,strong)CYTopMenuView *topView;

- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic)CYFenLeiListView *fenleiView;

@property (nonatomic, strong)CYFenLeiListView *zuixinView;

@property (weak, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation CYQuanZiLIstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shareMsg = [[OSMessage alloc] init];
    
    [self.view addSubview:self.topView];
    NSArray *menuArr = @[@{@"name":@"全部分类"},@{@"name":@"人气"}];
    [self.topView initwithMen:menuArr];
    page = 1;
    
    param = [NSMutableDictionary dictionary];
    [param setObject:@"hot" forKey:@"order"];
    [param setObject:@"" forKey:@"catid"];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:@(page) forKey:@"p"];
    dataArr =[NSMutableArray array];
    [self creatkongNavBar];
    
    __weak __typeof(self) weakSelf = self;
    weakSelf.topView.buttonSelectIndex = ^(NSInteger selindex){
        switch (selindex) {
            case 0:
            {
                weakSelf.zuixinView.hidden = YES;
                weakSelf.fenleiView.hidden = !weakSelf.fenleiView.hidden;
                break;
            }
            case 1:
            {
                weakSelf.zuixinView.hidden = !weakSelf.zuixinView.hidden;
                weakSelf.fenleiView.hidden = YES;
                break;
            }
                
            default:
                break;
        }
    };
    [self loadcategorylist];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadquanziListData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadquanziListData:YES];
    }];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

-(void)loadcategorylist
{
    
    [self.view addSubview:self.fenleiView];
    [self.view addSubview:self.zuixinView];
    NSArray *nameArr = @[@{@"name":@"人气"},@{@"name":@"最新"}];
    self.zuixinView.dataArr = nameArr;
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"bbs_category_list" parametes:nil success:^(id responObject) {
        NSMutableArray * cArr = [NSMutableArray array];
        [cArr addObjectsFromArray:responObject];
        
        weakSelf.fenleiView.dataArr = cArr;
        
    } failure:^(id error) {
        
    }];
    
    weakSelf.zuixinView.quanziCateBlock = ^(NSDictionary *info){
        NSString *name = [info objectForKey:@"name"];
        if ([name isEqualToString:@"最新"]) {
            [param setObject:@"" forKey:@"order"];
        }else{
            [param setObject:@"hot" forKey:@"order"];
        }
        weakSelf.zuixinView.hidden = YES;
        weakSelf.topView.selectTitle = [info objectForKey:@"name"];
        [weakSelf loadquanziListData:NO];
        
    };
    
    
    weakSelf.fenleiView.quanziCateBlock = ^(NSDictionary *info){
        weakSelf.fenleiView.hidden = YES;
        weakSelf.topView.selectTitle = [info objectForKey:@"name"];
        NSString *cateid = [info objectForKey:@"catid"];
        [param setObject:cateid forKey:@"catid"];
        [weakSelf loadquanziListData:NO];
    };
    
}

- (CYFenLeiListView *)fenleiView
{
    if (!_fenleiView) {
        _fenleiView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _fenleiView.frame = CGRectMake(0,90*SCREENBILI+60,SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI-60);
        _fenleiView.hidden = YES;
    }
    return _fenleiView;
}

- (CYFenLeiListView *)zuixinView
{
    if (!_zuixinView) {
        _zuixinView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _zuixinView.frame = CGRectMake(0,90*SCREENBILI+60,SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI-60);
        _zuixinView.hidden = YES;
        
    }
    return _zuixinView;
}


-(void)loadquanziListData:(BOOL)loadMore
{
    
    if (loadMore) {
        page ++;
    }else{
        page = 1;
    }
    [param setObject:@(page) forKey:@"p"];
    __weak __typeof(self) weakSelf = self;
    
    NSString *servpath = @"bbs_topic_list";
    if (!_isHuati) {
        servpath =@"bbs_group_list";
    }
    
    [CYWebClient basePost:servpath parametes:param success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        NSArray *data = [responObject objectForKey:@"data"];
        if (state == 400) {
            NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0)
            {
                _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            
            if (!loadMore) {
                [dataArr removeAllObjects];
                [weakSelf.tableView reloadData];
            }
            
            if (loadMore) {
                [weakSelf.tableView.footer endRefreshing];
            }else{
                [weakSelf.tableView.header endRefreshing];
            }
            
            if ([data count]<10) {
                [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.tableView.footer resetNoMoreData];
            }
            
            //            if ([dataArr count]<10) {
            //                weakSelf.tableView.footer = nil;
            //            }
            [dataArr addObjectsFromArray:data];
            
            if(dataArr.count)
            {
                [weakSelf.tableView reloadData];
                
                weakSelf.emptyView.hidden = YES;
            }
            else
            {
                weakSelf.emptyView.hidden = NO;
            }
        }
        
    } failure:^(id error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (CYTopMenuView *)topView
{
    if (!_topView) {
        _topView =[[CYTopMenuView alloc] initWithFrame:CGRectMake(0,90*SCREENBILI, SCREEN_WIDTH,60)];
    }
    return _topView;
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    if (_isHuati) {
        return 131.;
    }
    return 110.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isHuati) {
        CYHuaTiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHuaTiListCell"];
        cell.info = dataArr[indexPath.row];
        return cell;
    }else{
        CYQuanZiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYQuanZiListCell"];
        cell.info = dataArr[indexPath.row];
        cell.guanzhuBlock = ^(NSDictionary *info){
            //            bbs_group_attention
            if (!MANAGER.isLoged) {
                [APP_DELEGATE showLogView];
            }
            [CYWebClient Post:@"bbs_group_attention" parametes:@{@"gid":[info objectForKey:@"gid"]} success:^(id responObject) {
                if (![responObject isKindOfClass:[NSNull class]] && [responObject count]>0) {
                    NSMutableDictionary *quanziInfo = [NSMutableDictionary dictionaryWithDictionary:info];
                    [quanziInfo setObject:[responObject objectForJSONKey:@"attentionnum"] forKey:@"attentionnum"];
                    [quanziInfo setObject:@"1" forKey:@"isattention"];
                    [dataArr replaceObjectAtIndex:indexPath.row withObject:quanziInfo];
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
                
                //                [quanziInfo setObject:@"" forKey:@""];
                
            } failure:^(id error) {
                
            }];
            
        };
        return cell;
    }
    
    
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info =  dataArr[indexPath.row];
    if (!_isHuati) {
        CYQuanZiDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYQuanZiDetailController"];
        vc.gid = [info objectForKey:@"gid"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CYTopicDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYTopicDetailController"];
        vc.tid = [info objectForKey:@"tid"];
        vc.gid = [info objectForKey:@"gid"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)gotousercenter_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)navbar_clicked:(id)sender
{
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
    
}

@end
