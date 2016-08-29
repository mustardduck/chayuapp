//
//  CYBuyerMyVC.m
//  茶语
//
//  Created by Leen on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMyVC.h"
#import "PYMultiLabel.h"
#import "UILabel+Utilities.h"
#import "CYBuyerMyCell.h"
#import "CYBuyerPDManageVC.h"
#import "CYBuyerShipFeeVC.h"
#import "CYBuyerInvoiceVC.h"
#import "CYBuyerRightsApplyVC.h"
#import "CYBuyerAccountMoneyVC.h"
#import "CYBuyerEvaluateVC.h"
#import "CYBuyerOrderDoneDetailVC.h"
#import "CYBuyerEditVC.h"
#import "CYBuyerReturnMainVC.h"


@interface CYBuyerMyVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray * _dataArr;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLblWidthCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vipIconLeftCons;

@property (weak, nonatomic) IBOutlet PYMultiLabel *chaBiCountLbl;

@property (weak, nonatomic) IBOutlet UIButton *backToMyVCBtn;

@property (weak, nonatomic) IBOutlet UIButton *todayOrderTotalBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountBalanceBtn;

@property (weak, nonatomic) IBOutlet UIButton *allOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitingPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *waitingPayCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *waitingPayCountLblWidthCons;

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *waitingShipCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *waitingShipCountLblWidthCons;

@property (weak, nonatomic) IBOutlet UILabel *onTheWayCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onTheWayCountWidthCons;

@property (weak, nonatomic) IBOutlet UILabel *orderFinishCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderFinishCountWidthCons;

@property (weak, nonatomic) IBOutlet UILabel *returnMoneyCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnMoneyCountWidthCons;
@property (weak, nonatomic) IBOutlet UIButton *waitingShipBtn;
@property (weak, nonatomic) IBOutlet UIButton *onTheWayBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderFinishBtn;
@property (weak, nonatomic) IBOutlet UIButton *returnMoneyBtn;

@end

@implementation CYBuyerMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setHeaderViewData];
    
    _dataArr = @[
                 @[@{@"img":@"buyerMyPDIcon",@"title":@"商品管理"},
                       @{@"img":@"buyerMyReviewIcon",@"title":@"评价管理"}
                       ],
                 @[@{@"img":@"buyerMyShipFeeIcon",@"title":@"运费管理"},
                    @{@"img":@"buyerMyMoneyIcon",@"title":@"账户管理"},
                    @{@"img":@"buyerMyInvoiceIcon",@"title":@"发票设置"}],
                 @[@{@"img":@"buyerMyProfileIcon",@"title":@"个人资料"}],
                 @[@{@"img":@"buyerMyOrderIcon",@"title":@"订单维权"}]
                 ];

}

- (void) setLabelCountCornerRadius:(UILabel *)lbl constant:(NSLayoutConstraint *)cons
{
    cons.constant = lbl.boundingRectWithWidth + 10;
    
    CGFloat cornerRadius = cons.constant / 2;
    
    lbl.layer.masksToBounds = cornerRadius>0;
    lbl.layer.cornerRadius = cornerRadius;
    
    [lbl setNeedsDisplay];
}

- (void) setHeaderViewData
{
    _waitingPayCountLbl.text = @"99";

    [self setLabelCountCornerRadius:_waitingPayCountLbl constant:_waitingPayCountLblWidthCons];
    [self setLabelCountCornerRadius:_waitingShipCountLbl constant:_waitingShipCountLblWidthCons];
    [self setLabelCountCornerRadius:_onTheWayCountLbl constant:_onTheWayCountWidthCons];
    [self setLabelCountCornerRadius:_orderFinishCountLbl constant:_orderFinishCountWidthCons];
    [self setLabelCountCornerRadius:_returnMoneyCountLbl constant:_returnMoneyCountWidthCons];
}


- (IBAction)touchUpInsideOn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    if(btn == _allOrderBtn)//全部订单
    {
        CYBuyerOrderDoneDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerOrderDoneDetailVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn == _backToMyVCBtn)//回到个人首页
    {
        CYBuyerEditVC * vc = viewControllerInStoryBoard(@"CYBuyerEditVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn == _returnMoneyBtn)//退款/退货
    {
        CYBuyerReturnMainVC * vc = viewControllerInStoryBoard(@"CYBuyerReturnMainVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
   
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionIdentify = @"CYBuyerMyCell";
    CYBuyerMyCell  *cell = [tableView dequeueReusableCellWithIdentifier:collectionIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerMyCell" owner:self options:nil] firstObject];
    }
    
    NSDictionary * dic = _dataArr[indexPath.section][indexPath.row];
    
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [dic objectForKey:@"img"]]];
    cell.titleLbl.text = [dic objectForKey:@"title"];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = RGB(170, 170, 170);
    
    if((indexPath.section == 0 && indexPath.row == 0)
       || (indexPath.section == 1 && indexPath.row != 2))
    {
        [cell.contentView addSubview:line];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = RGB(249, 249, 249);
    
    return view;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)//商品管理
    {
        CYBuyerPDManageVC * vc = viewControllerInStoryBoard(@"CYBuyerPDManageVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.section == 0 && indexPath.row == 1)//评价管理
    {
        CYBuyerEvaluateVC * vc = viewControllerInStoryBoard(@"CYBuyerEvaluateVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)//运费管理
    {
        CYBuyerShipFeeVC * vc = viewControllerInStoryBoard(@"CYBuyerShipFeeVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)//账户管理
    {
        CYBuyerAccountMoneyVC * vc = viewControllerInStoryBoard(@"CYBuyerAccountMoneyVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 2)//发票设置
    {
        CYBuyerInvoiceVC * vc = viewControllerInStoryBoard(@"CYBuyerInvoiceVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 0)//个人资料
    {
        
    }
    else if (indexPath.section == 3 && indexPath.row == 0)//订单维权
    {
        CYBuyerRightsApplyVC * vc = viewControllerInStoryBoard(@"CYBuyerRightsApplyVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
