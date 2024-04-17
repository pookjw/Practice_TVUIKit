//
//  FullScreenLayoutCollectionViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/14/24.
//

#import "FullScreenLayoutCollectionViewController.hpp"
#import "ImageContentView.hpp"
#import "FullScreenLayoutCollectionViewCell.hpp"
#import <TVUIKit/TVUIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

__attribute__((objc_direct_members))
@interface FullScreenLayoutCollectionViewController () <TVCollectionViewDelegateFullScreenLayout>
@property (retain, readonly, nonatomic) UICollectionViewCellRegistration *cellRegistration;
@end

@implementation FullScreenLayoutCollectionViewController
@synthesize cellRegistration = _cellRegistration;

- (instancetype)init {
    TVCollectionViewFullScreenLayout *collectionViewLayout = [TVCollectionViewFullScreenLayout new];
    collectionViewLayout.maskAmount = 1.f;
    collectionViewLayout.interitemSpacing = 100.f;
    collectionViewLayout.parallaxFactor = 1.f;
//    collectionViewLayout.maskInset = UIEdgeInsetsZero;
    collectionViewLayout.maskInset = UIEdgeInsetsMake(300.f, 300.f, 0.f, 300.f);
    
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
}

- (UICollectionViewCellRegistration *)cellRegistration {
    if (auto cellRegistration = _cellRegistration) return cellRegistration;
    
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:FullScreenLayoutCollectionViewCell.class configurationHandler:^(__kindof FullScreenLayoutCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull item) {
        cell.imageView.image = [UIImage imageNamed:[NSNumber numberWithInteger:indexPath.item].stringValue];
//        UIListContentConfiguration *contentConfiguration = [cell defaultContentConfiguration];
//        contentConfiguration.text = @"Hello!";
//        contentConfiguration.secondaryText = @"Secondary!";
//        contentConfiguration.image = [UIImage systemImageNamed:@"eraser.line.dashed.fill"];
//        cell.contentConfiguration = contentConfiguration;
        
//        ImageContentConfiguration *contentConfiguration = [[ImageContentConfiguration alloc] initWithFrame:cell.bounds imageName:[NSNumber numberWithInteger:indexPath.item].stringValue];
//        cell.contentConfiguration = contentConfiguration;
//        [contentConfiguration release];
    }];
    
    _cellRegistration = [cellRegistration retain];
    return cellRegistration;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueConfiguredReusableCellWithRegistration:self.cellRegistration forIndexPath:indexPath item:[NSNull null]];
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willCenterCellAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didCenterCellAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

@end
