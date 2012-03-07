//
//  AXModalDatePickerSampleViewController.m
//  AXModalDatePicker
//
//  Created by wenqing zhou on 3/7/12.
//  Copyright (c) 2012 university of helsinki. All rights reserved.
//

#import "AXModalDatePickerSampleViewController.h"

@implementation AXModalDatePickerSampleViewController

- (void)doneBtnDidPressed:(UIDatePicker *)datePicker
{
    [self show];
    NSLog(@"Done pressed!:%@",datePicker);
}
- (void)cancelBtnDidPressed
{
    [self show];
    NSLog(@"cancel pressed!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self show];
}

- (void)show
{
    // Do any additional setup after loading the view, typically from a nib.
    AXModalDatePicker *modalDatePicker=[[AXModalDatePicker alloc] init];
    modalDatePicker.delegate=self;
    [self.view addSubview:modalDatePicker];
    [modalDatePicker release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
