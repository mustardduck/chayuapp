//
//  CYBuyerAlbumVC.h
//  茶语
//
//  Created by Leen on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef NS_ENUM(NSInteger,CYBuyerAlbumType)
{
    CYBuyerAlbumTypeCommodity = 1<<1, //商品
    CYBuyerAlbumTypeCharacter = 1<<2 //人物
};

@interface CYBuyerAlbumVC : CYBaseViewController

@property(nonatomic,strong)NSString *albumId;
@property(nonatomic,strong)NSString *albumTitle;

@property (nonatomic,assign)CYBuyerAlbumType type;

@end
