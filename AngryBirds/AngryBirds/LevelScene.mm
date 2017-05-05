//
//  LevelScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene

+(id)scene{
    CCScene * cs =[CCScene node];
    LevelScene* ls =[[LevelScene alloc] init];
    [cs addChild:ls];
    [ls release];
    return cs;
}

-(id)init{
    self=[super init];
    if(self){
        CGSize winSize=[[CCDirector sharedDirector]winSize];
        //set background pic as selectlevel
        CCSprite* sp=[CCSprite spriteWithFile:@"selectlevel.png"];
        sp.position=ccp(winSize.width/2.0f, winSize.height/2.0f);
        [self addChild:sp];
        
        //set a back button
        CCSprite* back=[CCSprite spriteWithFile:@"backarrow.png"];
        back.position=ccp(40.0f,40.0f);
        back.scale=0.5f;
        [self addChild:back];
    }
    
    return self;
}
@end
