//
//  CYTeaCategoryViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYTeaCategoryInfo.h"

@protocol CYTeaCategoryViewDelegate <NSObject>

- (void)teaCategorySelectData:(id)data;

@end

@interface CYTeaCategoryViewController : CYBaseViewController

@property (nonatomic, strong) NSString *mCateID;

@property (nonatomic, weak) id<CYTeaCategoryViewDelegate> delegate;

@end
