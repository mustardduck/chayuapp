//
//  CYLocationPickerView.m
//  TeaMall
//
//  Created by Chayu on 15/11/18.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYLocationPickerView.h"
#import "FMDB.h"
@interface CYLocationPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    FMDatabase *fmdb;
    NSMutableArray *_provinceArr;
    NSMutableArray *_cityArr;
    NSMutableArray *_areaArr;
    NSMutableDictionary *_locationInfo;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

@implementation CYLocationPickerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _pickerView.delegate = self;
    _pickerView.dataSource = self;

    [self openTheFMDB];
    _provinceArr = [[NSMutableArray alloc] init];
    _cityArr  = [[NSMutableArray alloc] init];
    _areaArr = [[NSMutableArray alloc] init];
    _locationInfo = [[NSMutableDictionary alloc] init];
    [self loadAddressData:@"0" IsProvince:YES OrIsCity:NO OrIsArea:NO WithFirst:YES];
    [_pickerView reloadAllComponents];
    [_locationInfo setObject:[_provinceArr[0] objectForJSONKey:@"name"] forKey:@"province"];
    [_locationInfo setObject:[_provinceArr[0] objectForJSONKey:@"areaid"] forKey:@"provinceId"];
    [_locationInfo setObject:_cityArr[0][@"name"] forKey:@"city"];
    [_locationInfo setObject:_cityArr[0][@"areaid"] forKey:@"cityId"];
    [_locationInfo setObject:_areaArr[0][@"name"] forKey:@"area"];
    [_locationInfo setObject:_areaArr[0][@"areaid"] forKey:@"areaId"];
    
}

-(void)openTheFMDB
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chayu" ofType:@"db"];
    fmdb = [FMDatabase databaseWithPath:filePath];
    [fmdb open];
}

-(void)loadAddressData:(NSString *)parentid
            IsProvince:(BOOL)isProvince
              OrIsCity:(BOOL)isCity
              OrIsArea:(BOOL)isArea
             WithFirst:(BOOL)isFirst
{

    NSString *querySql = [NSString stringWithFormat:@"select * from tea_area where parentid = %@",parentid];
    FMResultSet *set = [fmdb executeQuery:querySql];
    while ([set next]) {
        NSMutableDictionary *Info = [NSMutableDictionary dictionary];
        [Info setObject: [set stringForColumn:@"name"] forKey:@"name"];
        [Info setObject: [set stringForColumn:@"areaid"] forKey:@"areaid"];
        if (isProvince) {
            [_provinceArr addObject:Info];
        }
        if (isCity) {
            [_cityArr addObject:Info];
        }
        
        if (isArea) {
            [_areaArr addObject:Info];
        }
    }
    
    if (isFirst) {
        if ([_provinceArr count] && [_cityArr count] ==0) {
            [self loadAddressData:_provinceArr[0][@"areaid"] IsProvince:NO OrIsCity:YES OrIsArea:NO WithFirst:YES];
        }
        if ([_cityArr count] && [_areaArr count] ==0) {
            [self loadAddressData:_cityArr[0][@"areaid"] IsProvince:NO OrIsCity:NO OrIsArea:YES WithFirst:YES];
        }
    }
}

-(void)layoutSubviews
{
    
}
- (IBAction)cancel_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
}
- (IBAction)confirm_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(confirmselectLocationInfo:)]) {
        [self.delegate confirmselectLocationInfo:_locationInfo];
    }
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArr.count;
    } else if (component == 1) {
        return _cityArr.count;
    } else {
        if ([_areaArr count] == 0) {
            return 1;
        }
        return _areaArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {

        return [[_provinceArr objectAtIndex:row] objectForJSONKey:@"name"];
    } else if (component == 1) {
        return [[_cityArr objectAtIndex:row] objectForJSONKey:@"name"];
    } else {
        if ([_areaArr count] ==0 ) {
            return @"其他区";
        }
        return [[_areaArr objectAtIndex:row] objectForJSONKey:@"name"];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    return SCREEN_WIDTH/3.;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    if (component == 0) {
      NSDictionary *info = _provinceArr[row];
        [_cityArr removeAllObjects];
        [self loadAddressData:info[@"areaid"] IsProvince:NO OrIsCity:YES OrIsArea:NO WithFirst:NO];
        [_areaArr removeAllObjects];
        [self loadAddressData:_cityArr[0][@"areaid"] IsProvince:NO OrIsCity:NO OrIsArea:YES WithFirst:NO];
        [_locationInfo setObject:[info objectForJSONKey:@"name"] forKey:@"province"];
        [_locationInfo setObject:[info objectForJSONKey:@"areaid"] forKey:@"provinceId"];
        [_locationInfo setObject:_cityArr[0][@"name"] forKey:@"city"];
        [_locationInfo setObject:_cityArr[0][@"areaid"] forKey:@"cityId"];
        [_locationInfo setObject:_areaArr[0][@"name"] forKey:@"area"];
        [_locationInfo setObject:_areaArr[0][@"areaid"] forKey:@"areaId"];
    }
    
    [pickerView selectedRowInComponent:0];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:0];
    
    if (component == 1) {
        [_areaArr removeAllObjects];
        NSDictionary *info = _cityArr[row];
        [self loadAddressData:info[@"areaid"] IsProvince:NO OrIsCity:NO OrIsArea:YES WithFirst:NO];
        [pickerView selectRow:1 inComponent:2 animated:NO];
        [_locationInfo setObject:[info objectForJSONKey:@"name"] forKey:@"city"];
        [_locationInfo setObject:[info objectForJSONKey:@"areaid"] forKey:@"cityId"];
        if ([_areaArr count]) {
            [_locationInfo setObject:_areaArr[0][@"name"] forKey:@"area"];
            [_locationInfo setObject:_areaArr[0][@"areaid"] forKey:@"areaId"];
        }else{
            [_locationInfo setObject:@"其他区" forKey:@"area"];
            [_locationInfo setObject:@"0" forKey:@"areaId"];
        }
     
    }
    [pickerView reloadComponent:2];
    
    if (component == 2) {
        if ([_areaArr count]) {
            NSDictionary *info = _areaArr[row];
            [_locationInfo setObject:[info objectForJSONKey:@"name"] forKey:@"area"];
            [_locationInfo setObject:[info objectForJSONKey:@"areaid"] forKey:@"areaId"];
        }else{
            [_locationInfo setObject:@"其他区" forKey:@"area"];
            [_locationInfo setObject:@"0" forKey:@"areaId"];
        }
        
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:14];
        pickerLabel.numberOfLines = 0;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end
