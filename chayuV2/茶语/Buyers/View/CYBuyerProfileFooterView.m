//
//  CYBuyerProfileFooterView.m
//  茶语
//
//  Created by Leen on 16/8/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerProfileFooterView.h"

@implementation CYBuyerProfileFooterView

- (IBAction)addContentClicked:(id)sender {
    if(self.addContentBlock)
    {
        self.addContentBlock();
    }
}

- (IBAction)addImageClicked:(id)sender {
    if(self.addImageBlock)
    {
        self.addImageBlock();
    }
}
- (IBAction)saveBtnClicked:(id)sender {
    if(self.saveBlock)
    {
        self.saveBlock();
    }
}

@end
