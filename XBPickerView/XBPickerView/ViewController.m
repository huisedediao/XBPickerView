//
//  ViewController.m
//  XBPickerView
//
//  Created by xxb on 2018/5/8.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "ViewController.h"
#import "XBPickerView_single.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XBPickerView *pickView = [[XBPickerView alloc] initWithDisplayView:[[UIApplication sharedApplication].delegate window]];
    NSMutableArray *arrM_hour = [NSMutableArray new];
    NSMutableArray *arrM_min = [NSMutableArray new];
    for (int i = 0; i < 24; i++)
    {
        [arrM_hour addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    for (int i = 0; i < 60; i++)
    {
        [arrM_min addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    pickView.arr_datasource = @[arrM_hour,arrM_min];
    pickView.bl_done = ^(XBPickerView *pickerView, NSArray *array) {
        
    };
    [pickView show];
//    XBPickerView_single *pickerView = [[XBPickerView_single alloc] initWithDisplayView:[[UIApplication sharedApplication].delegate window]];
//    NSArray *num = @[@"60",@"70",@"80",@"90",@"100"];
//    pickerView.arr_datasource = num;
//    pickerView.bl_done = ^(XBPickerView *pickerView, NSArray *array) {
//
//    };
//    pickerView.lb_text.text = @"s";
//    [pickerView show];
}


@end
