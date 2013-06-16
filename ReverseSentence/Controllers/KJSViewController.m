//
//  KJSViewController.m
//  ReverseSentence
//
//  Created by kjs on 6/16/13.
//  Copyright (c) 2013 kjs. All rights reserved.
//

#import "KJSViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface KJSViewController ()

@end

@implementation KJSViewController

BOOL keyboardDisplayed = NO;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTextViewStyle:self.inputTextView];
    [self setDelegates];
    [self setObservers];
}

-(void)setTextViewStyle:(UITextView *)textview
{
    [self.inputTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.inputTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.inputTextView.layer setBorderWidth: 1.0];
    [self.inputTextView.layer setCornerRadius:8.0f];
    [self.inputTextView.layer setMasksToBounds:YES];
}

-(void)setDelegates
{
    self.inputTextView.delegate = self;
}

-(void)setObservers
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(showKeyboard) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(hideKeyboard) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reverseButtonAction:(id)sender
{
    if(keyboardDisplayed)
    {
        [[self inputTextView]resignFirstResponder];
    }
    NSString  *input = [[self inputTextView]text];
    NSArray   *words = [input componentsSeparatedByString:@" "];
    self.outputTextView.text = [self reverseWords:words];
    
    NSLog(@"Sentence Reversed: >>%@<<", self.outputTextView.text);
}

- (IBAction)clearButtonAction:(id)sender
{
    if(keyboardDisplayed)
    {
        [[self inputTextView]resignFirstResponder];
    }
    self.inputTextView.text  = @"";
    self.outputTextView.text = @"";
}

-(NSString *)reverseWords:(NSArray *)words
{
    NSMutableString *reversed = [NSMutableString stringWithCapacity:1];
    for (int i=[words count]-1; i>=0; i--) {
        [reversed appendFormat:@"%@%@", words[i], (i>0 ? @" " : @"") ];
    }
    return reversed;
}


- (void)showKeyboard
{
    keyboardDisplayed = YES;
}

- (void)hideKeyboard
{
    keyboardDisplayed = NO;
}


#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:     (NSString *)text
{
    // NOTE: for this example dismiss keyboar on "Return" key
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}

@end
