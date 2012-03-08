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
    NSLog(@"Done pressed!:%@",datePicker);
}
- (void)cancelBtnDidPressed
{
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
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(110, 100, 100, 50)];
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Pop" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)show
{
    // Do any additional setup after loading the view, typically from a nib.
    AXModalDatePicker *modalDatePicker=[[AXModalDatePicker alloc] init];
    modalDatePicker.delegate=self;
    [UIView transitionWithView:self.view duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ { [self.view addSubview:modalDatePicker]; }
                    completion:nil];
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
