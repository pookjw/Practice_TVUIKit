//
//  ImageContentView.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/15/24.
//

#import "ImageContentView.hpp"

__attribute__((objc_direct_members))
@interface ImageContentConfiguration ()
@property (assign, readonly, nonatomic) CGRect frame;
@property (copy, readonly, nonatomic) NSString *imageName;
@property (assign, readonly, getter=isFocused) BOOL focused;
@end

@implementation ImageContentConfiguration

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName {
    if (self = [super init]) {
        _frame = frame;
        _imageName = [imageName copy];
    }
    
    return self;
}

- (void)dealloc {
    [_imageName release];
    [super dealloc];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    __kindof ImageContentConfiguration *copy = [[self class] new];
    
    if (copy) {
        copy->_frame = _frame;
        copy->_imageName = [_imageName copy];
        copy->_focused = _focused;
    }
    
    return copy;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        ImageContentConfiguration *_other = other;
        
        return CGRectEqualToRect(_frame, _other->_frame) &&
        [_imageName isEqualToString:_other->_imageName] &&
        _focused == _other->_focused;
    }
}

- (NSUInteger)hash {
    return [NSValue valueWithCGRect:_frame].hash ^ _imageName.hash ^ _focused;
}

- (nonnull __kindof UIView<UIContentView> *)makeContentView { 
    return [[[ImageContentView alloc] initWithFrame:_frame contentConfiguration:self] autorelease];
}

- (nonnull instancetype)updatedConfigurationForState:(nonnull id<UIConfigurationState>)state {
    BOOL focused = ((UICellConfigurationState *)state).focused;
    ImageContentConfiguration *copy = [self copy];
    copy->_focused = focused;
    
    return [copy autorelease];
}

@end


__attribute__((objc_direct_members))
@interface ImageContentView ()
@property (copy, nonatomic) ImageContentConfiguration *contentConfiguration;
@property (retain, readonly, nonatomic) UIImageView *imageView;
@end

@implementation ImageContentView

@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame contentConfiguration:(ImageContentConfiguration *)contentConfiguration {
    if (self = [super initWithFrame:frame]) {
//        self.clipsToBounds = YES;
        self.backgroundColor = UIColor.systemPinkColor;
        
        UIImageView *imageView = self.imageView; // _UIStackedImageContainerView
        imageView.adjustsImageWhenAncestorFocused = YES;
        imageView.masksFocusEffectToContents = NO;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        [NSLayoutConstraint activateConstraints:@[
            [imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
        ]];
        
        self.contentConfiguration = contentConfiguration;
    }
    
    return self;
}

- (void)dealloc {
    [_contentConfiguration release];
    [_imageView release];
    [super dealloc];
}

- (id<UIContentConfiguration>)configuration {
    return _contentConfiguration;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(600.f, 600.f);
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    return CGSizeMake(600.f, 600.f);
}

- (void)setConfiguration:(id<UIContentConfiguration>)configuration {
    self.contentConfiguration = (ImageContentConfiguration *)configuration;
}

- (void)setContentConfiguration:(ImageContentConfiguration *)contentConfiguration {
    ImageContentConfiguration *old = _contentConfiguration;
    ImageContentConfiguration *copy = [contentConfiguration copy];
    
    _contentConfiguration = [copy retain];
    
    if (![old.imageName isEqualToString:copy.imageName]) {
        self.imageView.image = [UIImage imageNamed:copy.imageName];
    }
    
    NSLog(@"%d", copy.focused);
//    self.superview.layer.zPosition = copy.focused ? 1 : 0;
    
    [copy release];
}

- (BOOL)supportsConfiguration:(id<UIContentConfiguration>)configuration {
    return [configuration isKindOfClass:ImageContentConfiguration.class];
}

- (UIImageView *)imageView {
    if (auto imageView = _imageView) return imageView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageView = [imageView retain];
    return [imageView autorelease];
}

@end
