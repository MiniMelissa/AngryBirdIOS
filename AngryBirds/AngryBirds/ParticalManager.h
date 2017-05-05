//
//  ParticalManager.h
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//define 2 kinds of partical effect
typedef enum{
    ParticalSnow,
    ParticalBirdExplosion,
    ParticalMax
}ParticalType;

@interface ParticalManager : NSObject
//singleton ,get the only one object
+(id) sharedParticalManager;
//get partical object of specified type 
-(CCParticleSystem*) particalWithType:(ParticalType)type;

@end
