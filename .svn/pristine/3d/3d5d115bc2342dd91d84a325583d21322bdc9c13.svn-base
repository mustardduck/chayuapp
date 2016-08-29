//
//  CYClassView.h
//  茶语
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYClassViewDelegate;

@interface CYClassView : UIView

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)NSDictionary *info;

@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;

@property (nonatomic,assign)id<CYClassViewDelegate>delegate;

@property (nonatomic,assign)BOOL isLast;

+(CGFloat)classicViewHeight:(NSArray *)secArr andisLast:(BOOL)islast;




@end

@protocol CYClassViewDelegate <NSObject>

-(void)selectClassType:(NSDictionary *)info andIsLast:(BOOL)islast;
@end