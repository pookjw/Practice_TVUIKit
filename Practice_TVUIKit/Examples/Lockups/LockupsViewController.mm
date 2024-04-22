//
//  LockupsViewController.m
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/23/24.
//

#import "LockupsViewController.h"
#import <TVUIKit/TVUIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

namespace pt__UIFloatingContentView {
    namespace setContentMotionRotation_translation {
        void (*original)(id, SEL, CGPoint, CGPoint);
        void custom(id self, SEL _cmd, CGPoint x2, CGPoint x3) {
            original(self, _cmd, x2, x3);
        }
    }
}

// TVLockupView 직접 커스텀 해보기

__attribute__((objc_direct_members))
@interface LockupsViewController ()
@property (retain, readonly, nonatomic) UIStackView *stackView;
@property (retain, readonly, nonatomic) TVCardView *cardView;
@property (retain, readonly, nonatomic) TVPosterView *posterView;
@property (retain, readonly, nonatomic) TVCaptionButtonView *captionButtonView;
@end

@implementation LockupsViewController
@synthesize stackView = _stackView;
@synthesize cardView = _cardView;
@synthesize posterView = _posterView;
@synthesize captionButtonView = _captionButtonView;

+ (void)load {
    Method method = class_getInstanceMethod(objc_lookUpClass("_UIFloatingContentView"), sel_registerName("setContentMotionRotation:translation:"));
    pt__UIFloatingContentView::setContentMotionRotation_translation::original = (void (*)(id, SEL, CGPoint, CGPoint))method_getImplementation(method);
    method_setImplementation(method, (IMP)pt__UIFloatingContentView::setContentMotionRotation_translation::custom);
}

- (void)dealloc {
    [_stackView release];
    [_cardView release];
    [_posterView release];
    [_captionButtonView release];
    [super dealloc];
}

- (void)loadView {
    self.view = self.stackView;
}

- (UIStackView *)stackView {
    if (auto stackView = _stackView) return stackView;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        self.cardView,
        self.posterView,
        self.captionButtonView
    ]];
    
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 8.f;
    
    _stackView = [stackView retain];
    return [stackView autorelease];
}

- (TVCardView *)cardView {
    if (auto cardView = _cardView) return cardView;
    
    TVCardView *cardView = [TVCardView new];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cardView.bounds];
    label.text = @"Hello World!";
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [cardView.contentView addSubview:label];
    [label release];
    
    __kindof UIView *contentView = ((id (*)(id, SEL))objc_msgSend)(cardView, sel_registerName("concreteContentView"));
    __kindof UIView *floatingContentView = ((id (*)(id, SEL))objc_msgSend)(contentView, sel_registerName("floatingContentView"));
    
    ((void (*)(id, SEL, BOOL))objc_msgSend)(floatingContentView, sel_registerName("setFocusedSizeIncrease:"), YES);
    ((void (*)(id, SEL, CGPoint))objc_msgSend)(floatingContentView, sel_registerName("setFocusScaleAnchorPoint:"), CGPointMake(0.5f, 1.f));
    ((void (*)(id, SEL, CGPoint, CGPoint))objc_msgSend)(floatingContentView, sel_registerName("setContentMotionRotation:translation:"), CGPointMake(M_PI, M_PI), CGPointMake(0.f, 8.f));
    
    _cardView = [cardView retain];
    return [cardView autorelease];
}

- (TVPosterView *)posterView {
    if (auto posterView = _posterView) return posterView;
    
    TVPosterView *posterView = [[TVPosterView alloc] initWithImage:[UIImage imageNamed:@"small"]];
    posterView.title = @"Hello World!";
    posterView.subtitle = @"Dragon becomes me!";
    
    _posterView = [posterView retain];
    return [posterView autorelease];
}

- (TVCaptionButtonView *)captionButtonView {
    if (auto captionButtonView = _captionButtonView) return captionButtonView;
    
    TVCaptionButtonView *captionButtonView = [TVCaptionButtonView new];
    captionButtonView.contentImage = [UIImage systemImageNamed:@"person.2.crop.square.stack"];
//    captionButtonView.contentText = @"Hello World! (1)";
    captionButtonView.title = @"Hello World! (2)";
    captionButtonView.subtitle = @"Subtitle!";
    
    // -[_TVCaptionButtonContentView updateMotionDirection:]
    captionButtonView.motionDirection = TVCaptionButtonViewMotionDirectionAll;
    
    _captionButtonView = [captionButtonView retain];
    return [captionButtonView autorelease];
}

@end
