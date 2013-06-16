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
    [self.inputTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.inputTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.inputTextView.layer setBorderWidth: 1.0];
    [self.inputTextView.layer setCornerRadius:8.0f];
    [self.inputTextView.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reverseButtonAction:(id)sender {
}

- (IBAction)clearButtonAction:(id)sender {
}
@end
