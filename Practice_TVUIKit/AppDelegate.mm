//
//  AppDelegate.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/14/24.
//

#import "AppDelegate.hpp"
#import "SceneDelegate.hpp"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    UISceneConfiguration *configuration = [connectingSceneSession.configuration copy];
    configuration.delegateClass = SceneDelegate.class;
    return [configuration autorelease];
}

@end
