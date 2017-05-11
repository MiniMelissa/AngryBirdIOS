//
//  LevelScene.h
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface LevelScene : CCLayer{
    int sucesslevel;
    //当前成功通关数
}

//+(id) sceneWithLevel:(int)level;
+(id) scene;
@end
