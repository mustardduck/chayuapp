//
//  CYSouSuoFenLeiListController.m
//  茶语
//
//  Created by Chayu on 16/7/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSouSuoFenLeiListController.h"
#import "CYSearchReMenFooter.h"
#import "CYSouSuoChaPingCell.h"
#import "CYSouSuoQuanZiCell.h"
#import "CYSouSuoHuaTiCell.h"
#import "CYSouSuoShiJiCell.h"
#import "CYSouSuoWengZhangCell.h"
#import "CYSouSuoLiShiHeader.h"
#import "CYGengDuoLiShiViewController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYWenZhangDetailsController.h"
#import "CYTopicDetailController.h"
#import "CYProductDetViewController.h"
@interface CYSouSuoFenLeiListController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSMutableArray *dataArr;
    NSMutableArray *listArr;
    NSMutableArray *sousuoLishiArr;
}
- (IBAction)goback:(id)sender;



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *searchTf;
@property (weak, nonatomic) IBOutlet UIView *searchBg;


@property (weak, nonatomic) IBOutlet UITableView *lishitableView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;


@property (weak, nonatomic) IBOutlet UIView *lishiBgView;

@property (nonatomic,strong)CYSearchReMenFooter *remenFooter;

@property (weak, nonatomic) IBOutlet UILabel *numLbl;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

@end

@implementation CYSouSuoFenLeiListController

- (void)viewDidLoad {
    [super viewDidLoad];
    listArr = [NSMutableArray array];
    sousuoLishiArr = [NSMutableArray array];
    UIView *view = _searchBg;
    view.layer.cornerRadius = 3.0f;
    dataArr = [NSMutableArray array];
    ChaYuer *manager =  MANAGER;
    [sousuoLishiArr removeAllObjects];
    [sousuoLishiArr addObjectsFromArray:manager.searchArr];
    [_lishitableView reloadData];
    [self loadReMenFenlei:NO];;
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadquanziListData:NO];
        
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadquanziListData:YES];
    }];
    if (_keyWord.length>0) {
        _searchTf.text = _keyWord;
        [SVProgressHUD setBackgroundColor:CLEARCOLOR];
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD show];
        [_tableView.header beginRefreshing];
    }
    
    
    
    
    NSString *stateImgName = @"";
    switch (_searchType) {
        case SearchTypeChaPing:
            stateImgName = @"chaping_search_icon";
            break;
        case SearchTypeShiJi:
            stateImgName = @"shiji_search_icon";
            break;
        case SearchTypeQuanZi:
            stateImgName = @"quanzi_search_icon";
            break;
        case SearchTypeWenZhang:
            stateImgName = @"wenzhang_search_icon";
            break;
            
        default:
            break;
    }
    _statusImg.image = [UIImage imageNamed:stateImgName];
    //     __weak __typeof(self) weakSelf = self;
    self.remenFooter.block = ^(UIButton *button,NSString *string){
        weakSelf.searchTf.text = string;
        [SVProgressHUD setBackgroundColor:CLEARCOLOR];
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD show];
        [weakSelf loadquanziListData:NO];
    };
    self.remenFooter.huanyipiBlock = ^(){
        [weakSelf loadReMenFenlei:YES];
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadReMenFenlei:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
        if (page>3) {
            page =1;
        }
    }else{
        page = 1;
    };
    __weak __typeof(self) weakSelf = self;
    NSString *servpath =@"2.0_search_word";
    [CYWebClient basePost:servpath parametes:@{@"p":@(page)} success:^(id responObject) {
        NSArray *list = [responObject objectForKey:@"list"];
        if ([list isKindOfClass:[NSArray class]]) {
            [dataArr removeAllObjects];
            [dataArr addObjectsFromArray:list];
            weakSelf.remenFooter.dataArr = dataArr;
            weakSelf.lishitableView.tableFooterView = weakSelf.remenFooter;
            [weakSelf.lishitableView reloadData];
        }
        if (!_moreInfo) {
            _lishiBgView.hidden = NO;
        }
        
        [weakSelf.lishitableView reloadData];
    } failure:^(id error) {
        
    }];
}


- (CYSearchReMenFooter *)remenFooter
{
    if (!_remenFooter) {
        _remenFooter = [[[NSBundle mainBundle] loadNibNamed:@"CYSearchReMenFooter" owner:nil options:nil] firstObject];
        _remenFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI);
    }
    
    return _remenFooter;
}



-(void)loadquanziListData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page = 1;
    };
    __weak __typeof(self) weakSelf = self;
    
    NSString *servpath =nil;
    switch (_searchType) {
        case SearchTypeChaPing:
            servpath = @"2.0_search.tea";
            break;
        case SearchTypeShiJi:
            servpath = @"2.0_search.goods";
            break;
        case SearchTypeQuanZi:
            servpath = @"2.0_search.topic";
            break;
        case SearchTypeWenZhang:
            servpath = @"2.0_search.article";
            break;
            
        default:
            break;
    }
    [CYWebClient basePost:servpath parametes:@{@"p":@(page),@"pageSize":@"10",@"q":_searchTf.text} success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        NSArray *data =[responObject objectForKey:@"data"];
        weakSelf.numLbl.text = [NSString stringWithFormat:@"%@",[responObject objectForKey:@"count"]];
        if (state == 400) {
            if (!loadMore) {
                [listArr removeAllObjects];
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
            
            [listArr addObjectsFromArray:data];
            if ([listArr count]<10) {
                weakSelf.tableView.footer = nil;
            }
            
            weakSelf.lishiBgView.hidden = YES;
            
            if(listArr.count)
            {
                [weakSelf.tableView reloadData];
                weakSelf.emptyView.hidden = YES;
            }
            else
            {
                weakSelf.emptyView.hidden = NO;
            }
            
        }else{
            NSString *msg = [responObject objectForKey:@"msg"];
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(id error) {
        
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return [listArr count];
    }else{
        return [sousuoLishiArr count];
    }
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        return 130.0f;
    }else{
        return 50.0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        NSDictionary *info = [listArr objectAtIndex:indexPath.row];
        if (_searchType == SearchTypeChaPing) {
            CYSouSuoChaPingCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYSouSuoChaPingCell"];
            cell.titleLbl.text = [NSString stringWithFormat:@"[%@]%@",[info objectForKey:@"brand"],[info objectForKey:@"title"]];
            cell.chyupingfenLbl.text = [[info objectForKey:@"score"] description];
            cell.zonghepingfenLbl.text = [[info objectForKey:@"review_score"] description];
            cell.fenleiLbl.text = [NSString stringWithFormat:@"%@>%@",[info objectForKey:@"bigcate"],[info objectForKey:@"smallcate"]];
            cell.jiageLbl.text =[NSString stringWithFormat:@"参考价：￥%@",[info objectForKey:@"price"]];
            if([[info objectForKey:@"remain"] integerValue])
            {
                cell.kucunLbl.text = [NSString stringWithFormat:@"茶样库存：%@份",[info objectForKey:@"remain"]];
            }
            else
            {
                cell.kucunLbl.text = @"暂无茶样";
            }
            
            NSString *thumb = [info objectForKey:@"thumb"];
            if (thumb.length >0) {
                [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
            }
            return cell;
        }else if (_searchType == SearchTypeShiJi){
            CYSouSuoShiJiCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYSouSuoShiJiCell"];
            cell.titleLbl.text = [info objectForKey:@"title"];
            cell.contentLbl.text = [info objectForKey:@"name"];
            cell.nameLbl.text = [NSString stringWithFormat:@"%@|%@",[info objectForKey:@"goods_type_name"],[info objectForKey:@"realname"]];
            NSString *thumb = [info objectForKey:@"thumb"];
            if (thumb.length>0) {
                [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
            }
            NSString *price = [info objectForKey:@"price_app"];
            cell.priceLbl.text = [NSString stringWithFormat:@"￥%@",price];
            cell.yishouLbl.text = [NSString stringWithFormat:@"已售：%@",[info objectForKey:@"sales_count"]];
            return cell;
        }else if (_searchType == SearchTypeQuanZi){
            CYSouSuoHuaTiCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYSouSuoHuaTiCell"];
            cell.titleLbl.text = [info objectForKey:@"subject"];
            cell.contentLbl.text =[info objectForKey:@"content"];
            cell.pinglunLbl.text = [[info objectForKey:@"replies"] description];
            cell.liulanLbl.text = [info objectForKey:@"hits"];
            NSString *thumb = [info objectForKey:@"thumb"];
            if (thumb.length>0) {
                [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
                cell.img_left_cons.constant = 20;
                cell.showImg.hidden = NO;
            }else{
                cell.img_left_cons.constant = -80;
                cell.showImg.hidden = YES;
            }
            return cell;
        }else{
            CYSouSuoWengZhangCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYSouSuoWengZhangCell"];
            cell.titleLbl.text = [info objectForKey:@"title"];
            cell.zanLbl.text = [[info objectForKey:@"suports"] description];
            cell.liulanLbl.text = [[info objectForKey:@"clicks"] description];
            NSString *thumb = [info objectForKey:@"thumb"];
            if (thumb.length>0) {
                [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
                cell.img_left_cons.constant = 20;
                cell.showImg.hidden = NO;
            }else{
                cell.img_left_cons.constant = -80;
                cell.showImg.hidden = YES;
            }
            return cell;
        }
    }else{
        NSString *sousuolishiIdextify = @"sousuolishiIdextify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sousuolishiIdextify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sousuolishiIdextify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.textColor = [UIColor getColorWithHexString:@"333333"];
        cell.textLabel.font = FONT(14.0);
        cell.textLabel.text = sousuoLishiArr[indexPath.row];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView != _tableView) {
        if (sousuoLishiArr.count>0) {
            return 50.0;
        }
    }
    return 0.00000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView !=_tableView) {
        if (sousuoLishiArr.count >0) {
            CYSouSuoLiShiHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"CYSouSuoLiShiHeader" owner:nil options:nil] firstObject];
            header.shanchulishi = ^(){
                [sousuoLishiArr removeAllObjects];
                ChaYuer *user = [ChaYuManager getCurrentUser];
                user.searchArr = sousuoLishiArr;
                [ChaYuManager archiveCurrentUser:user];
                [_lishitableView reloadData];
            };
            return header;
        }else{
            return nil;
        }
    }
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView != _tableView) {
        if (sousuoLishiArr.count >3) {
            return 50;
        }
        return 0.0000001;
    }else{
        return 0.0000001;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView != _tableView) {
        if (sousuoLishiArr.count >3) {
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            line.backgroundColor = MAIN_BGCOLOR;
            [footer addSubview:line];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"更多搜索历史" forState:UIControlStateNormal];
            [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [button addTarget:self action:@selector(gengduolishi_click:) forControlEvents:UIControlEventTouchUpInside];
            [footer addSubview:button];
            return footer;
        }
    }
    return nil;
}

-(void)gengduolishi_click:(UIButton *)sender
{
    CYGengDuoLiShiViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYGengDuoLiShiViewController"];
    vc.keywordBlock = ^(NSString *keyWord){
        
    };
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _lishitableView) {
        //        _lishiBgView.hidden = YES;
        [_searchTf resignFirstResponder];
        _searchTf.text = sousuoLishiArr[indexPath.row];
        ChaYuer *user = [ChaYuManager getCurrentUser];
        [sousuoLishiArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        user.searchArr = sousuoLishiArr;
        [ChaYuManager archiveCurrentUser:user];
        //        [tableView reloadData];
        [SVProgressHUD setBackgroundColor:CLEARCOLOR];
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD show];
        [self loadquanziListData:NO];
    }else{
        NSDictionary *info = [listArr objectAtIndex:indexPath.row];
        switch (_searchType) {
            case SearchTypeChaPing:
            {
                CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
                vc.mTeaId = [info objectForKey:@"id"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case SearchTypeShiJi:
            {
                CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                vc.goodId = [info objectForKey:@"goods_id"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case SearchTypeQuanZi:
            {
                CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
                vc.tid = [info objectForKey:@"tid"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case SearchTypeWenZhang:
            {
                CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController",@"WenZhang");
                vc.wenzhangId = [info objectForKey:@"id"];;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
}



#pragma mark -
#pragma mark UITextFieldDelegate  method
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _lishiBgView.hidden = NO;
    ChaYuer *manager =  MANAGER;
    [sousuoLishiArr removeAllObjects];
    [sousuoLishiArr addObjectsFromArray:manager.searchArr];
    [_lishitableView reloadData];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *strUrl = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strUrl.length == 0) {
        [Itost showMsg:@"输入的关键字不能为空" inView:self.view];
        return NO;
    }
    _lishiBgView.hidden = YES;
    [textField resignFirstResponder];
    ChaYuer *user = [ChaYuManager getCurrentUser];
    NSMutableArray *searchArr= [[NSMutableArray alloc] init];
    [searchArr addObjectsFromArray:user.searchArr];
    [searchArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:textField.text]) {
            [searchArr removeObject:obj];
        }
    }];
    [searchArr insertObject:textField.text atIndex:0];
    user.searchArr = searchArr;
    [ChaYuManager archiveCurrentUser:user];
    [sousuoLishiArr removeAllObjects];
    [sousuoLishiArr addObjectsFromArray:user.searchArr];
    //    [_tableView reloadData];
    _keyWord = textField.text;
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [self loadquanziListData:NO];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [_searchTf resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    //    [sousuoLishiArr removeAllObjects];
    //    [_lishitableView reloadData];
    return YES;
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
