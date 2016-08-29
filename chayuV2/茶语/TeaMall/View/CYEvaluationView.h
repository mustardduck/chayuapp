//
//  CYEvaluationView.h
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYEvaluationViewDelegate;

@interface CYEvaluationView : UIView


@property (nonatomic,assign)CGFloat endHeight;

@property (nonatomic,strong)NSString * pageSize;

@property (nonatomic,strong)NSString *goodId;

@property (nonatomic,assign)id<CYEvaluationViewDelegate>delegate;

@end

@protocol CYEvaluationViewDelegate <NSObject>

- (void)evaluationViewendHeight:(CGFloat)endheight;

- (void)showAllEvaluation;

@end