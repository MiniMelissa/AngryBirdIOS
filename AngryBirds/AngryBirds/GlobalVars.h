//
//  GlobalVars.h
//  AngryBirds
//
//  Created by xumeng on 17/5/10.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalVars : NSObject
{
    int _currentlevel;
    int _maxlevel;
}

+ (GlobalVars *)sharedInstance;

@property(nonatomic,readwrite) int currentlevel;
@property(nonatomic,readwrite) int maxlevel;


@end


