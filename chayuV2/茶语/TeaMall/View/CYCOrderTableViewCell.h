//
//  CYCOrderTableViewCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYOrderDetailModel.h"
#define BASECELLHEIGHT  248.0

@protocol CYCOrderTableViewCellDelegate;


@interface CYCOrderTableViewCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)CYOrderDetailModel *corderModel;


@property (nonatomic,strong)id<CYCOrderTableViewCellDelegate>delegate;


@property (nonatomic,strong)NSDictionary *couponinfo;

@property (nonatomic,strong)NSString *shipPrice;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foot_height_cons;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;


/**
 *  填写发票信息是时赋值
 */
@property (nonatomic,strong)NSString *invoiceStr;

/**
 *  留言
 */
@property (nonatomic,strong)NSString *messageStr;
@property (weak, nonatomic) IBOutlet UITextField *invoiceTxtField;
@property (weak, nonatomic) IBOutlet UIView *invoiceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTopCons;
@property (weak, nonatomic) IBOutlet UIButton *invoiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *invoiceLbl;

@end

@protocol CYCOrderTableViewCellDelegate <NSObject>

-(void)selectinvoiceCell:(CYCOrderTableViewCell *)cell andModel:(CYOrderDetailModel *)model;
-(void)fillinthemessage:(CYCOrderTableViewCell *)cell WithModel:(CYOrderDetailModel *)model;
-(void)selectOrderCell:(CYCOrderTableViewCell *)cell andModel:(CYOrderDetailModel *)modell;

-(void)goodsdetails:(CYShopTrolleyModel *)model;

-(void)invoiceBtn_click:(CYCOrderTableViewCell *)cell WithModel:(CYOrderDetailModel *)model;


@end