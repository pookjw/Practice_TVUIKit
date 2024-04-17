//
//  MediaContentCollectionViewLayout.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/17/24.
//

#import "MediaContentCollectionViewLayout.hpp"

@implementation MediaContentCollectionViewLayout

- (instancetype)init {
    UICollectionViewCompositionalLayoutConfiguration *configuration = [UICollectionViewCompositionalLayoutConfiguration new];
    configuration.scrollDirection = UICollectionViewScrollDirectionVertical;
    configuration.interSectionSpacing = 22.f;
    
    self = [self initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger sectionIndex, id<NSCollectionLayoutEnvironment>  _Nonnull layoutEnvironment) {
        NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:200.f]
                                                                          heightDimension:[NSCollectionLayoutDimension absoluteDimension:400.f]];
        
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
        
        NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.f]
                                                                           heightDimension:[NSCollectionLayoutDimension absoluteDimension:400.f]];
        
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
        group.interItemSpacing = [NSCollectionLayoutSpacing fixedSpacing:22.f];
        
        NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
//        section.interGroupSpacing = 22.f;
        
        return section;
    } 
                                                                                                                       configuration:configuration];
    
    [configuration release];
    
    return self;
}

@end
