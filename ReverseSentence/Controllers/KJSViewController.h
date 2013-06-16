//
//  KJSViewController.h
//  ReverseSentence
//
//  Created by kjs on 6/16/13.
//  Copyright (c) 2013 kjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJSViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

- (IBAction)reverseButtonAction:(id)sender;

- (IBAction)clearButtonAction:(id)sender;


@end
