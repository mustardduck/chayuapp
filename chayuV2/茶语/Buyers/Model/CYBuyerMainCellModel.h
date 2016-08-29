//
//  CYBuyerMainCellModel.h
//  茶语
//
//  Created by Leen on 16/7/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYBuyerMainCellModel : NSObject

@property (nonatomic, assign) NSInteger type;//1商品 2人物 3纯图片
@property (nonatomic, strong) NSString * title;//
@property (nonatomic, strong) NSString * data;//根据type返回对应值 （type为3需要特别处理）
@property (nonatomic, strong) NSString * enjoy_count;//
@property (nonatomic, strong) NSString * price_sell;//
@property (nonatomic, strong) NSString * content;//
@property (nonatomic, strong) NSString * comment_count;//
@property (nonatomic, strong) NSString * sellername;//
@property (nonatomic, strong) NSString * selleravatar;//
@property (nonatomic, strong) NSString * thumb;//
@property (nonatomic, assign) BOOL  isAttend;//
@property (nonatomic, strong) NSArray * catarr;//
@property (nonatomic, strong) NSString * thumbType;//纯图片类型 type=3专用（1文章，2商品，3卖家，4聚合人物，5茶评，6茶样，100纯url，101聚合商品）
@property (nonatomic, strong) NSString * selleruid;//


@end

