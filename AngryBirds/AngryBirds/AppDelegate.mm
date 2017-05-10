//
//  AppDelegate.m(changing AppDelegate.m to AppDelegate.mm)cuz .mm inluding c/c++/oc
//  AngryBirds
//
//  Created by xumeng on 17/5/2.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "AppDelegate.h"
#import "cocos2d.h"
#import "ViewController.h"
#import "LoadingScene.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   // kCCDirectorTypeDefault
    
    //we set director type as kCCDirectorTypeDisplayLink, yes:set successfully,No:set as kCCDirectorTypeDefault
    if(![CCDirector setDirectorType:kCCDirectorTypeDisplayLink]){
        [CCDirector setDirectorType:kCCDirectorTypeDefault];
    }
    
    //get direct, singleton pattern, use this direct to controll the whole game
    CCDirector* direct =[CCDirector sharedDirector];
    
    //create a UIView, it has OpenGL ES feature
    //kEAGLColorFormatRGB565 2G
    EAGLView *eaglView=[EAGLView viewWithFrame:[self.window bounds] pixelFormat:kEAGLColorFormatRGB565 depthFormat:0];
    //set this UIView connected with director
    [direct setOpenGLView:eaglView];
    
    //set game direction as left,if we dont commen this line, the value of display on the left-up  corner
//    [direct setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
    
    // refresh animation 60 times/min
    [direct setAnimationInterval:1.0f/60.0f];
    //for debugging purpose, display current refresh speed,shown in left-bottom corner
//    [direct setDisplayFPS:YES];
    
    //set rootview as root
    ViewController *rootview=[[ViewController alloc]init];
    [rootview setView:eaglView];
    [self.window setRootViewController:rootview];
    [rootview  release];
    [self.window makeKeyAndVisible];

    //display a scene
    CCScene * sc= [LoadingScene node];
    //director run scene
    [[CCDirector sharedDirector] runWithScene:sc];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   
    //pasue game
    [[CCDirector sharedDirector] pause];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //stop animation and refresh
    [[CCDirector sharedDirector] stopAnimation];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    //start animation
    [[CCDirector sharedDirector]startAnimation];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //re-run
    [[CCDirector sharedDirector] resume];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    
    //we can not complete this part in this game
    CCDirector* director=[CCDirector sharedDirector];
    [[director openGLView] removeFromSuperview];
    [self.window release];
    [director end];
    
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"AngryBirds"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
