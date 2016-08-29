//
//  CYForumViewController.m
//  茶语
//
//  Created by Chayu on 16/2/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYForumViewController.h"
#import "CYQuanZiTopCell.h"
#import "CYQuanZiItemCell.h"
#import "CYQuanZiNeiRongCell.h"
#import "CYQuanZiLIstViewController.h"
#import "CYDaoHangViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "CYMyViewController.h"
#import "CYQuanZiDetailController.h"
#import "CYTopicDetailController.h"
@interface CYForumViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //顶部大图
    NSString *cover;
    //
    NSMutableArray *quanziArr;
    NSMutableArray *huatiArr;
    NSMutableArray *huatiList;
    NSInteger page;
    BOOL is_sign;//是否签到
    OSMessage *message;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;



@end

@implementation CYForumViewController

#pragma mark - UIView Life-Cycle methods

- (void)dealloc
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:NO animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"圈子首页"];
    [APP_DELEGATE setTabbarHidden:NO animated:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"圈子首页"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loadVieData];
    });
}

- (IBAction)share_click:(id)sender {
    if (message.title.length) {
        [self showActionSheet:message];
    }
}


- (IBAction)gotodaohang_click:(id)sender {
    CYDaoHangViewController *vc = viewControllerInStoryBoard(@"CYDaoHangViewController", @"Home");
    
    //    
    //    
    //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYDaoHangViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)usercenter_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatkongNavBar];
    message = [[OSMessage alloc] init];
    _tableView.hidden = YES;
    page = 1;
    quanziArr = [NSMutableArray array];
    huatiArr = [NSMutableArray array];
    huatiList = [NSMutableArray array];
    _bottom_cons.constant = 65 *(SCREEN_WIDTH/375.);
    [self loadVieData];
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadhuatilistData:NO];
        
    }];
    
    
    //    [_tableView.header beginRefreshing];
    
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadhuatilistData:YES];
    }];
    
}


-(void)loadVieData
{
    
    [CYWebClient Post:@"2.0_quanzi" parametes:nil success:^(id responObject) {
        NSDictionary *shareInfo = [responObject objectForKey:@"share"];
        if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
            message.imgUrl = [shareInfo objectForKey:@"thumb"];
            message.link = [shareInfo objectForKey:@"url"];
            message.title = [shareInfo objectForKey:@"title"];
            message.desc = [shareInfo objectForKey:@"description"];
        }
        NSArray *quanzi =[responObject objectForKey:@"quanzi"];
        NSArray *huati = [responObject objectForKey:@"huati"];
        if (![quanzi isKindOfClass:[NSNull class]] && quanzi.count) {
            [quanziArr removeAllObjects];
            [quanziArr addObjectsFromArray:[responObject objectForKey:@"quanzi"]];
        }
        
        
        if (![huati isKindOfClass:[NSNull class]] && huati.count) {
            [huatiArr removeAllObjects];
            [huatiArr addObjectsFromArray:[responObject objectForKey:@"huati"]];
        }
        
        cover = [responObject objectForKey:@"banner"];
        is_sign = [[responObject objectForKey:@"is_sign"] boolValue];
        [_tableView reloadData];
        [self loadhuatilistData:NO];
        
    } failure:^(id error) {
        _tableView.hidden = NO;
    }];
}


-(void)loadhuatilistData:(BOOL)loadMore
{
    __weak __typeof(self) weakSelf = self;
    if (loadMore) {
        page ++;
    }else{
        page = 1;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:@(page) forKey:@"pageNo"];
    [CYWebClient Post:@"2.0_quanzi_index_lists" parametes:param success:^(id responObject) {
        weakSelf.tableView.hidden = NO;
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [huatiList removeAllObjects];
            [_tableView reloadData];
        }
        
        NSArray *list = [responObject objectForKey:@"list"];
        if ([list count]<10) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        [huatiList addObjectsFromArray:list];
        [_tableView reloadData];
        //        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
        if ([huatiList count]<10) {
            weakSelf.tableView.footer = nil;
        }
        
    } failure:^(id error) {
        weakSelf.tableView.hidden = NO;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section  == 0) {
        return 1;
    }else if (section ==1){
        return 1;
    }else if(section == 2){
        return [huatiArr count];
    }else{
        return [huatiList count];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 71+195*SCREENBILI;
    }else if (indexPath.section == 1)
    {
        return 200;
    }else{
        return 131;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CYQuanZiTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYQuanZiTopCell"];
        [cell.topImg sd_setImageWithURL:[NSURL URLWithString:cover] placeholderImage:[UIImage imageNamed:@"750×400"]];
        if (is_sign) {
            cell.qiandaoBtn.selected = YES;
            cell.qiandaoBtn.userInteractionEnabled = NO;
        }
        __weak __typeof(cell) weakSelf = cell;
        cell.menuclickBlock = ^(NSInteger select){
            if (select <2) {
                CYQuanZiLIstViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYQuanZiLIstViewController"];
                if (select == 1) {
                    vc.isHuati = YES;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                [CYWebClient basePost:@"2_quanzi.group.do_sign" parametes:nil success:^(id responObject) {
                    NSInteger state = [[responObject objectForKey:@"state"] integerValue];
                    if (state == 400) {
                        weakSelf.qiandaoBtn.selected = YES;
                        weakSelf.qiandaoBtn.userInteractionEnabled = NO;
                    }
                    
                } failure:^(id error) {
                    
                }];
            }
            
            
            
            //
            
        };
        return cell;
    }else if (indexPath.section == 1){
        CYQuanZiItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYQuanZiItemCell"];
        cell.info = quanziArr;
        cell.quanziBlock = ^(NSInteger selectindex){
            NSDictionary *info = quanziArr[selectindex];
            NSDictionary *source = [info objectForKey:@"source"];
            CYQuanZiDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYQuanZiDetailController"];
            vc.gid = [source objectForKey:@"gid"];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else if(indexPath.section ==2){
        CYQuanZiNeiRongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYQuanZiNeiRongCell"];
        NSDictionary *info = huatiArr[indexPath.row];
        NSString *imgStr = [info objectForJSONKey:@"thumb"];
        if (imgStr.length>0) {
            cell.left_img_cons.constant = 20;
            cell.showImg.hidden = NO;
            [cell.showImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:SQUARE];
        }else{
            cell.left_img_cons.constant = -90;
            cell.showImg.hidden = YES;
        }
        
        cell.titleLb.text = [info objectForJSONKey:@"title"];
        cell.contentLbl.text = [info objectForJSONKey:@"content"];
        NSDictionary *source = [info objectForJSONKey:@"source"];
        if (![source isKindOfClass:[NSNull class]]) {
            cell.pinglunLbl.text = [source objectForJSONKey:@"replies"];
            cell.liulanLbl.text = [source objectForJSONKey:@"hits"];
        }
        
        return cell;
    }else{
        CYQuanZiNeiRongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYQuanZiNeiRongCell"];
        NSDictionary *info = huatiList[indexPath.row];
        NSString *imgStr = [info objectForJSONKey:@"attach"];
        //        if (imgStr.length) {
        //              [cell.showImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:SQUARE];
        //        }
        //        
        if (imgStr.length>0) {
            cell.left_img_cons.constant = 20;
            cell.showImg.hidden = NO;
            [cell.showImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:SQUARE];
        }else{
            cell.left_img_cons.constant = -90;
            cell.showImg.hidden = YES;
        }
        
        cell.titleLb.text = [info objectForJSONKey:@"subject"];
        cell.contentLbl.text = [info objectForJSONKey:@"content"];
        NSDictionary *source = [info objectForJSONKey:@"source"];
        if (!source || [source isKindOfClass:[NSNull class]]) {
            cell.pinglunLbl.text = [info objectForJSONKey:@"replies"];
            cell.liulanLbl.text = [info objectForJSONKey:@"hits"];
        }
        
        return cell;
    }
    
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >=2) {
        if (indexPath.section ==3) {
            NSDictionary *info = huatiList[indexPath.row];
            CYTopicDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYTopicDetailController"];
            vc.tid = [info objectForKey:@"tid"];
            vc.gid = @"";//[info objectForKey:@"gid"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSDictionary *info = huatiArr[indexPath.row];
            NSDictionary *source = [info objectForJSONKey:@"source"];
            CYTopicDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYTopicDetailController"];
            vc.tid = [source objectForKey:@"tid"];
            vc.gid = @"";//[info objectForKey:@"gid"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (IBAction)navbar_clicked:(id)sender
{
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:message];
    
}

@end
