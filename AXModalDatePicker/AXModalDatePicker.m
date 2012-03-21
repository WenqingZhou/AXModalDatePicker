
#import "AXModalDatePicker.h"

@implementation AXModalDatePicker

@synthesize toolBar,datePicker,cancelBtn,doneBtn,delegate,isHidden,pickerView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (AXModalDatePicker *)initWithDelegate:(id<AXModalDatePickerDelegate>)theDelegate andPicker:(id)picker
{
    self = [super init];
    if (self) {
        toolBar = [[UIToolbar alloc] init];
        self.opaque = NO;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        self.datePicker=picker;
        if (!self.datePicker) {
            datePicker=(id)[[UIDatePicker alloc] init];
        }
        self.delegate=theDelegate;
        self.isHidden=YES;
        pickerView=[[UIView alloc] init];
        [self orientationChanged:nil];
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:delegate action:nil];
        doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done") 
                                                   style:UIBarButtonItemStyleDone 
                                                  target:self 
                                                  action:@selector(datePicked)];
        cancelBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"Cancel") 
                                                     style:UIBarButtonItemStyleBordered 
                                                    target:self 
                                                    action:@selector(dateCancelled)];
        [barItems addObject:cancelBtn];
        [barItems addObject:flexSpace];
        [barItems addObject:doneBtn];
        [flexSpace release];
        [self.toolBar setItems:barItems];
        [barItems release];
        [self.pickerView addSubview:datePicker];
        [self.pickerView addSubview:toolBar];
        [self addSubview:self.pickerView];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

-(void)setDoneTitle:(NSString *)string
{
    [doneBtn setTitle:string];
}

-(void)setCancelTitle:(NSString *)string
{
    [cancelBtn setTitle:string];
}

- (void)datePicked
{
    [self.delegate doneBtnDidPressed:self.datePicker];
    [self removeFromSuperview];
}

- (void)dateCancelled
{
    [self.delegate cancelBtnDidPressed];
    [self removeFromSuperview];
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
            if (!notification) 
            {
                [self changeLayoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
            }
            break;
    }
}

-(void)changeLayoutForOrientation:(UIInterfaceOrientation)orientation
{
    CGRect mainFrame=[[UIScreen mainScreen] bounds];
    switch ( orientation ) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.frame=CGRectMake(mainFrame.origin.y, mainFrame.origin.x, mainFrame.size.height, mainFrame.size.width);
            self.datePicker.frame=CGRectMake(0, 30, 480, 216);
            self.toolBar.frame=CGRectMake(0, 0, 480, 30);
            
            if(self.isHidden)
            {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
                {
                    self.pickerView.frame=CGRectMake((mainFrame.size.height-480)/2, mainFrame.size.width, 480, 246);
                }
                else
                {
                    self.pickerView.frame=CGRectMake((mainFrame.size.height-480)/2, mainFrame.size.width, 480, 246);
                }
            }
            else
            {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
                {
                    self.pickerView.frame=CGRectMake((mainFrame.size.height-480)/2, (mainFrame.size.width-246)/2, 480, 246);
                }
                else
                {
                    self.pickerView.frame=CGRectMake((mainFrame.size.height-480)/2, (mainFrame.size.width-246), 480, 246);
                }
                
            }
            break;
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            self.frame=mainFrame;
            self.datePicker.frame=CGRectMake(0, 30, 320, 216);
            self.toolBar.frame=CGRectMake(0, 0, 320, 30);
            if(self.isHidden)
            {
                self.pickerView.frame=CGRectMake((mainFrame.size.width-320)/2, mainFrame.size.height, 320, 246);
            }
            else
            {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
                {
                    self.pickerView.frame=CGRectMake((mainFrame.size.width-320)/2, (mainFrame.size.height-246)/2, 320, 246);
                }
                else
                {
                    self.pickerView.frame=CGRectMake((mainFrame.size.width-320)/2, (mainFrame.size.height-246), 320, 246);
                }
                
            }
            break;
        default:
            return;
    }
}

- (void) setHidden: (BOOL) hidden animated: (BOOL) animated 
{
    if (self.isHidden==!hidden) {
        CGRect newFrame = self.pickerView.frame;
        if (hidden) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
            {
                newFrame.origin.y+=(self.frame.size.height+self.pickerView.frame.size.height)/2;
            }
            else
            {
                newFrame.origin.y+=pickerView.frame.size.height;
            }
        }
        else
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
            {
                newFrame.origin.y-=(self.frame.size.height+self.pickerView.frame.size.height)/2;
            }
            else
            {
                newFrame.origin.y-=pickerView.frame.size.height;
            }
        }
        
        if (animated && UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            [UIView beginAnimations: @"animateDateTimePicker" context: nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
            
            self.pickerView.frame = newFrame;      
            
            [UIView commitAnimations]; 
        } else {
            self.pickerView.frame = newFrame;      
        }
        self.isHidden=hidden;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 [super drawRect:rect];
 // Drawing code
 }
 */



-(void)dealloc
{
    NSLog(@"AXModalDatePicker dealloc!");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    self.toolBar=nil;
    self.delegate=nil;
    self.datePicker=nil;
    self.cancelBtn=nil;
    self.doneBtn=nil;
    self.pickerView=nil;
    [super dealloc];
}

@end
