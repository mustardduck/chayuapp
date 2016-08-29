//
//  CYBuyerEvaluationView.h
//  茶语
//
//  Created by Leen on 16/7/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerEvaluationViewDelegate;

@interface CYBuyerEvaluationView : UIView

@property (nonatomic,assign)CGFloat endHeight;

@property (nonatomic,strong)NSString * pageSize;

@property (nonatomic,strong)NSString *goodId;

@property (nonatomic,assign)id<CYBuyerEvaluationViewDelegate>delegate;

@end

@protocol CYBuyerEvaluationViewDelegate <NSObject>

- (void)evaluationViewendHeight:(CGFloat)endheight;

- (void)showAllEvaluation;

@end
