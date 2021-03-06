//
//  BlueBoxer.h
//  JiangbeiEPA
//
//  Created by iXcoder on 13-9-6.
//  Copyright (c) 2013年 bulebox. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 
#pragma mark BlueBoxer define
//||--------------------------------------------||
//||                                            ||
//||                 用户信息                    ||
//||                                            ||
//||--------------------------------------------||
@interface ChaYuer : NSObject <NSCoding>


/**
 *
 */
@property (nonatomic,assign,getter=isLoged)BOOL loged;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *nickname;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *regtime;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *mobile;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *uid;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *avatar;

/**
 *
 */
@property (nonatomic,strong)NSString *email;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *sex;

/**
 *  <#属性说明#>
 */
@property (nonatomic,copy)NSString *intro;

//搜索内容
@property (nonatomic,strong)NSMutableArray *searchArr;


// 更新用户信息
- (void)updateUserInfo:(NSDictionary *)infoDic;

// 茶币
@property (nonatomic,strong)NSString *score;

// 经验值
@property (nonatomic,strong)NSString *experience;

//是否评价过
@property (nonatomic,assign)BOOL isEva;

@property (nonatomic,strong)NSString *firstTime;

//后台需要比对判断是否登录过期
@property (nonatomic,strong)NSString *loginToken;


@property (nonatomic,strong)NSString *loginssectionid;


@property (nonatomic,strong)NSDictionary *guanggaoInfo;

//推荐有礼在登录情况加 保存数据
@property (nonatomic,strong)NSDictionary *tuijianInfo;

@property (nonatomic,assign)BOOL isShowYinDao;

@end

#pragma mark -
#pragma mark BlueBoxerManager define
//||--------------------------------------------||
//||                                            ||
//||                 用户管理                    ||
//||                                            ||
//||--------------------------------------------||
@interface ChaYuManager : NSObject

// 储存当前用户信息
+ (void)archiveCurrentUser:(ChaYuer *)currentUser;
// 获取当前用户信息
+ (ChaYuer *)getCurrentUser;

@end