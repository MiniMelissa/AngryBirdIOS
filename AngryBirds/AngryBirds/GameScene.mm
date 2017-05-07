//
//  GameScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameScene.h"
#import "JsonParser.h"

@implementation GameScene

+(id)scene{
    CCScene* cs=[CCScene node];
    GameScene* gs=[[GameScene alloc]init];
    [cs addChild:gs];
    [gs release];
    return cs;
}

+(id) sceneWithLevel:(int)level{
    CCScene* cs=[CCScene node];
    GameScene* gs=[GameScene nodeWithLevel:level];
    [cs addChild:gs];
    return cs;
}

+(id) nodeWithLevel:(int)level{
    return [[[[self class]alloc]initWithLevel:level]autorelease];
}

-(id) initWithLevel:(int)level{
    self = [super init];
    if(self){
        currentlevel=level;
        //create background
        CCSprite* bg =[CCSprite spriteWithFile:@"bg.png"];
        CGSize winSize=[[CCDirector sharedDirector] winSize];
        bg.position=ccp(winSize.width/2, winSize.height/2);
        [self addChild:bg];
        
        //create score
        NSString* scoreStr=[NSString stringWithFormat:@"score %d",score];
        scoreLable = [[CCLabelTTF alloc] initWithString:scoreStr dimensions:CGSizeMake(300, 300) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:30];
        scoreLable.position=ccp(450, 170);
        [self addChild:scoreLable];
        
        //create slingshot 弹弓
        CCSprite* leftshot=[CCSprite spriteWithFile:@"leftshot.png"];
        leftshot.position=ccp(85, 110);
        [self addChild:leftshot];
        
        CCSprite* rightshot=[CCSprite spriteWithFile:@"rightshot.png"];
        rightshot.position=ccp(85, 110);
        [self addChild:rightshot];
        
        [self creatlevel];

    }
    
    return self;
}

-(void)creatlevel{
    NSString *s = [NSString stringWithFormat:@"%d", currentlevel];
    NSString* path=[[NSBundle mainBundle] pathForResource:s ofType:@"data"];
    NSLog(@"path: %@",path);
    NSArray* spArray= [JsonParser getAllSprite:path];
    NSLog(@"path: %d",(int)spArray.count);
    b2World * world=NULL;
    //pig and ice didnt show
    for(SpriteModel* sm in spArray){
        switch (sm.tag) {
            case PIG_ID:
            {
                CCSprite* pig=[[Pig alloc]initWithX:sm.x andY:sm.y andWorld:world andLayer:self];
                NSLog(@"PIG: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);

                [self addChild:pig];
                [pig release];
                break;
            }
            case ICE_ID:
            {
                CCSprite* ice=[[Ice alloc]initWithX:sm.x andY:sm.y andWorld:world andLayer:self];
                NSLog(@"ICE: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);

                [self addChild:ice];
                [ice release];
                break;
            }
            default:
                break;
        }
    }
//    CCSprite* pig=[[Pig alloc]initWithX:200 andY:93 andWorld:world andLayer:self];
//    NSLog(@"PIG: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);
    
//    [self addChild:pig];
//    [pig release];
    
    //bird can show
    birds= [[NSMutableArray alloc]init];
    Bird* bird1=[[Bird alloc]initWithX:160 andY:93 andWorld:world andLayer:self];
    Bird* bird2=[[Bird alloc]initWithX:140 andY:93 andWorld:world andLayer:self];
    Bird* bird3=[[Bird alloc]initWithX:120 andY:93 andWorld:world andLayer:self];
    [birds addObject:bird1];
    [birds addObject:bird2];
    [birds addObject:bird3];
    [self addChild:bird1];
    [self addChild:bird2];
    [self addChild:bird3];
    
    [bird1 release];
    [bird2 release];
    [bird3 release];
    
    [self jump];
}


-(void)jump{
    if(birds.count>0 && !gameFinish){
        currentBird =[birds objectAtIndex:0];
        CCJumpTo *action= [[CCJumpTo alloc] initWithDuration:1 position:ccp(85, 125) height:50 jumps:1];
        CCCallBlockN *jumpFinish=[[CCCallBlockN alloc]initWithBlock:^(CCNode *node) {
            gameStart=YES;
            currentBird.isReady=YES;
        }];
        CCSequence* allActions=[CCSequence actions:action,jumpFinish, nil];
        [action release];
        [jumpFinish release];
        [currentBird runAction:allActions];
    }
}

-(void) dealloc{
    [scoreLable release];
    [birds release];
    [super dealloc];
}


@end
