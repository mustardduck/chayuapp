//
//  CYMasterCell.m
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMasterCell.h"
#import "BaseButton.h"

@interface CYMasterCell ()


@property (weak, nonatomic) IBOutlet UIImageView *showImg;

- (IBAction)addtention_click:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet BaseButton *attendBtn;
@property (weak, nonatomic) IBOutlet BaseButton *publicBtn;

@end

@implementation CYMasterCell


+(instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *masterIdentify = @"CYMasterCell";
    CYMasterCell *cell = [tableView dequeueReusableCellWithIdentifier:masterIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYMasterCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)drawRect:(CGRect)rect
{

}

-(void)setMasterModel:(CYMasterCellModel *)masterModel
{
    _masterModel = masterModel;
    if (_masterModel.avatar && _masterModel.avatar.length >0) {
        NSURL *url = [NSURL URLWithString:_masterModel.avatar];
        [_showImg sd_setImageWithURL:url placeholderImage:WIDEIMG];
    }
    if ([_masterModel.isAttend isEqualToString:@"1"]) {
        [_attendBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
         [_attendBtn setTitle:@"+关注" forState:UIControlStateNormal];
    }
    _contentLbl.text = _masterModel.desc;
}


- (IBAction)addtention_click:(id)sender {
    [self doAttend:_masterModel.sellerUid];
}

-(void)doAttend:(NSString *)masterId
{
    [CYWebClient Post:@"DoAttend" parametes:@{@"sellerUid":masterId} success:^(id responObj) {
        NSInteger status = [[responObj objectForKey:@"status"] integerValue];
        if (status == 1) {
            _masterModel.isAttend = @"0";
               [_attendBtn setTitle:@"+关注" forState:UIControlStateNormal];
        }else{
             [_attendBtn setTitle:@"已关注" forState:UIControlStateNormal];
            _masterModel.isAttend = @"1";
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

- (void)setIsMaster:(BOOL)isMaster
{
    _isMaster = isMaster;
    if (isMaster) {
        [_publicBtn setTitle:@"大师介绍" forState:UIControlStateNormal];
    }else{
        [_publicBtn setTitle:@"名家介绍" forState:UIControlStateNormal];
    }
    
    
}

@end
