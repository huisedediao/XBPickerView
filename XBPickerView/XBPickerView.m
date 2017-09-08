//
//  XBPickerView.m
//  d11
//
//  Created by xxb on 2017/9/8.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBPickerView.h"
#import "XBCusBtn.h"
#import "XBHeader.h"

@interface XBPickerView ()
@property (nonatomic,strong) XBCusBtn *btn_cancel;
@property (nonatomic,strong) XBCusBtn *btn_done;
@end

@implementation XBPickerView

- (void)setSelectedIndexset:(XBPickerViewIndexset)selectedIndexset
{
    _selectedIndexset = selectedIndexset;
    [self.pv_choose selectRow:selectedIndexset.row inComponent:selectedIndexset.component animated:YES];
}

- (void)show
{
    [self createSubviews];
    
    self.showLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(alertView.superview);
            make.height.mas_equalTo(pickerView_f_PickerViewHeight);
        }];
    };
    self.hiddenLayoutBlock = ^(XBAlertViewBase *alertView) {
        [alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(alertView.superview);
            make.height.mas_equalTo(pickerView_f_PickerViewHeight);
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
        XBCusBtn *btn_cancel = [XBCusBtn new];
        [self addSubview:btn_cancel];
        [btn_cancel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.25, pickerView_f_btnHeight));
        }];
        btn_cancel.titleFont = D11_Font(18);
        btn_cancel.titleNormal = D11_Text_Cancel;
        btn_cancel.titleColorNormal = D11_color_dark;
        btn_cancel.contentSide = XBCusBtnSideLeft;
        btn_cancel.spaceToContentSide = D11_float_leadingSpace;
        btn_cancel.block = ^(XBCusBtn *weakBtn) {
            [weakSelf hidden];
        };
        self.btn_cancel = btn_cancel;
    }

    if (self.btn_done == nil)
    {
        XBCusBtn *btn_done = [XBCusBtn new];
        [self addSubview:btn_done];
        [btn_done mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.25, pickerView_f_btnHeight));
        }];
        btn_done.titleFont = D11_Font(18);
        btn_done.titleNormal = D11_Text_Done;
        btn_done.titleColorNormal = D11_Color_blue;
        btn_done.contentSide = XBCusBtnSideRight;
        btn_done.spaceToContentSide = D11_float_leadingSpace;
        btn_done.block = ^(XBCusBtn *weakBtn) {
            [weakSelf hidden];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pickerView:doneClickAtIndexset:)])
            {
                [weakSelf.delegate pickerView:weakSelf doneClickAtIndexset:self.selectedIndexset];
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
        pickerView.delegate = self.pickerDelegate;
        pickerView.dataSource = self.pickerDelegate;
        _pv_choose = pickerView;
        
        UIColor *lineColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        
        UIView *line1 = [UIView new];
        [self addSubview:line1];
        line1.backgroundColor = lineColor;
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(pickerView_f_cellHeight + pickerView_f_btnHeight);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line2 = [UIView new];
        [self addSubview:line2];
        line2.backgroundColor = lineColor;
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(pickerView_f_cellHeight * 2 + pickerView_f_btnHeight);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _pv_choose;
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
