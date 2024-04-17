//
//  FullScreenLayoutCollectionViewCell.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/16/24.
//

#import "FullScreenLayoutCollectionViewCell.hpp"

__attribute__((objc_direct_members))
@interface FullScreenLayoutCollectionViewCell ()
@end

@implementation FullScreenLayoutCollectionViewCell
@synthesize imageView = _imageView;
@synthesize label = _label;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = self.imageView;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.maskedBackgroundView addSubview:imageView];
        [NSLayoutConstraint activateConstraints:@[
            [imageView.widthAnchor constraintEqualToAnchor:self.maskedContentView.widthAnchor],
            [imageView.heightAnchor constraintEqualToAnchor:self.maskedContentView.heightAnchor],
            [imageView.centerXAnchor constraintEqualToAnchor:self.maskedBackgroundView.centerXAnchor],
            [imageView.centerYAnchor constraintEqualToAnchor:self.maskedBackgroundView.centerYAnchor]
        ]];
        
        UILabel *label = self.label;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = @"Hello World";
        label.backgroundColor = UIColor.systemPinkColor;
        [self.maskedContentView addSubview:label];
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:self.maskedContentView.layoutMarginsGuide.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:self.maskedContentView.layoutMarginsGuide.centerYAnchor],
        ]];
    }
    return self;
}

- (void)dealloc {
    [_imageView release];
    [_label release];
    [super dealloc];
}

- (UIImageView *)imageView {
    if (auto imageView = _imageView) return imageView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageView = [imageView retain];
    return [imageView autorelease];
}

- (UILabel *)label {
    if (auto label = _label) return label;
    
    UILabel *label = [UILabel new];
    
    _label = [label retain];
    return [label autorelease];
}

//- (BOOL)canBecomeFocused {
//    NSLog(@"Foo %d", [super canBecomeFocused]);
//    return YES;
//}
//
//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    TVCollectionViewFullScreenLayoutAttributes *_layoutAttributes = (TVCollectionViewFullScreenLayoutAttributes *)layoutAttributes;
//    
//    _layoutAttributes.maskAmount = 0.8f;
//    
//    [super applyLayoutAttributes:_layoutAttributes];
//}

@end
