//
//  TextViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/22/24.
//

#import "TextViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#include <execinfo.h>
#include <dlfcn.h>
#include <string>

OBJC_EXPORT id objc_msgSendSuper2(void);

@interface EditableTextView : UITextView
@property (weak, nonatomic, direct) __kindof UIViewController *_et_systemInputViewController;
@property (retain, readonly, nonatomic, direct) UILabel *_et_placeholderLabel;
@end

@implementation EditableTextView
@synthesize _et_placeholderLabel = __et_placeholderLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        ((void (*)(id, SEL, BOOL))objc_msgSend)(self, sel_registerName("setEditable:"), YES);
    }
    
    return self;
}

- (void)dealloc {
    [__et_placeholderLabel release];
    [super dealloc];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    
    if (result) {
        UIViewController *viewController = ((id (*)(Class, SEL, id))objc_msgSend)(UIViewController.class, sel_registerName("_viewControllerForFullScreenPresentationFromView:"), self);
        
        __kindof UIViewController *systemInputViewController = ((id (*)(Class, SEL, id, id, id))objc_msgSend)(objc_lookUpClass("UISystemInputViewController"), sel_registerName("systemInputViewControllerForResponder:editorView:containingResponder:"), self, self._et_placeholderLabel, viewController);
        
        self._et_systemInputViewController = systemInputViewController;
        [viewController presentViewController:systemInputViewController animated:YES completion:nil];
    }
    
    return result;
}

- (BOOL)resignFirstResponder {
    [self._et_systemInputViewController dismissViewControllerAnimated:YES completion:nil];
    return [super resignFirstResponder];
}

- (UILabel *)_et_placeholderLabel {
    if (auto _et_placeholderLabel = __et_placeholderLabel) return _et_placeholderLabel;
    
    UILabel *_et_placeholderLabel = [UILabel new];
    
    __et_placeholderLabel = [_et_placeholderLabel retain];
    return [_et_placeholderLabel autorelease];
}

- (BOOL)isKindOfClass:(Class)aClass {
    if (aClass != UITextField.class) {
        return [super isKindOfClass:aClass];
    } else if ([self calledFrom_UIDictationController_startHelperMessageDisplayIfNeeded]) {
        return YES;
    } else {
        return [super isKindOfClass:aClass];
    }
}

- (BOOL)_shouldDisplayDictationPlaceholderMessage {
    return YES;
}

- (UIColor *)_placeholderColor {
    return UIColor.labelColor;
}

- (UILabel *)_placeholderLabel {
    if ([self calledFrom_UIDictationController_startHelperMessageDisplayIfNeeded]) {
        return self._et_placeholderLabel;
    } else {
        objc_super superInfo = { self, [self class] };
        return ((id (*)(objc_super *, SEL))objc_msgSendSuper2)(&superInfo, _cmd);
    }
}

- (void)_setOverridePlaceholder:(NSAttributedString *)placeholder alignment:(NSTextAlignment)alignment {
    if ([self calledFrom_UIDictationController_startHelperMessageDisplayIfNeeded]) {
        UILabel *_et_placeholderLabel = self._et_placeholderLabel;
        _et_placeholderLabel.attributedText = placeholder;
        _et_placeholderLabel.textAlignment = alignment;
    } else {
        objc_super superInfo = { self, [self class] };
        ((void (*)(objc_super *, SEL, id, NSTextAlignment))objc_msgSendSuper2)(&superInfo, _cmd, placeholder, alignment);
    }
}

- (BOOL)calledFrom_UIDictationController_startHelperMessageDisplayIfNeeded __attribute__((objc_direct)) {
    void *buffer[3];
    auto count = backtrace(buffer, 3);

    if (count < 3) {
        return NO;
    }

    auto addr = buffer[2];
    struct dl_info info;
    dladdr(addr, &info);
    
    return !std::strcmp(info.dli_sname, "-[UIDictationController startHelperMessageDisplayIfNeeded]");
}

@end


@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EditableTextView *textView = [objc_lookUpClass("_TVFocusableTextView") new];
    
    UIAction *primaryAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil.circle"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [textView becomeFirstResponder];
    }];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeSystem primaryAction:primaryAction];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[textView, editButton]];
    [textView release];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    [stackView release];
}

@end
