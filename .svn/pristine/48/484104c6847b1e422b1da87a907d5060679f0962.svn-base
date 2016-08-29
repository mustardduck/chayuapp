//
//  CYHomeCell.h
//  TeaMall
//
//  Created by Chayu on 15/10/20.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHomeCellModel.h"

typedef NS_ENUM(NSInteger,CYTeaMallCellType){
    CYTeaMallCellTypeArticle = 1, //文章
    CYTeaMallCellTypeComment,   //带评论商品
    CYTeaMallCellTypeCharacter, //默认
    CYTeaMallCellTypePolymerization, //聚合
    CYTeaMallCellTypeCommodity, //商品（默认样式）
    CYTeaMallCellTypeOther = 100 //其他
};

#define CellH (220.5/(320/SCREEN_WIDTH))
@protocol CYHomeCellDelegate;
@interface CYHomeCell : UITableViewCell

@property (nonatomic,strong)CYMasterListModel *model;

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)id<CYHomeCellDelegate>delegate;

//是否是大师
@property (nonatomic,assign)BOOL isMaster;
//在大师的基础上 判断是否只是人物合集 如果是则只显示简介 不显示商品
@property (nonatomic,assign)BOOL onlyCharacter;

@end


@protocol CYHomeCellDelegate <NSObject>

@optional
/**
 *  大师介绍
 */
-(void)cell:(CYHomeCell *)cell masterModel:(CYMasterListModel *)model;

/**
 *  名家介绍
 */
-(void)cell:(CYHomeCell *)cell FamousModel:(CYMasterListModel *)model;

/**
 *  名家旗下茶产品
 */
-(void)cell:(CYHomeCell *)cell FamousModel:(CYMasterListModel *)model andindex:(NSInteger)teaIndex;

/**
 *  大师好茶详情
 */
-(void)cell:(CYHomeCell *)cell MasterGoodTeaModel:(CYMasterListModel *)model;

-(void)cell:(CYHomeCell *)cell ActivityModel:(CYMasterListModel *)model;

- (void)selectGoods:(NSString *)goodsId;

@end
