//
//  SceneDelegate.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/14/24.
//

#import "SceneDelegate.hpp"
#import "RootCollectionViewController.hpp"

@implementation SceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    
    UICollectionLayoutListConfiguration *listConfiguration = [[UICollectionLayoutListConfiguration alloc] initWithAppearance:UICollectionLayoutListAppearanceGrouped];
    UICollectionViewCompositionalLayout *collectionViewLayout = [UICollectionViewCompositionalLayout layoutWithListConfiguration:listConfiguration];
    [listConfiguration release];
    RootCollectionViewController *rootViewController = [[RootCollectionViewController alloc] initWithCollectionViewLayout:collectionViewLayout];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [rootViewController release];
    
    window.rootViewController = navigationController;
    [navigationController release];
    
    self.window = window;
    [window makeKeyAndVisible];
    [window release];
}

@end
