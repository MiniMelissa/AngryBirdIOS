//
//  StartScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/4.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)scene{
    CCScene* cs=[CCScene node];
    StartScene* sc=[StartScene node];
    [cs addChild:sc];
    return cs;
}

//we also can not to write it,because it has already implemented in libs
+(id)node{
    return [[[[self class]alloc]init]autorelease];
}


-(id) init{
    self=[super init];
    if(self){
        CGSize screenSize=[[CCDirector sharedDirector] winSize];
        CCSprite* background=[CCSprite spriteWithFile:@"startbg.png"];
        [background setPosition:ccp(screenSize.width/2.0f, screenSize.height/2)];
        [self addChild:background];
        
        CCSprite* ablogo=[CCSprite spriteWithFile:@"angrybird.png"];
        [ablogo setPosition:ccp(240.0f,250.0f)];
        [self addChild:ablogo];
        
        //add menu
        CCSprite *start=[CCSprite spriteWithFile:@"start.png"];
        //create a menuitem, add sprite in it, normal:start, select:nill
        //when click menuitem, call startGame: method in self
        CCMenuItemSprite *startMenu= [CCMenuItemSprite itemFromNormalSprite:start selectedSprite:nil target:self selector:@selector(startGame:)];
        
        CCMenu *menu=[CCMenu menuWithItems:startMenu, nil];
        [menu setPosition:ccp(240.0f, 130.0f)];
        [self addChild:menu];
        
        //加定时器.run tick every second
        [self schedule:@selector(tick:) interval:1.0f];
    }
    return self;
}

-(void)startGame:(id) arg{
    NSLog(@"game begin!");
}

-(void)tick:(double)dt{
    [self createBird];
}

-(void)createBird{
    //create a bird
    CCSprite *bird=[[CCSprite alloc]initWithFile:@"bird1.png"];
    //给小鸟缩放比例
    [bird setScale:(arc4random()%10)/10.0f];
    
    //generate a random number 0~50
    [bird setPosition:ccp(50.0f+arc4random()%50, 70.0f)];
    // an actionJump to bird, actionTime:time
    CGPoint end=ccp(360.f+arc4random()%50, 70.0f);
    CGFloat height=arc4random()%100+50.0f;
    CGFloat time=2.0f;
    id actionJump=[CCJumpTo actionWithDuration:time position:end height:height jumps:1];
    
    //after jumping, make bird disapper on screen
    id finishAction=[CCCallFuncN actionWithTarget:self selector:@selector(finishAction:)];
    
    //make jump and finish sequentially run
    CCSequence* twoActions= [CCSequence actions:actionJump,finishAction, nil];
    
    [bird runAction:twoActions];
    [self addChild:bird];
    [bird release];
}

-(void)finishAction:(CCNode*) curNode{
    //once call this method, action finished; curNode is bird,just remove curNode
    //either method below is ok;
    //[self removeChild:curNode cleanup:YES];
    [curNode removeFromParentAndCleanup:YES];
}

@end
