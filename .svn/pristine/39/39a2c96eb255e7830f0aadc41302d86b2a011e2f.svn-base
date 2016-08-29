//
//  CYChaLeiView.h
//  茶语
//
//  Created by Chayu on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTeaCategoryInfo.h"
@protocol CYChaLeiViewDelegate;

@interface CYChaLeiView : UIView


@property(nonatomic,strong)NSArray *chaliData;

@property (nonatomic,assign)id<CYChaLeiViewDelegate>delegate;

@end

@protocol CYChaLeiViewDelegate <NSObject>


-(void)selectItem:(CYTeaChildCategoryInfo *)info andTeaCategoryInfo:(CYTeaCategoryInfo *)cateInfo;

@end