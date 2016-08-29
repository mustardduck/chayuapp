//
//  CYBuyerOrderDoneDetailVC.m
//  茶语
//
//  Created by Leen on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerOrderDoneDetailVC.h"
#import "UIColor+Additions.h"
#import "CYBuyerEvaCell.h"
#import "CYBuyerOrderDetailProductCell.h"
#import "PYMultiLabel.h"
#import "UILabel+Utilities.h"
#import "CYBuyerEvaView.h"


@interface CYBuyerOrderDoneDetailVC ()<UITableViewDelegate, UITableViewDataSource, CYBuyerEvaViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (nonatomic, strong) CYBuyerEvaView * evaView;


@end

@implementation CYBuyerOrderDoneDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.evaView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
    }
    else if (section == 1)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 2)
        {
            return 44;
        }
        else
        {
            return 90;
        }
    }
    else if (indexPath.section == 1)
    {
        return 50;
    }
    else
    {
        CYBuyerEvaCell * cell = (CYBuyerEvaCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.height;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row != 2)
        {
            CYBuyerOrderDetailProductCell * cell = [CYBuyerOrderDetailProductCell cellWidthTableView:tableView];
            cell.titleLbl.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
            cell.priceLbl.text = @"￥100.00";
            cell.countLbl.text = @"x1";
            cell.typeLbl.text = @"包装：礼品装";
            cell.weightLbl.text = @"重量：100g";
            
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor grayTitleOrLineColor];
            [cell.contentView addSubview:line];
            
            return cell;
            
        }
        else
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderDoneStatusCell"];
            
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderDoneStatusCell"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
            }
            else{
                for (UIView *view in cell.contentView.subviews) {
                    [view removeFromSuperview];
                }
            }
            
            UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 80, 44)];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.font = FONT(14);
            lbl.textColor = [UIColor brownTitleColor];
            lbl.text = @"交易成功";
            [cell.contentView addSubview:lbl];
            
            CGFloat totalMoney = 200.00;
            
            PYMultiLabel * totalLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(lbl.x + lbl.width, 0, SCREEN_WIDTH -  108, 44)];
            totalLbl.backgroundColor = [UIColor clearColor];
            totalLbl.font = FONT(12);
            totalLbl.textColor = [UIColor grayDarkerTitleColor];
            totalLbl.text = [NSString stringWithFormat:@"共2件商品 实付款 ￥%.2f", totalMoney];
            totalLbl.textAlignment = NSTextAlignmentRight;
            
            NSString * totalMoneyStr = [NSString stringWithFormat:@"%.2f", totalMoney];
            
            NSInteger totalMoneylength = [totalMoneyStr rangeOfString:@"."].location + 4;
            
            [totalLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(totalLbl.text.length - totalMoneylength , totalMoneylength)];
            
            [totalLbl setFontColor:[UIColor blackTitleColor] range:NSMakeRange(totalLbl.text.length - totalMoneylength - 4, 3)];
            
            [cell.contentView addSubview:totalLbl];
            
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderDoneCell"];
        
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderDoneCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        else{
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
        }
        
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH - 28, 50)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.font = FONT(14);
        lbl.textColor = [UIColor grayDarkerTitleColor];
        lbl.text = @"确认收货时间：2016-06-15 23：11";
        
        if(indexPath.row == 0)
        {
            lbl.text = @"       订单编号：DD2015062700007";
        }
        
        [cell.contentView addSubview:lbl];
        
        if(indexPath.row != 2)
        {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor grayTitleOrLineColor];
            [cell.contentView addSubview:line];
        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
        NSInteger index = 0;
        
        if(indexPath.row == 0)
        {
            index = 0;
        }
        else if (indexPath.row == 1)
        {
            index = 1;
        }
        
        CYBuyerEvaCell *cell = [CYBuyerEvaCell cellWidthTableView:tableView index:index];
        
        if(index == 0)
        {
            cell.nameLbl1.text = @"李健健";
            cell.starFirstIcon1.image = [UIImage imageNamed:@"fullStar"];
            cell.starSecondIcon1.image = [UIImage imageNamed:@"fullStar"];
            cell.starThirdIcon1.image = [UIImage imageNamed:@"fullStar"];
            cell.starFourthIcon1.image = [UIImage imageNamed:@"halfStar"];
            cell.starFifthIcon1.image = [UIImage imageNamed:@"emptyStar"];
            cell.customerEvaLbl1.text = @"不错的一款红茶，非常好喝，推荐购买";
            
            [cell.sellerEvaBtn1 addTarget:self action:@selector(sellerEvaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            cell.height = 117 + cell.customerEvaLbl1.boundingRectWithHeight - 16;
            
        }
        else if (index == 1)
        {
            cell.nameLbl2.text = @"小鱼摆摆";
            cell.starFirstIcon2.image = [UIImage imageNamed:@"fullStar"];
            cell.starSecondIcon2.image = [UIImage imageNamed:@"fullStar"];
            cell.starThirdIcon2.image = [UIImage imageNamed:@"fullStar"];
            cell.starFourthIcon2.image = [UIImage imageNamed:@"halfStar"];
            cell.starFifthIcon2.image = [UIImage imageNamed:@"emptyStar"];
            cell.customerEvaLbl2.text = @"还没泡来喝，不过想来不错，因为送的老水仙也挺好的。包装很仔细。";
            [cell.sellerEvaBtn2 addTarget:self action:@selector(sellerEvaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.customerEvaAgainLbl2.text = @"买家追评：真心的不错，以后还会再来买";
            
            [cell.sellerEvaAgainBtn2 addTarget:self action:@selector(sellerEvaBtnAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.height = 191 + cell.customerEvaLbl2.boundingRectWithHeight + cell.customerEvaAgainLbl2.boundingRectWithHeight - 16 * 2;
            
        }
        
        if(indexPath.row != 1)
        {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor grayTitleOrLineColor];
            [cell.contentView addSubview:line];
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 45;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 100, 45)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.font = FONT(16);
        lbl.textColor = [UIColor blackTitleColor];
        lbl.text = @"买家评价";
        [view addSubview:lbl];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor grayTitleOrLineColor];
        [view addSubview:line];
        
        return view;
    }
    else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor grayBackgroundColor];
    
    return view;
}

- (void)sellerEvaBtnClicked:(id)sender
{
    CYBuyerEvaCell * cell = (CYBuyerEvaCell *)[[sender superview] superview];
    
    NSIndexPath * indP = [_mainTable indexPathForCell:cell];
    
    NSLog(@"indexpath.section=%ld", indP.section);
    
    _evaView.textView.text = nil;
    
    _evaView.hidden = NO;
}

- (void)sellerEvaBtnAgainClicked:(id)sender
{
    CYBuyerEvaCell * cell = (CYBuyerEvaCell *)[[sender superview] superview];
    
    NSIndexPath * indP = [_mainTable indexPathForCell:cell];
    
    NSLog(@"indexpath.section=%ld", indP.section);
    
    _evaView.textView.text = nil;
    
    _evaView.hidden = NO;
}

- (void)evaViewCommentClicked
{
    _evaView.hidden = YES;
    
    //    [_mainTable reloadData];
}

- (void) evaViewCancelClicked
{
    _evaView.hidden = YES;
    
}

- (CYBuyerEvaView *)evaView
{
    if (!_evaView) {
        _evaView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerEvaView" owner:nil options:nil] firstObject];
        _evaView.frame = WINDOW.bounds;
        _evaView.delegate = self;
        _evaView.hidden = YES;
    }
    return _evaView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 45;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
