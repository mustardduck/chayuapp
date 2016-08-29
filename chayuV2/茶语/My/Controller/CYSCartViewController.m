//
//  CYSCartViewController.m
//  TeaMall
//
//  Created by Chayu on 15/10/20.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYSCartViewController.h"
#import "CYShoppingTrolleyCell.h"
#import "CYShopTrolleyHeaderView.h"
#import "CYCartModel.h"
#import "CYPayTableViewController.h"
#import "CYConfirmOrderViewController.h"
#import "CYOrderDetailModel.h"
#import "CYProductDetViewController.h"
#define ADDBTNTAG 20000
#define LESSBTNTAG 30000
@interface CYSCartViewController ()<UITableViewDataSource,UITableViewDelegate,CYShoppingTrolleyCellDelegate>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_selectedIndexPathArray;
    NSMutableArray *_selectSectionArray;//选中头部试图部分
    NSInteger allGoodsNum;
    UILabel *cartNumLable;
//    UIButton *rightBtn;
    
}
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *clearingBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLbl;
- (IBAction)delete_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *deleteBg;
@property (weak, nonatomic) IBOutlet CYBorderButton *deleteBtn;
- (IBAction)goback:(id)sender;
- (IBAction)guangguang_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIButton *allbtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation CYSCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //self.barStyle = NavBarStyleNone;
    [self initTitleView];
    [self initVariable];
    [self addNavigationItem];
//    _emptyView.hidden = NO;
  
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"购物车"];
}

-(void)initVariable
{
    allGoodsNum = 0;
    _clearingBtn.layer.cornerRadius = 3.0f;
    _deleteBtn.layer.cornerRadius = 3.0f;
    _dataArr = [[NSMutableArray alloc] init];
    _selectedIndexPathArray = [[NSMutableArray alloc]init];
    _selectSectionArray = [[NSMutableArray alloc]init];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
      [MobClick beginLogPageView:@"购物车"];
    [_clearingBtn setTitle:@"结算" forState:UIControlStateNormal];
    _totalLbl.text = @"￥0.00";
    [_dataArr removeAllObjects];
    [_selectedIndexPathArray removeAllObjects];
    [_selectSectionArray removeAllObjects];
    [_tableView reloadData];
    _allbtn.selected = NO;
    [self loadViewData];
    
    [self loadCartNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,20, 120, 44)];
    titleView.backgroundColor = CLEARCOLOR;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,12, 80, 20)];
    titleLbl.text = @"购物车";
    titleLbl.x = titleView.center.x-40;
    titleLbl.font = FONT(17.0f);
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.backgroundColor = CLEARCOLOR;
    [titleView addSubview:titleLbl];
  
    cartNumLable = [[UILabel alloc] initWithFrame:CGRectMake(88,10,16,16)];
    cartNumLable.clipsToBounds = YES;
    cartNumLable.layer.cornerRadius = 8.0f;
    cartNumLable.backgroundColor = MAIN_COLOR;
    cartNumLable.font = FONT(12.0f);
    cartNumLable.hidden = YES;
    cartNumLable.textAlignment = NSTextAlignmentCenter;
    cartNumLable.textColor = [UIColor whiteColor];
    [titleView addSubview:cartNumLable];
    self.navigationItem.titleView = titleView;
}

-(void)loadViewData
{
    [CYWebClient Post:@"Cart" parametes:nil success:^(id responObj) {
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:[CYCartModel objectArrayWithKeyValuesArray:responObj]];
        if ([_dataArr count] == 0) {
            _emptyView.hidden = NO;
          [_rightBtn setTitle:@"" forState:UIControlStateNormal];
        _rightBtn.userInteractionEnabled = NO;
        }else{
            _emptyView.hidden = YES;
            [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//            [_rightBtn sizeToFit];
            _rightBtn.userInteractionEnabled = YES;
            _bottomView.hidden = NO;
            _tableView.hidden = NO;
            
        }
        [_tableView reloadData];
    } failure:^(id err) {
        
    }];
}

-(void)loadCartNum
{
    [CYWebClient Post:@"cartcount" parametes:nil success:^(id responObj) {
        if ([[responObj objectForJSONKey:@"count"]integerValue] == 0) {
            cartNumLable.hidden = YES;
          
        }else{
            cartNumLable.hidden = NO;
        }
       cartNumLable.text = [NSString stringWithFormat:@"%d",(int)[[responObj objectForJSONKey:@"count"]integerValue]];
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}


- (void)addNavigationItem
{
//    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setTitle:@"" forState:UIControlStateNormal];
//    rightBtn.userInteractionEnabled = NO;
//    [rightBtn setTitleColor:CONTENTCOLOR forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(editor_shopping_click:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn sizeToFit];
//    rightBtn.titleLabel.font = FONT(16.0f);
////    rightBtn.frame = CGRectMake(0, 0, 80, 44);
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        CYCartModel *cartmodel = [_dataArr objectAtIndex:indexPath.section];

        NSMutableArray *specdataIdArr = [NSMutableArray array];
        CYShopTrolleyModel *goods = [cartmodel.goodsList objectAtIndex:indexPath.row];
        [specdataIdArr addObject:goods.specId];
        
        if ([specdataIdArr count]>0) {
            [CYWebClient Post:@"del_shopingcart" parametes:@{@"specId":[specdataIdArr JSONString]} success:^(id responObject) {
                [_clearingBtn setTitle:@"结算" forState:UIControlStateNormal];
                _deleteBg.hidden = YES;
                [_dataArr removeAllObjects];
                [_tableView reloadData];
                [_selectedIndexPathArray removeAllObjects];
                [_selectSectionArray removeAllObjects];
                [self loadViewData];
                _totalLbl.text = @"0.00";
                cartNumLable.text =@"0";
                [self loadCartNum];
            } failure:^(id error) {
                
            }];
        }else{
            [Itost showMsg:@"请选择要删除的商品！" inView:WINDOW];
        }
        
    }
    
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath

{
    return @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    return YES;
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CYCartModel *cartmodel = [_dataArr objectAtIndex:section];
    return [cartmodel.goodsList count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CYCartModel *model =[_dataArr objectAtIndex:section];
    CYShopTrolleyHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYShopTrolleyHeaderView" owner:nil options:nil] firstObject];
    headerView.sellerName = model.sellerName;
    [headerView.selectBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    headerView.selectBtn.tag = section+HEADERCELLTAG;
    
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    footerView.backgroundColor = CLEARCOLOR;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LINECOLOR;
    [footerView addSubview:lineView];
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYCartModel *model = [_dataArr objectAtIndex:indexPath.section];
    CYShoppingTrolleyCell *cell = [CYShoppingTrolleyCell cellWidthTableView:tableView];
    cell.delegate = self;
    cell.shopTrolleyModel = [model.goodsList objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYCartModel *model = [_dataArr objectAtIndex:indexPath.section];
   CYShopTrolleyModel *info = [model.goodsList objectAtIndex:indexPath.row];
    CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = info.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
  
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (NSIndexPath *myindexPath in _selectedIndexPathArray) {
        if (myindexPath.section == indexPath.section) {
            if (myindexPath.row == indexPath.row) {
                CYShoppingTrolleyCell *myCell = (CYShoppingTrolleyCell *)cell;
                myCell.selectButton.selected = YES;
            }
        }
       
    }
}
//
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UIButton *btn = (UIButton *)[view viewWithTag:section+HEADERCELLTAG];
    [btn setSelected:NO];
    for (NSNumber *currentNum in _selectSectionArray) {
        if ([currentNum integerValue] == section) {
            UIButton *selectBtn = (UIButton *)[view viewWithTag:section+HEADERCELLTAG];
            [selectBtn setSelected:YES];
        }
        
    }
}

#pragma mark -
#pragma mark CYShoppingTrolleyCellDelegate method
- (void)changeAllPrice:(CGFloat)price andAllGoodsNum:(NSInteger)goodsnum
{
    allGoodsNum = 0;
    
    CGFloat allprice = 0.0f;
    for (int i =0; i<[_selectedIndexPathArray count]; i++) {
        NSIndexPath *indexPath = [_selectedIndexPathArray objectAtIndex:i];
        CYCartModel *data = [_dataArr objectAtIndex:indexPath.section];
        CYShopTrolleyModel *goods = [data.goodsList objectAtIndex:indexPath.row];
        allGoodsNum+= [goods.goodsNumber integerValue];
        allprice +=([goods.price floatValue] * [goods.goodsNumber integerValue]);
    }
    
    
    
    _totalLbl.text =[NSString stringWithFormat:@"%.2f",allprice];
    NSString *allNum = [NSString stringWithFormat:@"结算(%d)",(int)allGoodsNum];
//    cartNumLable.text = [NSString stringWithFormat:@"%d",(int)allGoodsNum];
    [_clearingBtn setTitle:allNum forState:UIControlStateNormal];
}

-(void)selectgoods:(CYShoppingTrolleyCell *)cell andModel:(CYShopTrolleyModel *)model
{
    
    NSIndexPath *indexPath  = [_tableView indexPathForCell:cell];
    CYCartModel *carmodel = [_dataArr objectAtIndex:indexPath.section];
    CYShopTrolleyModel *goodsModel = [carmodel.goodsList objectAtIndex:indexPath.row];
    __block CGFloat totalPrice = [_totalLbl.text floatValue];
    for (NSIndexPath *myIndexPath in _selectedIndexPathArray) {
        if (indexPath.section == myIndexPath.section) {
            if (myIndexPath.row == indexPath.row) {//取消选中
                NSLog(@"myIndexPath.row = %d  And indexPath.row = %d",(int)myIndexPath.row,(int)indexPath.row);
                //            allGoodsNum --;
                totalPrice -=([goodsModel.price floatValue] * [goodsModel.goodsNumber integerValue]);
                _totalLbl.text =[NSString stringWithFormat:@"%.2f",totalPrice];
                NSString *allNum = [NSString stringWithFormat:@"结算(%d)",(int)allGoodsNum];
                [_clearingBtn setTitle:allNum forState:UIControlStateNormal];
                [cell.selectButton setSelected:NO];
                [_selectedIndexPathArray removeObject:myIndexPath];
                //全部取消，头部取消
                NSInteger cancelSection = indexPath.section;
                NSInteger totalSectionRow = 0;
                for (int i=0; i<_selectedIndexPathArray.count; i++) {
                    NSIndexPath *currentIndex = _selectedIndexPathArray[i];
                    if (currentIndex.section == cancelSection) {
                        totalSectionRow ++;
                    }
                }
                
                if (totalSectionRow == 0) {
                    [_selectSectionArray removeObject:[NSNumber numberWithInteger:cancelSection]];
                    [_tableView reloadData];
                }
                [self changeAllPrice:totalPrice andAllGoodsNum:allGoodsNum];
                _allbtn.selected = NO;
                return;
            }
        }
    }
    [_selectedIndexPathArray addObject:indexPath];
    [cell.selectButton setSelected:YES];
    //选中全部 头部选中
    NSInteger addSection = indexPath.section;
    NSInteger totalSectionRow = 0;
    for (int i=0; i<_selectedIndexPathArray.count; i++) {
        NSIndexPath *currentIndex = _selectedIndexPathArray[i];
        if (currentIndex.section == addSection) {
            totalSectionRow ++;
        }
    }
    
    if (totalSectionRow == [carmodel.goodsList count]) {
        [_selectSectionArray addObject:[NSNumber numberWithInteger:addSection]];
        [_tableView reloadData];
    }
    
    if ([_selectSectionArray count] == [_dataArr count]) {
        _allbtn.selected = YES;
    }
    //    allGoodsNum = [_selectedIndexPathArray count];
    //    totalPrice+=([goodsModel.price floatValue] * [goodsModel.goodsNumber integerValue]);
    [self changeAllPrice:totalPrice andAllGoodsNum:allGoodsNum];
}


#pragma mark - cell headerView click
/**
 *  选择单个大师下的所有商品
 */
- (void)headerBtnClick:(UIButton *)button
{
    CYCartModel *model = [_dataArr objectAtIndex:button.tag - HEADERCELLTAG];
    CGFloat totalPrice = [_totalLbl.text floatValue];
    for (NSNumber *currentNumber  in _selectSectionArray) {//取消选中
        if ([currentNumber integerValue] == (button.tag-HEADERCELLTAG)) {
            [button setSelected:NO];
            [_selectSectionArray removeObject:currentNumber];
            NSMutableArray *removeArr = [[NSMutableArray alloc]init]; //要移除 所有cell下标
            for (NSIndexPath *currentIndexPath  in _selectedIndexPathArray) {
                if (currentIndexPath.section == (button.tag-HEADERCELLTAG)) {
                    [removeArr addObject:currentIndexPath];
                }
            }
            for (int i= 0; i<[removeArr count]; i++) {//总价变化
                NSIndexPath *index = [removeArr objectAtIndex:i];
                CYShopTrolleyModel *goodsModel = [model.goodsList objectAtIndex:index.row];
                totalPrice -=([goodsModel.price floatValue]* [goodsModel.goodsNumber integerValue]);
            }
            
            [_selectedIndexPathArray removeObjectsInArray:removeArr];
            [_tableView reloadData];
            if ([_selectSectionArray count] == [_dataArr count]) {
                _allbtn.selected = YES;
            }else{
                _allbtn.selected = NO;
            }
            
            [self changeAllPrice:totalPrice andAllGoodsNum:allGoodsNum];
            
            return;
        }
    }
    //选中
    [_selectSectionArray addObject:[NSNumber numberWithInteger:button.tag - HEADERCELLTAG]];
    [button setSelected:YES];
    //选中section下面的cell
    for (int i = 0; i<[model.goodsList count]; i++) {
        [_selectedIndexPathArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *myindex = obj;
            if (myindex.section == (button.tag - HEADERCELLTAG)) {
                if (myindex.row == i) {
                    *stop = YES;
                    if (*stop == YES) {
                        [_selectedIndexPathArray removeObjectAtIndex:idx];
                    }
                 
                }
            }
        }];
    }
    
    
   for (int i = 0; i<[model.goodsList count]; i++) {
    [_selectedIndexPathArray addObject:[NSIndexPath indexPathForRow:i inSection:button.tag -HEADERCELLTAG]];
   }
    
    if ([_selectSectionArray count] == [_dataArr count]) {
        _allbtn.selected = YES;
    }
    
    [self changeAllPrice:totalPrice andAllGoodsNum:allGoodsNum];
    [_tableView reloadData];
}
#pragma mark -
#pragma mark CYShoppingTrolleyCellDelegate method
- (void)changeGoodsNum:(CYShoppingTrolleyCell *)cell Model:(CYShopTrolleyModel *)model IsAdd:(BOOL)add
{
   
    NSInteger num = 0;
    NSInteger goodsnum = [cell.goodsNumLbl.text integerValue];
    if (add) {
        if (goodsnum <[model.stock integerValue]-1) {
            goodsnum ++;
            num ++;
        }else{
            num = goodsnum;
            [Itost showMsg:@"库存不足" inView:self.view];
            return;
        }
       
    }else{
        if (goodsnum<2) {
            return;
        }
        goodsnum --;
        num --;
    }
    
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
     CGFloat totalPrice = [_totalLbl.text floatValue];
    for (NSIndexPath *myIndexPath in _selectedIndexPathArray) {
        if (myIndexPath.row == indexPath.row) {
            totalPrice += ([model.price floatValue] * num);
        }
    }
    
    
    [CYWebClient Post:@"setNumber" parametes:@{@"specId":model.specId,@"number":@(goodsnum)} success:^(id responObject) {
           cartNumLable.text = [[responObject objectForKey:@"count"] description];
    } failure:^(id error) {
        
    }];
    
    
    _totalLbl.text = [NSString stringWithFormat:@"%.2f",totalPrice];
    NSString *goodsNum = [NSString stringWithFormat:@"%d",(int)goodsnum];
    model.goodsNumber = goodsNum;
    cell.goodsNumLbl.text = goodsNum;
    [self changeAllPrice:totalPrice andAllGoodsNum:allGoodsNum];
    
}


#pragma mark -
#pragma mark 按钮点击事件 method
/**
 *  选择所有商品
 */
- (IBAction)selectAllGoods_click:(UIButton *)sender {

    [_selectSectionArray removeAllObjects];
    [_selectedIndexPathArray removeAllObjects];
    CGFloat totalPrice = 0.00;
    NSInteger totalNum = 0;
    
    if (!sender.selected) {
        [sender setSelected:YES];
        for (int i=0; i<[_dataArr count]; i++) {
            [_selectSectionArray addObject:[NSNumber numberWithInteger:i]];
            CYCartModel *model = [_dataArr objectAtIndex:i];
            totalNum +=([model.goodsList count]);
            for (int j=0; j<[model.goodsList count]; j++) {
                CYShopTrolleyModel *shopmodel = [model.goodsList objectAtIndex:j];
                totalPrice +=([shopmodel.price floatValue]*[shopmodel.goodsNumber integerValue]);
                [_selectedIndexPathArray addObject:[NSIndexPath indexPathForRow:j inSection:i]];
            }
        }
    }
    else{
        totalPrice = 0.00;
        totalNum = 0;
        [sender setSelected:NO];
        [_selectSectionArray removeAllObjects];
        [_selectedIndexPathArray removeAllObjects];
    }
    allGoodsNum = totalNum;
//    cartNumLable.text = [NSString stringWithFormat:@"%d",(int)allGoodsNum];
    _totalLbl.text =[NSString stringWithFormat:@"%.2f",totalPrice];
    NSString *allNum = [NSString stringWithFormat:@"结算(%d)",(int)totalNum];
    [_clearingBtn setTitle:allNum forState:UIControlStateNormal];
    [self changeAllPrice:totalPrice andAllGoodsNum:0];
    [_tableView reloadData];
}

//去支付
- (IBAction)settleaccounts_click:(id)sender {
    
    NSMutableArray *ooxx = [NSMutableArray array];
    NSMutableArray *selectArr = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    for (int i =0; i<[_selectedIndexPathArray count]; i++) {
        NSIndexPath *indexPath = [_selectedIndexPathArray objectAtIndex:i];
        
        CYCartModel *data = [_dataArr objectAtIndex:indexPath.section];
        CYShopTrolleyModel *goods = [data.goodsList objectAtIndex:indexPath.row];
        
        selectArr = [dic objectForKey:data.sellerName];
        if (selectArr == nil) {
            selectArr = [NSMutableArray array];
        }
        NSString *selleruid = [goods.is_self boolValue]?@"1":goods.seller_uid;
        [selectArr addObject:goods];
        [dic setObject:selectArr forKey:data.sellerName];
        [dic1 setObject:data.sellerAvatar forKey:data.sellerName];
        [dict2 setObject:selleruid forKey:data.sellerName];
        
    }
    
    
//    @"sellerUid":productModel.sellerUid
    
    for (NSString *key in [dic allKeys]) {
        NSInteger commodityCount = 0;
        CGFloat price = 0.00;
        for (CYShopTrolleyModel * model in dic[key]) {
            commodityCount +=[model.goodsNumber integerValue];
            price +=([model.price floatValue]*[model.goodsNumber integerValue]);
        }
        NSDictionary *data = @{@"goodsList":dic[key],
                               @"commodityCount":@(commodityCount),
                               @"seller":@{@"sellerName":key,@"sellerAvatar":dic1[key],@"sellerUid":dict2[key]},
                               @"orderPrice":@(price)};
        CYOrderDetailModel *model = [CYOrderDetailModel objectWithKeyValues:data];
        [ooxx addObject:model];
    }
    
    
    if ([ooxx count] ==0) {
        [Itost showMsg:@"请选择要支付的商品！" inView:self.view];
        return;
    }
    
    CYConfirmOrderViewController *vc = viewControllerInStoryBoard(@"CYConfirmOrderViewController", @"TeaMall");
//    [self.storyboard instantiateViewControllerWithIdentifier:@"CYConfirmOrderViewController"];
    vc.dataArr = ooxx;
    vc.confirmtype = CYConfirmOrderTypeCard;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//删除购物车
- (IBAction)delete_click:(id)sender {
    NSMutableArray *specdataIdArr = [NSMutableArray array];
    for (int i =0; i<[_selectedIndexPathArray count]; i++) {
        NSIndexPath *indexPath = [_selectedIndexPathArray objectAtIndex:i];
        CYCartModel *data = [_dataArr objectAtIndex:indexPath.section];
        CYShopTrolleyModel *goods = [data.goodsList objectAtIndex:indexPath.row];
        [specdataIdArr addObject:goods.specId];
    }
    if ([specdataIdArr count]>0) {
        [CYWebClient Post:@"del_shopingcart" parametes:@{@"specId":[specdataIdArr JSONString]} success:^(id responObject) {
            [_clearingBtn setTitle:@"结算" forState:UIControlStateNormal];
            _deleteBg.hidden = YES;
            [_dataArr removeAllObjects];
            [_tableView reloadData];
            [_selectedIndexPathArray removeAllObjects];
            [_selectSectionArray removeAllObjects];
            [self loadViewData];
            _totalLbl.text = @"0.00";
            cartNumLable.text =@"0";
            [self loadCartNum];
        } failure:^(id error) {
            
        }];
    }else{
        [Itost showMsg:@"请选择要删除的商品！" inView:WINDOW];
    }

}
-(IBAction)editor_shopping_click:(UIButton *)sender
{
    _deleteBg.hidden = !_deleteBg.hidden;
    NSString *rightTiele = _deleteBg.hidden?@"编辑":@"完成";
    [_rightBtn setTitle:rightTiele forState:UIControlStateNormal];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)guangguang_click:(id)sender {
    
   
       [self.navigationController popToRootViewControllerAnimated:NO];
       [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
//         [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
    });
    
   
}

@end
