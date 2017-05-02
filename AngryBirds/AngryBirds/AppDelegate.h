//
//  AppDelegate.h
//  AngryBirds
//
//  Created by xumeng on 17/5/2.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

