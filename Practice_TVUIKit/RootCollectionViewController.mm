//
//  RootCollectionViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/14/24.
//

#import "RootCollectionViewController.hpp"
#import "FullScreenLayoutCollectionViewController.hpp"
#import "FloatingCollectionViewController.hpp"
#import "MediaContentCollectionViewController.hpp"
#import "CustomFloatingViewController.hpp"
#import "MonogramCollectionViewController.h"
#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "LockupsViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <TVUIKit/TVUIKit.h>

// Menu 버튼 먹어버리는?
// Split View
// TVServices
// _TVCarouselView

// https://developer.apple.com/documentation/tvservices/building-a-full-screen-top-shelf-extension?language=objc

__attribute__((objc_direct_members))
@interface RootCollectionViewController ()
@property (retain, readonly, nonatomic) UICollectionViewCellRegistration *cellRegistration;
@property (readonly, nonatomic) NSArray<Class> *viewControllerClasses;
@end

@implementation RootCollectionViewController

@synthesize cellRegistration = _cellRegistration;

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.title = @"Root";
    }
    
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
    
    UICollectionViewCellRegistration *cellRegistration = [UICollectionViewCellRegistration registrationWithCellClass:UICollectionViewListCell.class configurationHandler:^(__kindof UICollectionViewListCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, Class _Nonnull item) {
        UIListContentConfiguration *contentConfiguration = [cell defaultContentConfiguration];
        contentConfiguration.text = NSStringFromClass(item);
        contentConfiguration.secondaryText = @"Secondary";
        contentConfiguration.image = [UIImage systemImageNamed:@"circle.hexagongrid"];
        cell.contentConfiguration = contentConfiguration;
        
        UICellAccessoryDisclosureIndicator *disclosureIndicator = [UICellAccessoryDisclosureIndicator new];
        
        cell.accessories = @[
            disclosureIndicator
        ];
        
        [disclosureIndicator release];
    }];
    
    _cellRegistration = [cellRegistration retain];
    return cellRegistration;
}

- (NSArray<Class> *)viewControllerClasses {
    return @[
        LockupsViewController.class,
        TextViewController.class,
        TextFieldViewController.class,
        TVDigitEntryViewController.class,
        MonogramCollectionViewController.class,
        CustomFloatingViewController.class,
        MediaContentCollectionViewController.class,
        FloatingCollectionViewController.class,
        FullScreenLayoutCollectionViewController.class
    ];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewControllerClasses.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueConfiguredReusableCellWithRegistration:self.cellRegistration forIndexPath:indexPath item:self.viewControllerClasses[indexPath.item]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Class _class = self.viewControllerClasses[indexPath.item];
    __kindof UIViewController *viewController = [_class new];
    
    if ([viewController isKindOfClass:TVDigitEntryViewController.class]) {
        TVDigitEntryViewController *digitEntryViewController = viewController;
        digitEntryViewController.entryCompletionHandler = ^(NSString * _Nonnull entry) {
            NSLog(@"%@", entry);
        };
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
