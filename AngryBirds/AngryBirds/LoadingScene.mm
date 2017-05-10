//
//  LoadingScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/4.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "LoadingScene.h"

@implementation LoadingScene

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(id) scene{
//    create an empty scene(剧场)
    CCScene* sc= [CCScene node];
    // create a sub scene（节目）
    LoadingScene* ls=[LoadingScene node];
    //put ls into sc, return sc to system
    [sc addChild:ls];
    return sc;
}

//we can override node method
+(id)node{
    //check objc grammer to know why use autorelease
    //we still need override init method
    return [[[[self class] alloc] init ] autorelease];
}

-(id) init{
    
    //self is CCLayer
    self= [super init];
    if(self){
        //we need to get picture for screen
        //first, get width and height of screen
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        NSLog(@"loading screen: x:%f,y:%f",winSize.width,winSize.height);
        
        //sprite ->pic
        CCSprite *sp= [CCSprite spriteWithFile:@"ls.jpg"];
        NSLog(@"pic: x:%f, y:%f",sp.contentSize.width,sp.contentSize.height);
        
        //set anchor point
        [sp setAnchorPoint:ccp(0.0f, 0.0f)];
        [sp setPosition:ccp(0.0f, 0.0f)];
        //pic 480*320(5,5s,se) need to change to 667*375(6,6s,7)
//        [sp setScaleX:1.39f];
//        [sp setScaleY:1.17f];
        //pic: 1920*1080
//        [sp setScaleX:0.35f];
        [sp setScaleY:winSize.width/sp.contentSize.width];
        [sp setScale:winSize.height/sp.contentSize.height];
        
//        [sp setScale:1.3f];

        
//        CCSprite *sp= [CCSprite spriteWithFile:@"loading.png" rect:()];
        //set 重心坐标 ccp=CGPoint
//        [sp setPosition:ccp(winSize.width/2.0f, winSize.height/2.0f)];
        [self addChild:sp];
        
        
        //set logo
        CCSprite* ablogo=[CCSprite spriteWithFile:@"ABNewLogo.png"];
        NSLog(@"ablogo: x:%f, y:%f",ablogo.contentSize.width,ablogo.contentSize.height);
        [ablogo setScale:0.3f];
        [ablogo setPosition:ccp(winSize.width/2,310.0f)];
        [self addChild:ablogo];

        
        //initialize loadingtitle as "Loading" with font arial16
        loadingtitle = [[CCLabelBMFont alloc]initWithString:@"Loading" fntFile:@"arial16.fnt"];
        //set anchorpoint of string "Loading" 质心点
        [loadingtitle setAnchorPoint:ccp(0.0f, 0.0f)];
        //set position of anchorpoint
        [loadingtitle setPosition:ccp(winSize.width-100.0f, 10.0f)];
        
        [self addChild:loadingtitle];
        //让loading 每隔2s前进一个“.”, call [self loadTick:] method every 2s
        [self schedule:@selector(loadTick:) interval:1.0f];
        
    }
    return self;
}

-(void)loadTick:(double) t{
    //only call 4 times , mock scheduler. During the real scheduler-time,we need to read some real data.
    static int count;
    count++;
    //append "." to loadingtitle
    NSString *s= [NSString stringWithFormat:@"%@%@",[loadingtitle string],@"."];
    [loadingtitle setString:s];
    
    if(count>=4){
        //取消定时器。remove scheduler
        [self unscheduleAllSelectors];
        
        //transfer to another scene
        CCScene *cs =[StartScene scene];
        //desctroy original scene, run a new scene-cs
        [[CCDirector sharedDirector] replaceScene:cs];
    }
}

-(void) dealloc{
    [loadingtitle release];
    loadingtitle=nil;
    [super dealloc];
}

@end
