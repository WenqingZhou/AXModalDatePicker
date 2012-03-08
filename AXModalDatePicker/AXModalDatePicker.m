//
//  AXModalDatePicker.m
//  AXModalDatePicker
//
//  Created by wenqing zhou on 3/7/12.
//  Copyright (c) 2012 university of helsinki. All rights reserved.
//

#import "AXModalDatePicker.h"

@implementation AXModalDatePicker

@synthesize delegate;
@synthesize datePicker;
@synthesize pickerToolBar;
@synthesize animatedOn;

- (void)dealloc
{
    NSLog(@"dealloc!");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    self.delegate=nil;
    self.pickerToolBar=nil;
    self.datePicker=nil;
    [super dealloc];
}

- (AXModalDatePicker *)init
{
    CGRect screenFrame=[[UIScreen mainScreen] bounds];
    self= [super initWithFrame:screenFrame];
    if (self) {
        datePicker=[[UIDatePicker alloc] init];
        pickerToolBar=[[UIToolbar alloc] init];
        NSMutableArray *barItems=[[NSMutableArray alloc] init];
        UIBarButtonItem *flexSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done") 
                                                                  style:UIBarButtonItemStyleDone 
                                                                 target:self 
                                                                 action:@selector(doneBtnDidPressed)];
        UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                 target:self 
                                                                                 action:@selector(cancelBtnDidPressed)];
        [barItems addObject:cancelBtn];
        [barItems addObject:flexSpace];
        [barItems addObject:doneBtn];
        [pickerToolBar setItems:barItems animated:YES];
        [pickerToolBar setBarStyle:UIBarStyleBlack];
        [barItems release];
        [self addSubview:datePicker];
        [self addSubview:pickerToolBar];
        self.opaque = NO;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        [self orientationChanged:nil];
    }
    return self;
}

- (void)orientationChanged:(NSNotification *)notification {  
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    switch (orientation) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            [self changeLayoutForOrientation:UIInterfaceOrientationLandscapeLeft];
            break;
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            [self changeLayoutForOrientation:UIInterfaceOrientationPortrait];
            break;   
        default:
            [self changeLayoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
            break;
    }
}

- (void)changeLayoutForOrientation:(UIInterfaceOrientation)orientation
{
    switch ( orientation ) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            self.frame=[[UIScreen mainScreen] bounds];
            self.frame=CGRectMake(self.frame.origin.y, self.frame.origin.x, self.frame.size.height, self.frame.size.width);
            self.datePicker.frame=CGRectMake(0, self.frame.size.height-216, 480, 216);
            self.pickerToolBar.frame=CGRectMake(0, self.frame.size.height-216-40, 480, 40);
            break;
        }
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            self.frame=[[UIScreen mainScreen] bounds];
            self.datePicker.frame=CGRectMake(0, self.frame.size.height-216, 320, 216);
            self.pickerToolBar.frame=CGRectMake(0, self.frame.size.height-216-40, 320, 40);
            break;
        default:
            return;
    }
}

- (void)cancelBtnDidPressed
{
    [self.delegate cancelBtnDidPressed];
    [self removeFromSuperview];
}

- (void)doneBtnDidPressed
{
    [self.delegate doneBtnDidPressed:self.datePicker];
    [self removeFromSuperview];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
