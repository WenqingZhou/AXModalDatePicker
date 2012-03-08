//
//  AXModalDatePicker.h
//  AXModalDatePicker
//
//  Created by wenqing zhou on 3/7/12.
//  Copyright (c) 2012 university of helsinki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AXModalDatePickerDelegate

- (void)doneBtnDidPressed:(UIDatePicker *)datePicker;
- (void)cancelBtnDidPressed;

@end

@interface AXModalDatePicker : UIView

@property (retain,nonatomic) id <AXModalDatePickerDelegate> delegate;
@property (retain,nonatomic) UIDatePicker *datePicker;
@property (retain,nonatomic) UIToolbar *pickerToolBar;
@property BOOL animatedOn;

- (void)changeLayoutForOrientation:(UIInterfaceOrientation)orientation;
- (void)cancelBtnDidPressed;
- (void)doneBtnDidPressed;
- (void)orientationChanged:(NSNotification *)notification;

@end
