//
//  XBPickerView_single.m
//  d11
//
//  Created by xxb on 2017/9/8.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBPickerView_single.h"
#import "Masonry.h"

@interface XBPickerView_single () <UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation XBPickerView_single

- (instancetype)init
{
    if (self = [super init])
    {
        self.pv_choose.delegate = self;
        self.pv_choose.dataSource = self;
        self.lb_text.backgroundColor = self.lb_text.backgroundColor;
    }
    return self;
}

- (void)show
{
    [super show];
    
    WEAK_SELF
    self.btn_done.bl_click = ^(XBButton *weakBtn) {
        [weakSelf hidden];
        
        NSInteger row = [weakSelf.pv_choose selectedRowInComponent:0];
        NSString *dateStr = [weakSelf.arr_datasource objectAtIndex:row];
        NSArray *arr = @[dateStr];
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pickerView:doneClickWithStrArr:)])
        {
            [weakSelf.delegate pickerView:weakSelf doneClickWithStrArr:arr];
        }
        
        if (weakSelf.bl_done)
        {
            weakSelf.bl_done(weakSelf, arr);
        }
    };
}


#pragma mark - UIPickerView 代理和数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arr_datasource.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.arr_datasource[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return pickerView_f_cellHeight;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    XBPickerViewIndexset indexSet;
//    indexSet.row = row;
//    indexSet.component = 0;
//    self.selectedIndexset = indexSet;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


#pragma mark - 懒加载
- (UILabel *)lb_text
{
    if (_lb_text == nil)
    {
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ScreenWidth * 0.5);
            make.height.mas_equalTo(pickerView_f_cellHeight);
            make.centerY.equalTo(self).offset(pickerView_f_cellHeight * 0.5);
            make.trailing.equalTo(self);
        }];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        _lb_text = label;
    }
    return _lb_text;
}

@end
