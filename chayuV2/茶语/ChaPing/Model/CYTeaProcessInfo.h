//
//  CYTeaProcessInfo.h
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTeaProcessDetailInfo : NSObject

@property (nonatomic, strong) NSString *imgid;
@property (nonatomic, strong) NSString *teaid;
/**
 *  类型：1为包装，2为干茶，3为准备冲泡，4为冲泡，5为叶底
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *listorder;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *brewtime;
@property (nonatomic, strong) NSString *brewtemp;
@property (nonatomic, strong) NSString *mDescription;
@property (nonatomic, strong) NSString *paorder;
@end

@interface CYTeaProcessPaoInfo : NSObject

@property (nonatomic, strong) NSString *sample;
@property (nonatomic, strong) NSString *utensil;
@property (nonatomic, strong) NSString *water;
//@property (nonatomic,strong) NSString *utensil;
@property (nonatomic, strong) NSString *thumb;

@end

@interface CYTeaProcessInfo : NSObject

@property (nonatomic, strong) CYTeaProcessDetailInfo *drytea;
@property (nonatomic, strong) NSArray<CYTeaProcessDetailInfo *> *cook;

@property (nonatomic, strong)  CYTeaProcessPaoInfo *ready_pao;
@property (nonatomic, strong) CYTeaProcessDetailInfo *leaves;

@property (nonatomic, assign) NSInteger count;

@end


