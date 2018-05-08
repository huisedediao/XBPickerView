//
//  XBPickerView.m
//  d11
//
//  Created by xxb on 2017/9/8.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBPickerView.h"
#import "Masonry.h"

@interface XBPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation XBPickerView

- (void)dealloc
{
    NSLog(@"XBPickerView销毁");
}

- (void)setSelectedIndexset:(XBPickerViewIndexset)selectedIndexset
{
    _selectedIndexset = selectedIndexset;
    [self.pv_choose selectRow:selectedIndexset.row inComponent:selectedIndexset.component animated:YES];
}

- (void)show
{
    [self createSubviews];
    
    WEAK_SELF
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(alertView.superview);
            make.height.mas_equalTo(pickerView_f_cellHeight * weakSelf.i_rowCount + pickerView_f_btnHeight);
        }];
    };
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(alertView.superview);
            make.height.mas_equalTo(pickerView_f_cellHeight * weakSelf.i_rowCount + pickerView_f_btnHeight);
            make.top.equalTo(alertView.superview.mas_bottom);
        }];
    };
    [self.pv_choose reloadAllComponents];
    [super show];
    [self clearSeparatorWithView:self.pv_choose];
}

- (void)createSubviews
{
    WEAK_SELF
    
    if (self.btn_cancel == nil)
    {
        XBButton *btn_cancel = [XBButton new];
        [self addSubview:btn_cancel];
        [btn_cancel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.25, pickerView_f_btnHeight));
        }];
        btn_cancel.font_title = XB_Font(18);
        btn_cancel.str_titleNormal = XB_text_Cancel;
        btn_cancel.color_titleNormal = XB_color_dark;
        btn_cancel.enum_contentSide = XBBtnSideLeft;
        btn_cancel.f_spaceToContentSide = XB_float_leadingSpace;
        btn_cancel.bl_click = ^(XBButton *weakBtn) {
            [weakSelf hidden];
        };
        self.btn_cancel = btn_cancel;
    }

    if (self.btn_done == nil)
    {
        XBButton *btn_done = [XBButton new];
        [self addSubview:btn_done];
        [btn_done mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.25, pickerView_f_btnHeight));
        }];
        btn_done.font_title = XB_Font(18);
        btn_done.str_titleNormal = XB_text_Done;
        btn_done.color_titleNormal = XB_color_blue;
        btn_done.enum_contentSide = XBBtnSideRight;
        btn_done.f_spaceToContentSide = XB_float_leadingSpace;
        btn_done.bl_click = ^(XBButton *weakBtn) {
            [weakSelf hidden];
            NSMutableArray *arrM = [NSMutableArray new];
            for (int i = 0; i < weakSelf.arr_datasource.count; i++)
            {
                NSInteger row = [weakSelf.pv_choose selectedRowInComponent:i];
                NSString *dateStr = [weakSelf.arr_datasource[i] objectAtIndex:row];
                [arrM addObject:dateStr];
            }
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pickerView:doneClickWithStrArr:)])
            {
                [weakSelf.delegate pickerView:weakSelf doneClickWithStrArr:arrM];
            }
            
            if (weakSelf.bl_done)
            {
                weakSelf.bl_done(weakSelf, arrM);
            }
        };
        self.btn_done = btn_done;
    }
}
- (UIPickerView *)pv_choose
{
    if (_pv_choose == nil)
    {
        UIPickerView *pickerView = [UIPickerView new];
        [self addSubview:pickerView];
        [pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(pickerView_f_btnHeight);
            make.leading.trailing.bottom.equalTo(self);
        }];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        _pv_choose = pickerView;
        
        UIColor *lineColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        
        UIView *line1 = [UIView new];
        [self addSubview:line1];
        line1.backgroundColor = lineColor;
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(pickerView_f_cellHeight * (self.i_rowCount / 2) + pickerView_f_btnHeight);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line2 = [UIView new];
        [self addSubview:line2];
        line2.backgroundColor = lineColor;
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(pickerView_f_cellHeight * (self.i_rowCount / 2 + 1) + pickerView_f_btnHeight);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _pv_choose;
}
- (NSInteger)i_rowCount
{
    if (_i_rowCount == 0)
    {
        _i_rowCount = 5;
    }
    return _i_rowCount;
}

#pragma mark - UIPickerView 代理和数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.arr_datasource.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arr_datasource[component] count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.arr_datasource[component][row];
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


#pragma mark - 其他方法
- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0)
    {
        if(view.bounds.size.height < 5)
        {
            view.backgroundColor = [UIColor clearColor];
        }
        
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
    
}
@end
