//
//  GameScene.h
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpriteBase.h"
#import "JsonParser.h"
#import "Bird.h"
#import "Pig.h"
#import "Ice.h"
#import "Slingshot.h"
#import "ContactListener.h"
#import "LevelScene.h"

@interface GameScene : CCLayer <SpriteDelegate,CCTargetedTouchDelegate>
{
    int currentlevel;
    CCLabelTTF *scoreLable;
    int score; //当前总分数
    NSMutableArray *birds;
    
    Bird *currentBird;
    BOOL gameStart;
    BOOL gameFinish;
    
    Slingshot* slingshot;
    int touchStatus;
    
    //define a b2world to make bird fly better
    b2World* world;
    
//    collision listener
    ContactListener* contactListener;
}
//+(id) scene;
//each level
+(id) sceneWithLevel:(int)level;
-(id) initWithLevel:(int)level;

@end
