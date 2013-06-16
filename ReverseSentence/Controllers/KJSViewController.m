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
    
    if(self.inputTextView.text.length)
    {
        self.outputTextView.text = [self reverseWordsAndSwapCapitalization:words];
        NSLog(@"Sentence Reversed: >>%@<<", self.outputTextView.text);
    }
    
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


-(NSString *)reverseWordsAndSwapCapitalization:(NSArray *)words
{
    // assumption: toggle case on First / Last words no matter what case is
    NSMutableString *reversed = [NSMutableString stringWithCapacity:1];
    int last  = [words count]-1;
    int first = 0;
    for (int i=last; i>=first; i--) {
        if(i == first || i == last)
        {
            [self toggleCase:words[i]];
            [reversed appendFormat:@"%@%@", [self toggleCase:words[i]], (i>0 ? @" " : @"") ];
        }
        else
        {
            [reversed appendFormat:@"%@%@", words[i], (i>0 ? @" " : @"") ];
        }
    }
    return reversed;
}

-(BOOL) isFirstLetterUpperCase:(NSString *)str
{
    return[[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[str characterAtIndex:0]];
}

-(BOOL) isFirstLetterLowerCase:(NSString *)str
{
    return[[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:[str characterAtIndex:0]];
}

-(NSString *)toggleCase:(NSMutableString *)str
{
    NSString *swapCase;
    if([self isFirstLetterLowerCase:str])
    {
        swapCase = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] capitalizedString]];
    }
    else if([self isFirstLetterUpperCase:str])
    {
        swapCase = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] lowercaseString]];
    }
    else
    {
        swapCase = [NSString stringWithString:str];
    }
    return swapCase;
}


- (void)showKeyboard
{
    keyboardDisplayed = YES;
}

- (void)hideKeyboard
{
    keyboardDisplayed = NO;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:     (NSString *)text
{
    // assumption: dismiss keyboard on "Return" key
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}

@end
