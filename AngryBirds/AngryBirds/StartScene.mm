//
//  StartScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/4.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "StartScene.h"
#import "ParticalManager.h"
#import "LevelScene.h"

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
        NSLog(@"start screen: x:%f,y:%f",screenSize.width,screenSize.height);
        
        //set background
        //levelbg:1280*800
        CCSprite* background=[CCSprite spriteWithFile:@"levelbg.png"];
        [background setPosition:ccp(screenSize.width/2.0f, screenSize.height/2)];
        NSLog(@"bg: x:%f, y:%f",background.contentSize.width,background.contentSize.height);
        [background setScaleX:0.52];
        [background setScaleY:0.47f];
        [self addChild:background];
        
        //set logo
        CCSprite* ablogo=[CCSprite spriteWithFile:@"ABNewLogo.png"];
        NSLog(@"ablogo: x:%f, y:%f",ablogo.contentSize.width,ablogo.contentSize.height);
        [ablogo setScale:0.3f];
        [ablogo setPosition:ccp(screenSize.width/2,310.0f)];
        [self addChild:ablogo];
        
        
        //add menu
        CCSprite *startPic=[CCSprite spriteWithFile:@"start.png"];
        [startPic setPosition:ccp(screenSize.width/2, screenSize.height/2-30)];
        [self addChild:startPic];
        
        CCSprite *start=[CCSprite spriteWithFile:@"play.png"];
        [start setScaleX:1.4];
        [start setScaleY:1.2];

        //create a menuitem, add sprite in it, normal:start, select:nill
        //when click menuitem, call startGame: method in self
        CCMenuItemSprite *startMenu= [CCMenuItemSprite itemFromNormalSprite:start selectedSprite:nil target:self selector:@selector(startGame:)];
        
        CCMenu *menu=[CCMenu menuWithItems:startMenu, nil];
        [menu setPosition:ccp(screenSize.width/2-30, screenSize.height/2-85)];
        [self addChild:menu];
        
        //加定时器.run tick every second
        [self schedule:@selector(tick:) interval:1.0f];
        
        
        //add snow partical
//        CCParticleSystem* snow=[[ParticalManager sharedParticalManager] particalWithType:ParticalSnow];
//        [self addChild:snow];
    }
    return self;
}

-(void)startGame:(id)arg{
    NSLog(@"game begin!");
    //start levelscene
    CCScene* level=[LevelScene scene];
    
    //give 5s to do splitcol transition to level
    //1.分竖条
//        CCTransitionScene* transScene=[[CCTransitionSplitCols alloc] initWithDuration:3.0f scene:level];
    //2.分横条
//    CCTransitionScene* transScene=[[CCTransitionSplitRows alloc] initWithDuration:3.0f scene:level];
    //3.雷达
//    CCTransitionScene* transScene=[[CCTransitionRadialCCW alloc] initWithDuration:3.0f scene:level];
    //4.小格子
//    CCTransitionScene* transScene=[[CCTransitionTurnOffTiles alloc] initWithDuration:3.0f scene:level];
    //5.below 上下左右滑动
    CCTransitionScene* transScene=[[CCTransitionSlideInB alloc] initWithDuration:0.5f scene:level];
    //6。
//        CCTransitionScene* transScene=[[CCTransitionFlipX alloc] initWithDuration:3.0f scene:level];
    //7.左上右下轴翻转
//        CCTransitionScene* transScene=[[CCTransitionZoomFlipAngular alloc] initWithDuration:3.0f scene:level];

    //director transfer to animation scene
//    [[CCDirector sharedDirector] replaceScene:transScene];
    [[CCDirector sharedDirector] replaceScene:transScene];

    [transScene release];
    
}

-(void)tick:(double)dt{
    [self createBird];
}

-(void)createBird{
    //create a bird
    CCSprite *bird=[[CCSprite alloc]initWithFile:@"bird1.png"];
    //给小鸟缩放比例
    [bird setScale:(arc4random()%9+1)/10.0f];
    
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
    //add bird explosion
    CCParticleSystem* birdExplosion=[[ParticalManager  sharedParticalManager]particalWithType:ParticalBirdExplosion];
    //keep the position of bird and the position of birdExplosion same
    [birdExplosion setPosition:[curNode position]];
    [self addChild:birdExplosion];
    
    //once call this method, action finished; curNode is bird,just remove curNode
    //either method below is ok;
    //[self removeChild:curNode cleanup:YES];
    [curNode removeFromParentAndCleanup:YES];
}

@end
