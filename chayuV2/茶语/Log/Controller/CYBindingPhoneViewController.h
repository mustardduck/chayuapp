//
//  CYBindingPhoneViewController.h
//  TeaMall
//
//  Created by Chayu on 15/12/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

@interface CYBindingPhoneViewController : CYBaseViewController

@property (nonatomic,strong)NSString *calnum;

@property (nonatomic,copy)void (^backBlock)(NSString *);

@end
