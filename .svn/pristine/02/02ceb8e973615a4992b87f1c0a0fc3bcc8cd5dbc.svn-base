//
//  CYDropListMenuView.h
//  茶语
//
//  Created by 李峥 on 16/3/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTeaCategoryInfo.h"

typedef NS_ENUM(NSInteger, DropType) {
    DropType_TeaCategory = 0,
    DropType_TeaYear = 1,
    DropType_Rating = 2,
};

@protocol CYDropListDelegate <NSObject>

- (void)dropListDidSelectData:(id)data forType:(DropType)type addit:(NSString *)str superId:(NSString *)sid;

@end

@interface CYDropListMenuView : UIView


@property (nonatomic, strong) NSMutableArray *mCateList;
@property (nonatomic, strong) NSMutableArray *mYearsList;
@property (nonatomic, strong) NSMutableArray *mRatingList;

- (id)initWithFrame:(CGRect)frame listType:(DropType)type;

@property (nonatomic, weak) id<CYDropListDelegate> delegate;

- (void)show;
- (void)hide;

@end
