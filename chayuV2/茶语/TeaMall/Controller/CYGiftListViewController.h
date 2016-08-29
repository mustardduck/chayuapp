//
//  CYGiftListViewController.h
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef void (^slectGiftBack)(NSArray *);

@interface CYGiftListViewController : CYBaseViewController

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)slectGiftBack back;

@property (nonatomic,strong)NSString *orderSign;

@end
