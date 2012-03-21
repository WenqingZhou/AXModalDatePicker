#import <UIKit/UIKit.h>

@protocol AXModalDatePickerDelegate

-(void)doneBtnDidPressed:(UIPickerView *)Picker;
-(void)cancelBtnDidPressed;

@end

@interface AXModalDatePicker : UIView

@property (nonatomic,retain) UIToolbar *toolBar;
@property (nonatomic,retain) UIBarButtonItem *doneBtn;
@property (nonatomic,retain) UIBarButtonItem *cancelBtn;
@property (nonatomic,retain) UIPickerView *datePicker;
@property (nonatomic,retain) UIView *pickerView;
@property (nonatomic,retain) id <AXModalDatePickerDelegate> delegate;
@property BOOL isHidden;

- (AXModalDatePicker *)initWithDelegate:(id<AXModalDatePickerDelegate>)theDelegate andPicker:(id)picker;
- (void)setHidden: (BOOL) hidden animated: (BOOL) animated;
- (void)orientationChanged:(NSNotification *)notification;
- (void)changeLayoutForOrientation:(UIInterfaceOrientation)orientation;
- (void)datePicked;
- (void)dateCancelled;
- (void)setDoneTitle:(NSString *)string;
- (void)setCancelTitle:(NSString *)string;

@end