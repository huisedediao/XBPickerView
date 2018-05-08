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
//    XBPickerView *pickerView = [[XBPickerView alloc] initWithDisplayView:[[UIApplication sharedApplication].delegate window]];
//    NSArray *arr = @[@[@"1",@"2"],@[@"3",@"4"],@[@"5",@"6"]];
//    pickerView.arr_datasource = arr;
//    pickerView.bl_done = ^(XBPickerView *pickerView, NSArray *array) {
//
//    };
//    [pickerView show];
    XBPickerView_single *pickerView = [[XBPickerView_single alloc] initWithDisplayView:[[UIApplication sharedApplication].delegate window]];
    NSArray *num = @[@"60",@"70",@"80",@"90",@"100"];
    pickerView.arr_datasource = num;
    pickerView.bl_done = ^(XBPickerView *pickerView, NSArray *array) {

    };
    pickerView.lb_text.text = @"s";
    [pickerView show];
}


@end
