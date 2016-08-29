//
//  CYBuyerCategoryItemView.h
//  茶语
//
//  Created by Leen on 16/5/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerCategoryItemViewDelegate;

@interface CYBuyerCategoryItemView : UIView

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)NSDictionary *info;

@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;

@property (weak, nonatomic) IBOutlet UILabel *typeLbl;

@property (assign,nonatomic)NSInteger indexPath;

@property (nonatomic,assign)id<CYBuyerCategoryItemViewDelegate>delegate;

@property (nonatomic,assign)BOOL isLast;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+(CGFloat)classicViewHeight:(NSArray *)secArr andislast:(BOOL)islast isAddLastBtn:(BOOL)isAddLastBtn;

@property (weak, nonatomic) IBOutlet UIImageView *filterImg;


@property (nonatomic,copy)NSString *catId;

@property (nonatomic,assign)BOOL isAddLastBtn;//最后一个为增加按钮


@end

@protocol CYBuyerCategoryItemViewDelegate <NSObject>

@optional

-(void)openOrCloseItemView:(NSInteger)index andView:(CYBuyerCategoryItemView *)view;

- (void) addAreaBtnClicked;

@end
