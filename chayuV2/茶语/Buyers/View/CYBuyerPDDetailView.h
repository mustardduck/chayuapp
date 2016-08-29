//
//  CYBuyerPDDetailView.h
//  茶语
//
//  Created by Leen on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShareModel.h"
#import "CYProductDetailsModel.h"
#import "CYBuyerAllEvaluationView.h"
#import "BaseLable.h"

@protocol CYBuyerPDDetailViewDelegate;

@interface CYBuyerPDDetailView : UIView

@property (nonatomic, assign)id<CYBuyerPDDetailViewDelegate> delegate;
@property (nonatomic,strong) CYProductDetailsModel *productModel;
@property (nonatomic,strong)NSString *shareurl;
@property (nonatomic,strong)CYBuyerAllEvaluationView *allEvaView;

@property (weak, nonatomic) IBOutlet BaseLable *cartNum;

@property (nonatomic, copy) void(^seeFullBlock)(NSInteger,NSArray *);

-(void)loadCartNum;

@end

@protocol CYBuyerPDDetailViewDelegate <NSObject>

- (void)CYBuyerPD_gouwuche_click;
- (void)CYBuyerPD_selectgoodsInfo:(NSMutableArray * )detailArr confirmType:(NSInteger )confType;
- (void)CYBuyerPD_mingxingjieshao_click:(NSString *)uid;
- (void)CYBuyerPD_allevaShow_click:(BOOL) show;

@end