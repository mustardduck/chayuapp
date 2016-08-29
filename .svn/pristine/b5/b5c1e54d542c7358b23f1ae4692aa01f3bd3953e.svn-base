//
//  CYWriteCommentViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef NS_ENUM(NSInteger,TeaCommentType) {
    TeaCommentType_tea = 0,
    TeaCommentType_sample
};

@interface CYWriteCommentViewController : CYBaseViewController

@property (nonatomic, copy) NSString *mItemid;
@property (nonatomic, assign) TeaCommentType mType;
@property (nonatomic, copy) NSString *bid;
@property (weak, nonatomic) IBOutlet UILabel *mTipLabel;

@property (copy,nonatomic)void (^backBlock)();


@end
