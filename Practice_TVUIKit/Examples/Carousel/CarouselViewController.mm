//
//  CarouselViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/23/24.
//

#import "CarouselViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>

__attribute__((objc_direct_members))
@interface CarouselViewController ()
@property (retain, readonly, nonatomic) UICollectionViewCellRegistration *cellRegistration;
@end

@implementation CarouselViewController
@synthesize cellRegistration = _cellRegistration;

- (void)dealloc {
    [_cellRegistration release];
    [super dealloc];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    
    if (!result) {
        NSLog(@"%s", sel_getName(aSelector));
    }
    
    return result;
}

- (void)loadView {
    __kindof UIView *carouselView = [objc_lookUpClass("_TVCarouselView") new];
    ((void (*)(id, SEL, id))objc_msgSend)(carouselView, sel_registerName("setDelegate:"), self);
    ((void (*)(id, SEL, id))objc_msgSend)(carouselView, sel_registerName("setDataSource:"), self);
    
    ((void (*)(id, SEL, BOOL))objc_msgSend)(carouselView, sel_registerName("setShowsPageControl:"), YES);
    ((void (*)(id, SEL, CGFloat))objc_msgSend)(carouselView, sel_registerName("setInteritemSpacing:"), 20.f);
    
    ((void (*)(id, SEL, NSTimeInterval))objc_msgSend)(carouselView, sel_registerName("setUnitScrollDuration:"), 10.);
//    ((void (*)(id, SEL, NSTimeInterval))objc_msgSend)(carouselView, sel_registerName("setOffsetChangePerSecond:"), 10.);
    ((void (*)(id, SEL, NSUInteger))objc_msgSend)(carouselView, sel_registerName("setScrollMode:"), 1);
    
    UILabel *headerView = [
        UILabel new];
    headerView.text = @"Hello World!";
    headerView.textColor = UIColor.systemCyanColor;
    headerView.backgroundColor = UIColor.systemBrownColor;
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    ((void (*)(id, SEL, id))objc_msgSend)(carouselView, sel_registerName("setHeaderView:"), headerView);
    [NSLayoutConstraint activateConstraints:@[
        [headerView.topAnchor constraintEqualToAnchor:carouselView.safeAreaLayoutGuide.topAnchor],
        [headerView.leadingAnchor constraintEqualToAnchor:carouselView.safeAreaLayoutGuide.leadingAnchor],
        [headerView.trailingAnchor constraintEqualToAnchor:carouselView.safeAreaLayoutGuide
         .trailingAnchor]
    ]];
    [headerView release];
    
    
    UICollectionViewCellRegistration *cellRegistration = self.cellRegistration;
    NSString *reuseIdentifier = ((id (*)(id, SEL))objc_msgSend)(cellRegistration, sel_registerName("reuseIdentifier"));
    Class cellClass = ((Class (*)(id, SEL))objc_msgSend)(cellRegistration, sel_registerName("cellClass"));
    
    ((void (*)(id, SEL, Class, id))objc_msgSend)(carouselView, sel_registerName("registerClass:forCellWithReuseIdentifier:"), cellClass, reuseIdentifier);
    
    self.view = carouselView;
    [carouselView release];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    
    __kindof UIView *carouselView = self.view;
    ((void (*)(id, SEL, CGSize))objc_msgSend)(carouselView, sel_registerName("setItemSize:"), CGSizeMake(size.width - 600., size.height - 80.));
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    __kindof UIView *carouselView = self.view;
    CGRect bounds = self.view.bounds;
    ((void (*)(id, SEL, CGSize))objc_msgSend)(carouselView, sel_registerName("setItemSize:"), CGSizeMake(CGRectGetWidth(bounds) - 600., CGRectGetHeight(bounds) - 80.));
}

- (UICollectionViewCellRegistration *)cellRegistration {
    if (auto cellRegistration = _cellRegistration) return cellRegistration;
    
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:[UICollectionViewListCell class] configurationHandler:^(__kindof UICollectionViewListCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull item) {
        
        // Focus가 안 되어야 Auto Scroll이 동작하는 내부 원리
        // -[_TVCarouselView _updateAutoScrollTimer]
        ((void (*)(id, SEL, BOOL))objc_msgSend)(cell, sel_registerName("_setFocusInteractionEnabled:"), NO);
        
        UIListContentConfiguration *contentConfiguration = [cell defaultContentConfiguration];
        contentConfiguration.text = indexPath.description;
        cell.contentConfiguration = contentConfiguration;
        
        UIBackgroundConfiguration *backgroundConfiguration = [cell defaultBackgroundConfiguration];
        backgroundConfiguration.backgroundColor = [UIColor.systemPinkColor colorWithAlphaComponent:0.3]
        ;
        cell.backgroundConfiguration = backgroundConfiguration;
        
    }];
    
    _cellRegistration = [cellRegistration retain];
    return cellRegistration;
}

- (NSUInteger)numberOfItemsInCarouselView:(__kindof UIView *)carouselView {
    return 30;
}

- (__kindof UICollectionViewCell *)carouselView:(__kindof UIView *)carouselView cellForItemAtIndex:(NSUInteger)index {
    UICollectionViewCellRegistration *cellRegistration = self.cellRegistration;
    NSString *reuseIdentifier = ((id (*)(id, SEL))objc_msgSend)(cellRegistration, sel_registerName("reuseIdentifier"));
    
    __kindof UICollectionViewCell *cell = ((id (*)(id, SEL, id, NSUInteger))objc_msgSend)(carouselView, sel_registerName("dequeueReusableCellWithReuseIdentifier:forIndex:"), reuseIdentifier, index);
    
    void (^configurationHandler)(UICollectionViewCell *, NSIndexPath *, id) = ((id (*)(id, SEL))objc_msgSend)(cellRegistration, sel_registerName("configurationHandler"));
    
    configurationHandler(cell, [NSIndexPath indexPathForItem:index inSection:0], [NSNull null]);
    
    return cell;
}

- (void)carouselView:(__kindof UIView *)carouselView didCenterItemAtIndex:(NSUInteger)index {
    NSLog(@"%ld", index);
    
}

@end
