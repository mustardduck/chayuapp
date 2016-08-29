//
//  CYFiterItemView.h
//  茶语
//
//  Created by Chayu on 16/3/17.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYFiterItemViewDelegate;

@interface CYFiterItemView : UIView

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)NSDictionary *info;

@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;

@property (weak, nonatomic) IBOutlet UILabel *typeLbl;

@property (assign,nonatomic)NSInteger indexPath;

@property (nonatomic,assign)id<CYFiterItemViewDelegate>delegate;

@property (nonatomic,assign)BOOL isLast;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+(CGFloat)classicViewHeight:(NSArray *)secArr andislast:(BOOL)islast;

@property (weak, nonatomic) IBOutlet UIImageView *filterImg;


@property (nonatomic,copy)NSString *catId;

@end

@protocol CYFiterItemViewDelegate <NSObject>

-(void)openOrCloseItemView:(NSInteger)index andView:(CYFiterItemView *)view;

-(void)changesearchNum:(NSDictionary *)info andIndex:(NSInteger)index;


@end