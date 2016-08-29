//
//  CYSouSuoZongHeViewController.m
//  茶语
//
//  Created by Chayu on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSouSuoZongHeViewController.h"
#import "CYZonHeSearchCell.h"
#import "CYZongHeFooter.h"
#import "CYZongHeHeader.h"
#import "CYSouSuoChaPingCell.h"
#import "CYSouSuoHuaTiCell.h"
#import "CYSouSuoShiJiCell.h"
#import "CYSouSuoQuanZiCell.h"
#import "CYSouSuoWengZhangCell.h"
#import "CYSearchReMenFooter.h"
#import "CYSouSuoLiShiHeader.h"
#import "CYSouSuoFenLeiListController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYProductDetViewController.h"
#import "CYTopicDetailController.h"
#import "CYWenZhangDetailsController.h"
#import "CYQuanZiDetailController.h"

@interface CYSouSuoZongHeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *teaInfo;
    NSDictionary *goodsList;
    NSDictionary *shequList;
    NSDictionary *articleList;
    NSMutableArray *listArr;
    NSMutableArray *sousuoLishiArr;
    NSMutableArray *dataArr;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *searchBg;
@property (weak, nonatomic) IBOutlet UITableView *lishitableView;


@property (weak, nonatomic) IBOutlet UIView *lishiBgView;

@property (nonatomic,strong)CYSearchReMenFooter *remenFooter;

@property (weak, nonatomic) IBOutlet UITextField *searchTf;
@property (weak, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation CYSouSuoZongHeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatkongNavBar];
    listArr = [NSMutableArray array];
    sousuoLishiArr = [NSMutableArray array];
    UIView *view = _searchBg;
    view.layer.cornerRadius = 3.0f;
    page = 1;
    _searchTf.text = _keyWord;
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [self loadsuoyousousuoinfo];
    dataArr = [NSMutableArray array];
    _tableView.hidden = YES;
    //    [self loadquanziListData:NO];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CYSearchReMenFooter *)remenFooter
{
    if (!_remenFooter) {
        _remenFooter = [[[NSBundle mainBundle] loadNibNamed:@"CYSearchReMenFooter" owner:nil options:nil] firstObject];
        _remenFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI);
    }
    
    return _remenFooter;
}


-(void)loadsuoyousousuoinfo
{
    
    __weak __typeof(self) weakSelf = self;
    NSString *servpath =@"2.0_search.integrated_search";
    [CYWebClient Post:servpath parametes:@{@"q":_keyWord} success:^(id responObject) {
        teaInfo = [responObject objectForKey:@"tea"];
        goodsList =  [responObject objectForKey:@"goodsList"];
        shequList =  [responObject objectForKey:@"shequList"];
        articleList = [responObject objectForKey:@"articleList"];
        
        NSInteger count = 0;
        
        if([[teaInfo objectForJSONKey:@"total"] integerValue])
        {
            count ++;
        }
        if([[goodsList objectForJSONKey:@"total"] integerValue])
        {
            count ++;
        }
        if([[shequList objectForJSONKey:@"total"] integerValue])
        {
            count ++;
        }
        if([[articleList objectForJSONKey:@"total"] integerValue])
        {
            count ++;
        }
        
        if(count)
        {
            [weakSelf.tableView reloadData];
            weakSelf.tableView.hidden = NO;
            weakSelf.emptyView.hidden = YES;
        }
        else
        {
            weakSelf.tableView.hidden = YES;
            weakSelf.emptyView.hidden = NO;
        }
        
    } failure:^(id error) {
        
    }];
}


-(void)loadquanziListData:(BOOL)loadMore
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
        [weakSelf.tableView reloadData];
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
        if (section == 0) {
            NSArray *teaArr = [teaInfo objectForKey:@"list"];
            return [teaArr count];
        }else if (section == 1){
            NSArray *shijiArr = [goodsList objectForKey:@"list"];
            return [shijiArr count];
        }else if (section == 2){
            NSArray *shequArr = [shequList objectForKey:@"list"];
            return [shequArr count];
        }else{
            NSArray *articleArr = [articleList objectForKey:@"list"];
            return [articleArr count];
        }
    }
    return [sousuoLishiArr count];
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView != _tableView) {
        return 1;
    }
    return 4;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != _tableView) {
        return 50.0;
    }
    return 130.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        if (indexPath.section == 0) {
            NSArray *teaArr = [teaInfo objectForKey:@"list"];
            NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
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
        }else if (indexPath.section == 1){
            NSArray *teaArr = [goodsList objectForKey:@"list"];
            NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
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
        }else if (indexPath.section == 2){
            NSArray *teaArr = [shequList objectForKey:@"list"];
            NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
            NSString *dataType = [info objectForKey:@"dataType"];
            if ([dataType isEqualToString:@"group"]) {//圈子
                CYSouSuoQuanZiCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYSouSuoQuanZiCell"];
                cell.titleLbl.text = [info objectForKey:@"name"];
                cell.guanzhuLbl.text = [NSString stringWithFormat:@"关注：%@",[info objectForKey:@"attentionnum"]];
                cell.tieziLbl.text = [NSString stringWithFormat:@"帖子：%@",[info objectForKey:@"topics"]];
                cell.quanzhuLbl.text = [NSString stringWithFormat:@"圈主：%@",[info objectForKey:@"created_nickname"]];
                NSString *thumb = [info objectForKey:@"logo"];
                if (thumb.length >0) {
                    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
                }
                return cell;
            }else{//话题
                CYSouSuoHuaTiCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYSouSuoHuaTiCell"];
                cell.titleLbl.text = [info objectForKey:@"subject"];
                cell.contentLbl.text =[info objectForKey:@"content"];
                cell.pinglunLbl.text = [[info objectForKey:@"replies"] description];
                cell.liulanLbl.text = [[info objectForKey:@"hits"] description];
                NSString *thumb = [info objectForKey:@"group_logo"];
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
            NSArray *teaArr = [articleList objectForKey:@"list"];
            NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        NSArray *teaList = [teaInfo objectForJSONKey:@"list"];
        NSArray *goodsArr = [goodsList objectForJSONKey:@"list"];
        NSArray *shequlist = [shequList objectForJSONKey:@"list"];
        NSArray *arcList = [articleList objectForJSONKey:@"list"];
        CYZongHeHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"CYZongHeHeader" owner:nil options:nil] firstObject];
        header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        switch (section) {
            case 0:
            {
                if ([teaList count] ==0) {
                    return nil;
                }
                NSString *numStr = [NSString stringWithFormat:@"(共找到%@条相关内容)",[teaInfo objectForJSONKey:@"total"]];
                header.numLbl.text = numStr;
                header.leixingLbl.text = @"茶评";
                NSString *num = [teaInfo objectForJSONKey:@"total"];
                if (num.length >0 &&![num isKindOfClass:[NSNull class]]) {
                    [header.numLbl setFontColor:[UIColor getColorWithHexString:@"893e20"] fontSize:FONT(14) string:num];
                }
                
                
                break;
            }
            case 1:
            {
                
                if ([goodsArr count] ==0) {
                    return nil;
                }
                NSString *numStr = [NSString stringWithFormat:@"(共找到%@条相关内容)",[goodsList objectForJSONKey:@"total"]];
                header.numLbl.text = numStr;
                NSString *num = [goodsList objectForJSONKey:@"total"];
                if (num.length >0 &&![num isKindOfClass:[NSNull class]]) {
                    [header.numLbl setFontColor:[UIColor getColorWithHexString:@"893e20"] fontSize:FONT(14) string:num];
                }
                header.leixingLbl.text = @"市集";
                
                break;
            }
            case 2:
            {
                if ([shequlist count] ==0) {
                    return nil;
                }
                NSString *numStr = [NSString stringWithFormat:@"(共找到%@条相关内容)",[shequList objectForJSONKey:@"total"]];
                header.numLbl.text = numStr;
                header.leixingLbl.text = @"圈子";
                NSString *num = [shequList objectForJSONKey:@"total"];
                if (num.length >0 &&![num isKindOfClass:[NSNull class]]) {
                    [header.numLbl setFontColor:[UIColor getColorWithHexString:@"893e20"] fontSize:FONT(14) string:num];
                }
                break;
            }
            case 3:
            {
                if ([arcList count] ==0) {
                    return nil;
                }
                NSString *numStr = [NSString stringWithFormat:@"(共找到%@条相关内容)",[articleList objectForJSONKey:@"total"]];
                header.numLbl.text = numStr;
                NSString *num = [articleList objectForJSONKey:@"total"];
                if (num.length >0 &&![num isKindOfClass:[NSNull class]]) {
                    [header.numLbl setFontColor:[UIColor getColorWithHexString:@"893e20"] fontSize:FONT(14) string:num];
                }
                header.leixingLbl.text = @"文章";
                break;
            }
                
            default:
                break;
        }
        
        return header;
    }else{
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
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == _tableView) {
        NSArray *teaList = [teaInfo objectForJSONKey:@"list"];
        NSArray *goodsArr = [goodsList objectForJSONKey:@"list"];
        NSArray *shequlist = [shequList objectForJSONKey:@"list"];
        NSArray *arcList = [articleList objectForJSONKey:@"list"];
        if (section ==0) {
            if (teaList.count == 0) {
                return 0.000001;
            }
        }else if (section ==1){
            if (goodsArr.count == 0) {
                return 0.000001;
            }
            
        }else if (section == 2){
            if (shequlist.count == 0) {
                return 0.000001;
            }
            
        }else if (section == 3){
            if (arcList.count == 0) {
                return 0.000001;
            }
            
        }
        return 40.0f;
    }else{
        return 50.0f;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        NSArray *teaList = [teaInfo objectForJSONKey:@"list"];
        NSArray *goodsArr = [goodsList objectForJSONKey:@"list"];
        NSArray *shequlist = [shequList objectForJSONKey:@"list"];
        NSArray *arcList = [articleList objectForJSONKey:@"list"];
        if (section == 0) {
            if (teaList.count == 0) {
                return nil;
            }
        }else if (section == 1){
            if (goodsArr.count == 0) {
                return nil;
            }
        }else if (section ==2){
            if (shequlist.count == 0) {
                return nil;
            }
        }else if (section == 3){
            if (arcList.count == 0) {
                return nil;
            }
        }
        
        CYZongHeFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"CYZongHeFooter" owner:nil options:nil] firstObject];
        footer.frame = CGRectMake(0, 0, SCREEN_WIDTH,75);
        footer.moreBtn.tag = 600+ section;
        [footer.moreBtn addTarget:self action:@selector(loadMoreInfo:) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }else{
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
        return nil;
    }
    
}


-(void)gengduolishi_click:(UIButton *)sender
{
    
}

-(void)loadMoreInfo:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 600;
    CYSouSuoFenLeiListController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYSouSuoFenLeiListController"];
    switch (selectIndex) {
        case 0://茶评
        {
            vc.searchType = SearchTypeChaPing;
            break;
        }
        case 1://市集
        {
            vc.searchType = SearchTypeShiJi;
            break;
        }
        case 2://圈子
        {
            vc.searchType = SearchTypeQuanZi;
            break;
        }
        case 3://文章
        {
            vc.searchType = SearchTypeWenZhang;
            break;
        }
            
        default:
            break;
    }
    vc.keyWord = _searchTf.text;
    vc.moreInfo = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        NSArray *teaList = [teaInfo objectForJSONKey:@"list"];
        NSArray *goodsArr = [goodsList objectForJSONKey:@"list"];
        NSArray *shequlist = [shequList objectForJSONKey:@"list"];
        NSArray *arcList = [articleList objectForJSONKey:@"list"];
        if (section == 0) {
            if (teaList.count == 0) {
                return 0.0000000001;
            }
        }else if (section ==1){
            if (goodsArr.count == 0) {
                return 0.0000000001;
            }
        }else if (section ==2){
            if (shequlist.count == 0) {
                return 0.0000000001;
            }
        }else if (section ==3){
            if (arcList.count == 0) {
                return 0.0000000001;
            }
        }
        
        return 75;
    }else{
        return 50.0f;
    }
    
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
        [tableView reloadData];
        [self loadsuoyousousuoinfo];
    }else{
        switch (indexPath.section) {
            case 0://茶评
            {
                NSArray *teaArr = [teaInfo objectForKey:@"list"];
                NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
                CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
                vc.mTeaId = [info objectForKey:@"id"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1://市集
            {
                NSArray *teaArr = [goodsList objectForKey:@"list"];
                NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
                CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                vc.goodId = [info objectForKey:@"goods_id"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2://圈子
            {
                NSArray *teaArr = [shequList objectForKey:@"list"];
                NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
                NSString *dataType = [info objectForKey:@"dataType"];
                if ([dataType isEqualToString:@"group"]) {
                    CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
                    vc.gid = [info objectForJSONKey:@"gid"];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
                    vc.tid = [info objectForKey:@"tid"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                break;
            }
            case 3://文章
            {
                NSArray *teaArr = [articleList objectForKey:@"list"];
                NSDictionary *info = [teaArr objectAtIndex:indexPath.row];
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



- (IBAction)goback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark -
#pragma mark UITextFieldDelegate  method
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    _lishiBgView.hidden = NO;
    ChaYuer *manager =  MANAGER;
    [sousuoLishiArr removeAllObjects];
    [sousuoLishiArr addObjectsFromArray:manager.searchArr];
    //    [_lishitableView reloadData];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *strUrl = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strUrl.length == 0) {
        [Itost showMsg:@"输入的关键字不能为空" inView:self.view];
        return NO;
    }
    //    _lishiBgView.hidden = YES;
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
    [self loadsuoyousousuoinfo];
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


@end
