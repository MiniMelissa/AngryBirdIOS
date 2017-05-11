//
//  GlobalVars.m
//  AngryBirds
//
//  Created by xumeng on 17/5/10.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GlobalVars.h"

@implementation GlobalVars

@synthesize currentlevel=_currentlevel,maxlevel=_maxlevel;

+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _maxlevel=1;
        _currentlevel=1;
    }
    return self;
}

@end
