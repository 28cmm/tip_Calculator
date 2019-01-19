//
//  ViewController.m
//  Tip Calculator
//
//  Created by Yilei Huang on 2019-01-18.
//  Copyright © 2019 Joshua Fanng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sliderPercentLabel;
@property (strong, nonatomic) IBOutlet UIView *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property float sliderFloat;
@property BOOL yesOrNot;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHiden:) name:UIKeyboardDidShowNotification object:nil];
    self.yesOrNot = NO;
    //self.billAmountTextField =[UITextField new];
    self.billAmountTextField.placeholder = @"enter you bill amount";
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)calculateTip:(id)sender {
    int resultTip= self.billAmountTextField.text.intValue * (int)self.sliderFloat *0.01;
    self.tip.text = [NSString stringWithFormat:@"Tip need to pay :%d", (int)(resultTip)];
    self.yesOrNot =YES;
}
- (IBAction)percentSlider:(UISlider*)sender {
    if(self.yesOrNot == NO){
        
    }else{
        [self drive];
        
    }
    self.sliderPercentLabel.text = [NSString stringWithFormat:@"%d%%",(int)(sender.value*100)];
    self.sliderFloat = sender.value*100;
   
    
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
 int k= [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y-k/2,self.view.frame.size.width,self.view.frame.size.height)];
}
- (void)keyboardDidHiden:(NSNotification *)notification
{
    int k= [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y+k/2,self.view.frame.size.width,self.view.frame.size.height)];
}




- (void)drive {
    [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES  block:^(NSTimer * _Nonnull timer) {
        int resultTip= self.billAmountTextField.text.intValue * (int)self.sliderFloat *0.01;
        self.tip.text = [NSString stringWithFormat:@"Tip need to pay :%d", (int)(resultTip)];
    }];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    if(self.yesOrNot == NO){
        
    }else{
        [self drive];
        
    }
    return YES;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
//-(void)keyboardDidShow:(NSNotificationCenter *)sender{
//
//
//    [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height+700)];
//
//}
//-(void)keyboardDidHiden:(NSNotificationCenter *)sender{
//   [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height-700)];
//
//}


@end
