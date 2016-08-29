//
//  CYHomeCellModel.h
//  TeaMall
//
//  Created by Chayu on 15/10/20.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYMasterListModel.h"
#import "CYGoodsListModel.h"
#import "CYSlideListModel.h"
@interface CYHomeCellModel : NSObject

@property (nonatomic,strong)NSArray *famousArr;

@property (nonatomic,strong)NSArray *famousProArr;

@property (nonatomic,strong)NSArray *masterArr;

@property (nonatomic,strong)NSArray *slideArr;

+(instancetype)initWithData:(id)object;
@end
