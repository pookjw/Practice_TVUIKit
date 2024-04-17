//
//  MediaContentCollectionViewCell.m
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/17/24.
//

#import "MediaContentCollectionViewCell.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation MediaContentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ((void (*)(id, SEL, NSInteger))objc_msgSend)(self, sel_registerName("_setFocusStyle:"), 1);
        ((void (*)(id, SEL))objc_msgSend)(self, sel_registerName("_ensureFocusedFloatingContentView"));
    }
    return self;
}

@end
