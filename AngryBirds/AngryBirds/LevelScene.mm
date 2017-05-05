//
//  LevelScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "LevelScene.h"
#import "GameUtils.h"

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
        
        
        //add 14
        sucesslevel=[GameUtils readLevelFromFile];
        
        NSString* imagePath=nil;
        for(int i=0;i<14;i++){
            if(i<sucesslevel){
                //completed
                imagePath=@"level.png";
                NSString* str=[NSString stringWithFormat:@"%d",i+1];
                CCLabelTTF* label=[CCLabelTTF  labelWithString:str dimensions:CGSizeMake(60.0f, 60.0f)  alignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:30.0f];
                float x=60+i%7*60; //间隔60
                float y=320-75-i/7*80; //间隔80
                label.position=ccp(x, y);
                [self addChild:label z:2];// z=2 to keep label is above level
            }else{
                //uncompleted
                imagePath=@"clock.png";
            }
            CCSprite *level=[CCSprite spriteWithFile:imagePath];
            level.tag=i+1;//i+1 to avoid tag=0, cuz default tag=0
            float x=60+i%7*60; //间隔60
            float y=320-60-i/7*80; //间隔80
            level.position=ccp(x, y);
            level.scale=0.6f;
            [self addChild:level z:1];
        }
    }
    
    return self;
}
@end
