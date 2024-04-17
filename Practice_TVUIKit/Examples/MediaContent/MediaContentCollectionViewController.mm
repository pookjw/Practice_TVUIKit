//
//  MediaContentCollectionViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/16/24.
//

#import "MediaContentCollectionViewController.hpp"
#import <TVUIKit/TVUIKit.h>
#import "ImageContentView.hpp"
#import "MediaContentCollectionViewLayout.hpp"
#import "MediaContentCollectionViewCell.h"

// _UIFloatingContentView를 쓰면 이미지뷰가 아니더라도 뭔가 할 수 있을듯 -[UICollectionViewCell focusedFloatingContentView]

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
        contentConfiguration.text = @"Hello!";
        contentConfiguration.secondaryText = @"Hello World";
        contentConfiguration.image = [UIImage systemImageNamed:@"pencil.circle.fill"];
        cell.contentConfiguration = contentConfiguration;
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
