//
//  TextViewController.m
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/19/24.
//

#import "TextViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <execinfo.h>
#import <dlfcn.h>

BOOL isCalledFromMethod(Class cls, SEL name) {
    void *buffer[3];
    auto count = backtrace(buffer, 3);

    if (count < 3) {
        return NO;
    }

    auto addr = buffer[2];
    struct dl_info info;
    dladdr(addr, &info);

    auto baseAddr = class_getMethodImplementation(cls, name);

    return !strcmp("-[UITextView becomeFirstResponder]", info.dli_sname);
}

@interface EditableTextView : UITextView
@end

@implementation EditableTextView

- (BOOL)canBecomeFirstResponder {
    UIUserInterfaceIdiomTV;
    return YES;
}

- (BOOL)isEditable {
    return YES;
}

- (BOOL)_requiresKeyboardWhenFirstResponder {
    return YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ((void (*)(id, SEL, BOOL))objc_msgSend)(self, sel_registerName("setEditable:"), YES);
        self.selectable = YES;
    
//        id textInputTraits = ((id (*)(Class, SEL))objc_msgSend)(objc_lookUpClass("UITextInputTraits"), sel_registerName("defaultTextInputTraits"));
//        object_setInstanceVariable(self, "_textInputTraits", (void *)textInputTraits);
//        [textInputTraits retain];
        ((void (*)(id, SEL))objc_msgSend)(self, sel_registerName("_updateSelectableInteractions"));
    }
    return self;
}

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    NSLog(@"%d", result);
    return result;
}

@end

@interface TextViewController ()

@end

@implementation TextViewController

- (void)loadView {
    EditableTextView *textView = [EditableTextView new];
    self.view = textView;
    [textView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view becomeFirstResponder];
    });
}

@end
