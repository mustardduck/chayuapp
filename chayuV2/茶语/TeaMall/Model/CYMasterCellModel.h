//
//  CYMasterCellModel.h
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYMasterCellModel : NSObject


@property (nonatomic,copy)NSString *avatar;

/**
 *  大师姓名
 */
@property (nonatomic,copy)NSString *realname;


/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *first_letter;

/**
 *  大师介绍
 */
@property (nonatomic,copy)NSString *desc;

/**
 *  大师ID
 */
@property (nonatomic,copy)NSString  *sellerUid;

@property (nonatomic,copy)NSString *isAttend;


@end
