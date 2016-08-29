//
//  CYMyGroupViewController.h
//  茶语
//
//  Created by Leen on 16/2/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef NS_ENUM(NSInteger,WoDeQuanZiType){
    WoDeQuanZiTypeDongTai = 0,
    WoDeQuanZiTypeHuaTi,
    WoDeQuanZiTypeQuanZi
};

@interface CYMyGroupViewController : CYBaseViewController

@property (nonatomic,assign)WoDeQuanZiType quanzitype;

@end
