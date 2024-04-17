//
//  MonogramCollectionViewController.m
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/18/24.
//

#import "MonogramCollectionViewController.h"
#import <TVUIKit/TVUIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "ImageContentView.hpp"
#import "MediaContentCollectionViewLayout.hpp"
#import "MediaContentCollectionViewCell.h"

__attribute__((objc_direct_members))
@interface MonogramCollectionViewController ()
@property (retain, readonly, nonatomic) UICollectionViewCellRegistration *cellRegistration;
@end

@implementation MonogramCollectionViewController
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
        TVMonogramContentConfiguration *contentConfiguration = [TVMonogramContentConfiguration cellConfiguration];
        contentConfiguration.text = @"Hello!";
        contentConfiguration.secondaryText = @"Hello World";
        
        NSPersonNameComponents *personNameComponents = [NSPersonNameComponents new];
        personNameComponents.givenName = @"Johnathan";
        personNameComponents.middleName = @"Maple";
        personNameComponents.namePrefix = @"Mr.";
        personNameComponents.nameSuffix = @"Jr.";
        personNameComponents.familyName = @"Appleseed";
//        personNameComponents.givenName = @"김";
//        personNameComponents.familyName = @"진우";
        
        contentConfiguration.personNameComponents = personNameComponents;
        [personNameComponents release];
        
//        contentConfiguration.image = [UIImage systemImageNamed:@"hand.raised.fill"];
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
