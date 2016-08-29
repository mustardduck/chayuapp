//
//  CYModifyNickViewController.h
//  TeaMall
//
//  Created by Chayu on 15/12/11.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef void (^BlockNickName)(NSString *);

@interface CYModifyNickViewController : CYBaseViewController

/**
 *
 */
@property (nonatomic,strong)BlockNickName name;

@property (nonatomic ,copy)NSString *nameStr;

@end
