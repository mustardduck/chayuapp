//
//  CYTeaCategoryInfo.h
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYHotCategotyInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *bid;

@end

@interface CYTeaChildCategoryInfo : NSObject

@property (nonatomic, strong) NSString *sid;

@property (nonatomic,strong)NSString *id;

@property (nonatomic, strong) NSString *name;
@property (nonatomic,strong)  NSString *icoImg;
//市集分类使用
@property (nonatomic ,strong) NSString *thumb;
@property (nonatomic,strong)  NSString *catid;

@property (nonatomic, assign) BOOL is_new;
@end

@interface CYTeaCategoryInfo : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ico;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic ,strong) NSString *thumb;
//市集分类使用
@property (nonatomic, strong) NSString *catid;

@property (nonatomic, strong) NSArray<CYTeaChildCategoryInfo *> *children;

@property (nonatomic,strong) NSArray <CYTeaChildCategoryInfo *>*child;

//是否展开
@property (nonatomic, assign) BOOL hasOpen;
@end

@interface CYPingPaiInfo : NSObject
@property (nonatomic,strong)NSString *icon_img;
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSArray<CYTeaChildCategoryInfo *> *list;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,strong)NSString *letter;

@end

