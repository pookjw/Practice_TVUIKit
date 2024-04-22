//
//  TextFieldViewController.m
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/22/24.
//

#import "TextFieldViewController.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:self.view.bounds];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:textField];
    [NSLayoutConstraint activateConstraints:@[
        [textField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    
    [textField release];
}

@end
