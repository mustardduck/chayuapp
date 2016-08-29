//
//  CYSouSuoFenLeiListController.h
//  茶语
//
//  Created by Chayu on 16/7/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef NS_ENUM(NSInteger,SearchType){
    SearchTypeChaPing = 0,
    SearchTypeShiJi,
    SearchTypeQuanZi,
    SearchTypeWenZhang
    
};



@interface CYSouSuoFenLeiListController : CYBaseViewController

@property (nonatomic,assign)SearchType searchType;

//是否从搜索更多进入
@property (nonatomic,assign)BOOL moreInfo;

@property (nonatomic,strong)NSString *keyWord;

@end
