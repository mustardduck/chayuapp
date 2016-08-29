//
//  CYHuaTiDetContentCell.h
//  茶语
//
//  Created by Chayu on 16/7/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBWebView.h"
@interface CYHuaTiDetContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BBWebView *webView;

@property (nonatomic,strong)NSString *contentStr;

@property (nonatomic,copy)void(^reloadBlock)(CGFloat);

@end
