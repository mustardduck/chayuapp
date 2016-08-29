//
//  CYToolBar.h
//  茶语
//
//  Created by Leen on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ToolBarSelBlock)(NSInteger index);
@interface CYToolBar : UIView
{
    UIButton *lastSelectedBtn;
    
    ToolBarSelBlock selBlock;
}


- (void)setItems:(NSArray*)array block:(ToolBarSelBlock)block;

@end
