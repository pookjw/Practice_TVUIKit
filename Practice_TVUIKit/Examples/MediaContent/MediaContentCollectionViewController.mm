//
//  MediaContentCollectionViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/16/24.
//

#import "MediaContentCollectionViewController.hpp"
#import <TVUIKit/TVUIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "ImageContentView.hpp"
#import "MediaContentCollectionViewLayout.hpp"
#import "MediaContentCollectionViewCell.h"

__attribute__((objc_direct_members))
@interface MediaContentCollectionViewController ()
@property (retain, readonly, nonatomic) UICollectionViewCellRegistration *cellRegistration;
@end

@implementation MediaContentCollectionViewController
@synthesize cellRegistration = _cellRegistration;

- (instancetype)init {
    MediaContentCollectionViewLayout * collectionViewLayout = [MediaContentCollectionViewLayout new];
    
    if (self = [super initWithCollectionViewLayout:collectionViewLayout]) {
        
    }
    
    [collectionViewLayout release];
    
    return self;
}

- (void)dealloc {
    [_cellRegistration release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cellRegistration];
//    [UICollectionViewFlowLayout new].high
//    self.collectionView.focus
}

- (UICollectionViewCellRegistration *)cellRegistration {
    if (auto cellRegistration = _cellRegistration) return cellRegistration;
    
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:UICollectionViewCell.class configurationHandler:^(__kindof UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull item) {
        TVMediaItemContentConfiguration *contentConfiguration = [TVMediaItemContentConfiguration wideCellConfiguration];
//        TVMediaItemContentConfiguration *contentConfiguration = ((id (*)(Class, SEL))objc_msgSend)(TVMediaItemContentConfiguration.class, sel_registerName("_squareCellConfiguration"));
        contentConfiguration.text = @"Hello!";
        contentConfiguration.secondaryText = @"Hello World";
        contentConfiguration.badgeText = @"123";
        UIView *overlayView = [UIView new];
        overlayView.backgroundColor = [UIColor.systemRedColor colorWithAlphaComponent:0.5f];
        contentConfiguration.overlayView = overlayView;
        [overlayView release];
//        contentConfiguration.image = [UIImage systemImageNamed:@"pencil.circle.fill"];
        contentConfiguration.playbackProgress = 0.6f;
        cell.contentConfiguration = contentConfiguration;
        
        cell.configurationUpdateHandler = ^(__kindof UICollectionViewCell * _Nonnull cell, UICellConfigurationState * _Nonnull state) {
            cell.layer.zPosition = state.isFocused ? 1 : 0;
        };
    }];
    
    _cellRegistration = [cellRegistration retain];
    return cellRegistration;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueConfiguredReusableCellWithRegistration:self.cellRegistration forIndexPath:indexPath item:[NSNull null]];
}

@end
