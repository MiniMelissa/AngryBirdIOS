//
//  GameScene.h
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "SpriteBase.h"
#import "Bird.h"

@interface GameScene : CCLayer <SpriteDelegate>
{
    int currentlevel;
    CCLabelTTF *scoreLable;
    int score; //当前总分数
    NSMutableArray *birds;
    
    Bird *currentBird;
    BOOL gameStart;
    BOOL gameFinish;
}
+(id) scene;
//each level
+(id) sceneWithLevel:(int)level;
-(id) initWithLevel:(int)level;

@end
