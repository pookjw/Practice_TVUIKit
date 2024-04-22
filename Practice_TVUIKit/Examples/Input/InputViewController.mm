//
//  InputViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/22/24.
//

#import "InputViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface KeyInputLabel : UILabel <UIKeyInput>
@end

@implementation KeyInputLabel

- (BOOL)_requiresKeyboardWhenFirstResponder {
    return YES;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canBecomeFocused {
    return YES;
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    if ([context.nextFocusedView isEqual:self]) {
        self.backgroundColor = UIColor.systemPinkColor;
    } else {
        self.backgroundColor = UIColor.systemGreenColor;
    }
    
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
}

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

- (BOOL)hasText {
    return self.text.length > 0;
}

- (void)insertText:(NSString *)text {
    self.text = [self.text stringByAppendingString:text];
}

- (void)deleteBackward {
    NSUInteger length = self.text.length;
    if (length == 0) return;
    
    NSRange range = NSMakeRange(0, length - 1);
    self.text = [self.text substringWithRange:range];
}

@end

__attribute__((objc_direct_members))
@interface InputViewController ()
@property (retain, readonly, nonatomic) __kindof UIViewController * /* UISystemInputViewController * */ systemInputViewController;
@property (retain, readonly, nonatomic) KeyInputLabel *keyInputLabel;
@end

@implementation InputViewController
@synthesize systemInputViewController = _systemInputViewController;
@synthesize keyInputLabel = _keyInputLabel;

- (void)dealloc {
    [_systemInputViewController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeyInputLabel *keyInputLabel = self.keyInputLabel;
    keyInputLabel.translatesAutoresizingMaskIntoConstraints = NO;
    ((void (*)(id, SEL, BOOL))objc_msgSend)(keyInputLabel, sel_registerName("_setSuppressSoftwareKeyboard:"), NO);
    [self.view addSubview:keyInputLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [keyInputLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [keyInputLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [keyInputLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [keyInputLabel.heightAnchor constraintEqualToConstant:100.f]
    ]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [keyInputLabel becomeFirstResponder];
        
    });
}

- (__kindof UIViewController *)systemInputViewController {
    if (auto systemInputViewController = _systemInputViewController) return systemInputViewController;
    
    __kindof UIViewController *systemInputViewController = ((id (*)(Class, SEL, id, id, id))objc_msgSend)(objc_lookUpClass("UISystemInputViewController"), sel_registerName("systemInputViewControllerForResponder:editorView:containingResponder:"), self.keyInputLabel, nil, self);
    
    _systemInputViewController = [systemInputViewController retain];
    return systemInputViewController;
}

- (KeyInputLabel *)keyInputLabel {
    if (auto keyInputLabel = _keyInputLabel) return keyInputLabel;
    
    KeyInputLabel *keyInputLabel = [[KeyInputLabel alloc] initWithFrame:self.view.bounds];
    keyInputLabel.backgroundColor = UIColor.systemGreenColor;
    
    _keyInputLabel = [keyInputLabel retain];
    return [keyInputLabel autorelease];
}

@end
