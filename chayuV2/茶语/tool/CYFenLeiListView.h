//
//  CYFenLeiListView.h
//  茶语
//
//  Created by Chayu on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYFenLeiListView : UIView

@property (nonatomic,strong)NSArray *dataArr;


@property (nonatomic,copy)void (^selectCateBlock)(NSString *nameid,NSString *name);


@property (nonatomic,copy)void (^quanziCateBlock)(NSDictionary *);


@property (nonatomic,copy)void (^shijiCateBlock)(NSDictionary *);

//是否是标题
@property (nonatomic,assign)BOOL isTitle;

@end
