//
//  CYFilterView.h
//  TeaMall
//
//  Created by Chayu on 15/10/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYFilterViewDelegate <NSObject>
@optional
-(void)selectWithData:(NSDictionary *)info;

-(void)hidden;
@end

@interface CYFilterView : UIView

@property (nonatomic,assign)id<CYFilterViewDelegate>delegate;

@property (nonatomic,copy)NSString *catId;



@end
