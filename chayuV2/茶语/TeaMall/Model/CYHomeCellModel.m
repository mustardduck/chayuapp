//
//  CYHomeCellModel.m
//  TeaMall
//
//  Created by Chayu on 15/10/20.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYHomeCellModel.h"


@implementation CYHomeCellModel

+(instancetype)initWithData:(id)object
{
    CYHomeCellModel *model = [[CYHomeCellModel alloc] init];
    model.masterArr = [CYMasterListModel objectArrayWithKeyValuesArray:[object objectForKey:@"masterArr"]];
    model.famousArr = [CYMasterListModel objectArrayWithKeyValuesArray:[object objectForKey:@"famousArr"]];
    model.slideArr =  [CYSlideListModel objectArrayWithKeyValuesArray:[object objectForKey:@"slideArr"]];
    model.famousProArr = [CYGoodsListModel objectArrayWithKeyValuesArray:[object objectForKey:@"famousProArr"]];
    return model;
}

@end
