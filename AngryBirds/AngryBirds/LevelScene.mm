//
//  LevelScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "LevelScene.h"
#import "GameUtils.h"
#import "StartScene.h"

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
        CCSprite* bg=[CCSprite spriteWithFile:@"bg.png"];
        bg.position=ccp(winSize.width/2, winSize.height/2);
        [bg setScaleX:winSize.width/bg.contentSize.width];
        [bg setScaleY:winSize.height/bg.contentSize.height];
        [self addChild:bg];
        
        //set a back button
        CCSprite* back=[CCSprite spriteWithFile:@"backarrow.png"];
        back.position=ccp(40.0f,40.0f);
        back.scale=0.5f;
        back.tag=100;
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
                float x=80+i%7*80; //间隔60
                float y=320-75-i/7*80; //间隔80
                label.position=ccp(x, y);
                [self addChild:label z:2];// z=2 to keep label is above level
            }else{
                //uncompleted
                imagePath=@"clock.png";
            }
            CCSprite *level=[CCSprite spriteWithFile:imagePath];
            level.tag=i+1;//i+1 to avoid tag=0, cuz default tag=0
            float x=80+i%7*80; //间隔60
            float y=320-60-i/7*80; //间隔80
            level.position=ccp(x, y);
            level.scale=0.6f;
            [self addChild:level z:1];
        }
        //set self can be touched, make self accept touch event
        [self setIsTouchEnabled:YES];
    }
    
    return self;
}

//touch finished touches is the set of touching dots.触摸点集合
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //get touching dots
    UITouch *oneFinger=[touches anyObject];
    //get current touch view, touchView is glView(openGL)
    UIView* touchView=[oneFinger view];
    //transfer to world openGL point
    CGPoint location=[oneFinger locationInView:touchView];
    //transfer uiview to world location
    CGPoint worldPoint=[[CCDirector sharedDirector] convertToGL:location];
    //world point to node point
    CGPoint nodePoint=[self convertToNodeSpace:worldPoint];
    
    //self.childre.count is self 上所有的一层孩子
    for(int i=0;i<self.children.count;i++ ) {
        //get the ith sprite of self
        CCSprite* one=[self.children objectAtIndex:i];
        //make sure back is in self, tag=100 means it is 100
        if(CGRectContainsPoint(one.boundingBox, nodePoint)&&one.tag==100){
//            [self schedule:@selector(tick:) interval:1.0f];

            CCScene* start=[StartScene scene];
            [[CCDirector sharedDirector] replaceScene:start];
          /*
            CCScene * cs= [StartScene scene];
            CCTransitionScene* trans=[[CCTransitionMoveInB alloc]initWithDuration:1.0f scene:cs];
            [[CCDirector sharedDirector] replaceScene:trans];
            [trans release];*/
        }
        else if(CGRectContainsPoint(one.boundingBox, nodePoint)&& one.tag<sucesslevel+1 && one.tag>0) {
            NSLog(@"choose %ld\n .",(long)one.tag);
//            CCScene* cs=[GameScene scene];

            //change one.tag(=-1) to 2, pig and ice appear
            CCScene* cs=[GameScene sceneWithLevel:one.tag];
            [[CCDirector sharedDirector] replaceScene:cs];
        }
    }
    
    
}
@end
