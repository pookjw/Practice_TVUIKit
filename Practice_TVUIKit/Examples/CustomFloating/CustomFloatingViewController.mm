//
//  CustomFloatingViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/17/24.
//

#import "CustomFloatingViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>

@interface CustomFloatingTrackingFocusView : UIView
@property (retain, readonly, nonatomic, direct) UILabel *label;
@end
@implementation CustomFloatingTrackingFocusView
@synthesize label = _label;

- (void)dealloc {
    [_label release];
    [super dealloc];
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    self.label.text = context.nextFocusedView.description;
}

- (UILabel *)label {
    if (auto label = _label) return label;
    
    UILabel *label = [UILabel new];
    _label = [label retain];
    return [label autorelease];
}

@end

__attribute__((objc_direct_members))
@interface CustomFloatingDemoView : UIView
@property (retain, readonly, nonatomic) __kindof UIView *floatingContentView;
@property (retain, readonly, nonatomic) __kindof UILabel *label;
@end

@implementation CustomFloatingDemoView
@synthesize floatingContentView = _floatingContentView;
@synthesize label = _label;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __kindof UIView *floatingContentView = self.floatingContentView;
        floatingContentView.frame = self.bounds;
        floatingContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:floatingContentView];
        
        UIView *highlightView = ((id (*)(id, SEL))objc_msgSend)(floatingContentView, sel_registerName("highlightView"));
        UIView *transformView = ((id (*)(id, SEL))objc_msgSend)(floatingContentView, sel_registerName("transformView"));
        UIView *contentView = ((id (*)(id, SEL))objc_msgSend)(floatingContentView, sel_registerName("contentView"));
        UIView *visualEffectContainerView = ((id (*)(id, SEL))objc_msgSend)(floatingContentView, sel_registerName("visualEffectContainerView"));
        
        UILabel *label = self.label;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0"]];
//        imageView.adjustsImageWhenAncestorFocused = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[label, imageView]];
        stackView.spacing = 8.f;
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.alignment = UIStackViewAlignmentCenter;
        stackView.distribution = UIStackViewDistributionFillProportionally;
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];

        [label setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [contentView addSubview:stackView];
        [NSLayoutConstraint activateConstraints:@[
            [stackView.topAnchor constraintEqualToAnchor:contentView.topAnchor],
            [stackView.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor],
            [stackView.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor],
            [stackView.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor]
        ]];
        
        [contentView addSubview:stackView];
        [imageView release];
        [stackView release];
        
        visualEffectContainerView.backgroundColor = [UIColor.systemGreenColor colorWithAlphaComponent:0.2f];
    }
    
    return self;
}

- (void)dealloc {
    [_floatingContentView release];
    [_label release];
    [super dealloc];
}

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    [super pressesBegan:presses withEvent:event];
    ((void (*)(id, SEL, NSUInteger, BOOL))objc_msgSend)(self.floatingContentView, sel_registerName("setControlState:animated:"), 9, YES);
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    [super pressesEnded:presses withEvent:event];
    ((void (*)(id, SEL, NSUInteger, BOOL))objc_msgSend)(self.floatingContentView, sel_registerName("setControlState:animated:"), self.focused ? 8 : 0, YES);
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    [super pressesCancelled:presses withEvent:event];
    ((void (*)(id, SEL, NSUInteger, BOOL))objc_msgSend)(self.floatingContentView, sel_registerName("setControlState:animated:"), self.focused ? 8 : 0, YES);
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(600.f, 300.f);
}

- (BOOL)canBecomeFocused {
    return YES;
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    if ([context.nextFocusedView isEqual:self]) {
        ((void (*)(id, SEL, NSUInteger, BOOL))objc_msgSend)(self.floatingContentView, sel_registerName("setControlState:animated:"), 8, YES);
        ((void (*)(id, SEL, NSUInteger))objc_msgSend)(self.label, sel_registerName("updateAppearanceForLockupViewState:"), 8);
    } else {
        ((void (*)(id, SEL, NSUInteger, BOOL))objc_msgSend)(self.floatingContentView, sel_registerName("setControlState:animated:"), 0, YES);
        ((void (*)(id, SEL, NSUInteger))objc_msgSend)(self.label, sel_registerName("updateAppearanceForLockupViewState:"), 0);
    }
}

- (__kindof UIView *)floatingContentView {
    if (auto floatingContentView = _floatingContentView) return floatingContentView;
    
    __kindof UIView *floatingContentView = ((id (*)(id, SEL, CGRect))objc_msgSend)([objc_lookUpClass("_UIFloatingContentView") alloc], @selector(initWithFrame:), self.bounds);
    
//    ((void (*)(id, SEL, BOOL))objc_msgSend)(floatingContentView, sel_registerName("setFocusedSizeIncrease:"), YES);
    ((void (*)(id, SEL, CGPoint))objc_msgSend)(floatingContentView, sel_registerName("setFocusScaleAnchorPoint:"), CGPointMake(0.5f, 1.f));
    ((void (*)(id, SEL, CGPoint, CGPoint))objc_msgSend)(floatingContentView, sel_registerName("setContentMotionRotation:translation:"), CGPointMake(M_PI, M_PI), CGPointMake(8.f, 0.f));
    
    _floatingContentView = [floatingContentView retain];
    return [floatingContentView autorelease];
}

- (UILabel *)label {
    if (auto label = _label) return label;
    
    UILabel *label = [[objc_lookUpClass("_TVLockupLabel") alloc] initWithFrame:self.bounds];
    label.text = @"Custom Floating View!";
    label.textAlignment = NSTextAlignmentCenter;
    
    _label = [label retain];
    return [label autorelease];
}

@end

__attribute__((objc_direct_members))
@interface CustomFloatingViewController ()
@end

@implementation CustomFloatingViewController

- (void)loadView {
    CustomFloatingTrackingFocusView *view = [CustomFloatingTrackingFocusView new];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = ((CustomFloatingTrackingFocusView *)self.view).label;

    //
    
    UIAction *action = [UIAction actionWithTitle:@"Hello" image:[UIImage systemImageNamed:@"hand.wave"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem primaryAction:action];
    CustomFloatingDemoView *demoView = [[CustomFloatingDemoView alloc] init];
    
    __kindof UIView *progressView = [objc_lookUpClass("_TVMediaItemImageOverlayProgressView") new];
    progressView.tintColor = UIColor.systemGreenColor;
    ((void (*)(id, SEL, float))objc_msgSend)(progressView, sel_registerName("setPlaybackProgress:"), 0.6f);
    
    UIProgressView *progressView_2 = [UIProgressView new];
    progressView_2.progressViewStyle = UIProgressViewStyleDefault;
    progressView_2.progress = 0.6f;
    
    //
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[label, button, demoView, progressView, progressView_2]];
    stackView.spacing = 30.f;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //
    
    [self.view addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
        [label.widthAnchor constraintEqualToConstant:600.f],
        [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [demoView.heightAnchor constraintEqualToConstant:300.f]
    ]];
    
    [stackView release];
    [demoView release];
    [progressView release];
    [progressView_2 release];
}



@end
