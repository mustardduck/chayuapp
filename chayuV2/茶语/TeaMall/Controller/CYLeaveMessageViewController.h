//
//  CYLeaveMessageViewController.h
//  TeaMall
//
//  Created by Chayu on 15/11/25.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef void (^LeaveMessageBack)(NSString *);

@interface CYLeaveMessageViewController : CYBaseViewController

@property (nonatomic,strong)LeaveMessageBack block;

@property  (nonatomic,strong)NSString *levemessage;

@end
