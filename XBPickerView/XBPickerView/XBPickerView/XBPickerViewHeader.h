//
//  XBPickerViewHeader.h
//  d11
//
//  Created by xxb on 2017/9/8.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#ifndef XBPickerViewHeader_h
#define XBPickerViewHeader_h

typedef struct{
    NSInteger component;
    NSInteger row;
}XBPickerViewIndexset;


#define pickerView_f_PickerViewHeight (200)
#define pickerView_f_btnHeight (50)
#define pickerView_f_cellHeight (50)

#define kFontText(fontSize) [UIFont systemFontOfSize:fontSize]


#define WEAK_SELF __typeof(self) __weak weakSelf = self;

//#define kHeightFactor       (ScreenHeight/667.0)
//#define kWidthFactor        (ScreenWidth/375.0)

#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b)        RGBA(r, g, b, 1.0)


#define PNGIMAGE(NAME)      [UIImage imageNamed:NAME]

//======================================== font ========================================
#define XBPickerView_Font(x)                                         [UIFont systemFontOfSize:x]
//#define XBPickerView_Font_bold(x)                                    [UIFont boldSystemFontOfSize:x]
#define XBPickerView_Font_Text(x)                                    kFontText(x)
#define XBPickerView_Font_Title(x)                                   kFontTitle(x)
#define XBPickerView_Font_btn(x)                                     kFontButton(x)


//屏幕宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


//根据传入的文字、宽度和字体计算出合适的size (CGSize)
#define getAdjustSizeWith_text_width_font(text,width,font) ({[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:NULL].size;})

//根据传入的文字和字体获取宽度 (CGFloat)
#define getWidthWith_title_font(title,font) ({\
UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];\
label.text = title;\
label.font = font;\
[label sizeToFit];\
label.frame.size.width;\
})



#define XBPickerView_text_Cancel                                     NSLocalizedString(@"Cancel", nil)
#define XBPickerView_text_Default                                    NSLocalizedString(@"Default", nil)
#define XBPickerView_text_Done                                       NSLocalizedString(@"Done", nil)



#define XBPickerView_color_dark                                      RGB(127,127,127)
#define XBPickerView_color_done                                      RGBA(241, 174, 76, 1)



#define XBPickerView_float_leadingSpace (15)



#endif /* XBPickerViewHeader_h */
