//
//  CYEvaListViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseListViewController.h"

typedef NS_ENUM(NSInteger, EvaType){
    EvaType_TeaReview = 0,
    EvaType_TeaSamples = 1
};

@interface CYEvaListViewController : CYBaseViewController

//@property (nonatomic, assign) EvaType mType;

//@property (nonatomic, strong) UIViewController *mRootVC;

@property (nonatomic, strong) UIButton *mTeaCateBtn;

@property (nonatomic,strong) NSString *teaCateStr;

//是否是品牌
@property (nonatomic,assign)BOOL isPingPai;


@property (nonatomic,strong)NSString *brandid;

@property (nonatomic, assign) NSString *sid;
@property (nonatomic, assign) NSString *bid;
//茶评相关参数
@property (nonatomic,strong)NSString *order_created;;
@property (nonatomic,strong)NSString *order_score;
@property (nonatomic,strong)NSString *order_price;

////茶样相关参数
//@property (nonatomic,strong)NSString *order_numbe;
//@property (nonatomic,strong)NSString *order_user;
//@property (nonatomic,strong)NSString *order_price1;

//- (void)reloadData;

@end

@interface ToolsView : UIView

@end

@interface CategoryButton : UIButton

@end