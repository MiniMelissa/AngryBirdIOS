//
//  GameScene.m
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameScene.h"

#define TOUCH_UNKNOW 0
#define TOUCH_SHOTBIRD 1
#define SLINGSHOT_POS CGPointMake(85, 125)

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
        
        //create slingshot 弹弓 5/7/2017
        CCSprite* leftshot=[CCSprite spriteWithFile:@"leftshot.png"];
        leftshot.position=ccp(85, 110);
        [self addChild:leftshot];
        
        CCSprite* rightshot=[CCSprite spriteWithFile:@"rightshot.png"];
        rightshot.position=ccp(85, 110);
        [self addChild:rightshot];
        
        
        slingshot=[[Slingshot alloc]init];
        slingshot.startPoint1=ccp(82, 130);
        slingshot.startPoint2=ccp(92, 128);
        slingshot.endPoint=SLINGSHOT_POS;
        slingshot.contentSize=CGSizeMake(480, 320);
        slingshot.position=ccp(240, 160);
        [self addChild:slingshot];
        
        
        //5/8/2017, we can check the definition of isTouchEnabled
        self.isTouchEnabled=YES;
        //add targeted  delegate
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        [self createWorld];
        
        //5/6/2017
        [self creatlevel];

    }
    
    return self;
}

-(void)createWorld{
    CGSize scSize=[[CCDirector sharedDirector] winSize];
    
    //y:-5.0 向下重力加速度
    b2Vec2 gravity;
    gravity.Set(0.0f, -5.0f);
    //true: no object is moving
    world = new b2World(gravity,true);
    
    //create a collision listener
    contactListener = new ContactListener(world,self);
    //set collision listener for world
    world->SetContactListener(contactListener);
    
    //create ground whose anchor point is (0,0)
    b2BodyDef groundDef;
    groundDef.position.Set(0, 0);
    //create a ground body 地板刚体
    b2Body *groundBody=world->CreateBody(&groundDef);
    
    //b2Fixture
    b2PolygonShape groundShape;
    //PTM_RATIO=32,每32points表示1米
    groundShape.SetAsEdge(b2Vec2(0,87/PTM_RATIO), b2Vec2(scSize.width/PTM_RATIO,87/PTM_RATIO));
    groundBody->CreateFixture(&groundShape,0);
    
    //启动定时器， 每1/60s 调一次tick
    [self schedule:@selector(tick:)];
}

-(void) tick:(ccTime)dt{
      //dt should be ccTime, cannot be double,otherwise bird can not fly
    //让世界往前模拟
  
    world->Step(dt, 8, 6);
    //更新cocos2d的界面
    for(b2Body *b=world->GetBodyList();b;b=b->GetNext()){
        if(b->GetUserData()!=NULL){
            //userdata表示每个刚体都可以存一些私有数据，一般放sprite
            //b2body 与sprite 一一对应
            SpriteBase* sb=(SpriteBase*) b->GetUserData();
            //物理坐标与cocos2d坐标不同，此处做变换
            sb.position=ccp(b->GetPosition().x*PTM_RATIO, b->GetPosition().y*PTM_RATIO);
            //把box2d中角度转换成cocos2d的角度
            sb.rotation=-1*CC_RADIANS_TO_DEGREES(b->GetAngle());
            
            //如果小鸟停止运动删除小鸟
        /*    if (sb.tag == BIRD_ID) {
                if (!b->IsAwake()) {
                    world->DestroyBody(b);
                    [sb destroy];
                }
            }
            //
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            if (sb.HP <= 0 || sb.position.x > winSize.width-20 || sb.position.y < 84) {
                world->DestroyBody(b);
                [sb destroy];
            }*/
            
        }
    }
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    //判断touch is among the range of currentBird
    touchStatus=TOUCH_UNKNOW;
    
    //get the touch position on screen
    CGPoint touchPosition= [self convertTouchToNodeSpace:touch];
    if(currentBird==nil) return NO;
    //get the area of current bird
    CGRect birdRect=currentBird.boundingBox;
    if(CGRectContainsPoint(birdRect, touchPosition)){
        touchStatus=TOUCH_SHOTBIRD;
        return YES;
    }
    return NO;
    
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    if(touchStatus==TOUCH_SHOTBIRD){
        //touch bird, we can pull slingshot
        //get the touch position
        CGPoint touchPosition=[self convertTouchToNodeSpace:touch];
        
        //set the postion of slingshot and bird as the touch position
        slingshot.endPoint=touchPosition;
        currentBird.position=touchPosition;
        
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    //放开slingshot,bird fly and slingshot recover
    CGPoint touchPosition=[self convertTouchToNodeSpace:touch];

    if(touchStatus==TOUCH_SHOTBIRD){
        slingshot.endPoint=SLINGSHOT_POS;
/*
        //calculate the ratio which decide the route bird fly,直线飞
        CGFloat r=[self getRatioFromPoint:touchPosition toPoint:SLINGSHOT_POS];
        CGFloat endx=300;
        CGFloat endy=endx*r+touchPosition.y;
        CGPoint desPoint=ccp(endx, endy);
        CCMoveTo *moveAction=[[CCMoveTo alloc] initWithDuration:1.0f position:desPoint];
        [currentBird runAction:moveAction];
        [moveAction release];
*/
        float x=(85.0f-touchPosition.x)*50/70.0f;
        float y=(125.0f-touchPosition.y)*50/70.0f;
        [currentBird setSpeedX:x andY:y andWorld:world];
        
        [birds removeObject:currentBird];
        currentBird=nil;
        //make next bird jump to slingshot
        [self performSelector:@selector(jump) withObject:nil afterDelay:1.0f];
        
    }
}


-(CGFloat) getRatioFromPoint:(CGPoint)p1 toPoint: (CGPoint)p2{
    return (p2.y-p1.y)/(p2.x-p1.x);
}

-(void)creatlevel{
    NSString *s = [NSString stringWithFormat:@"%d", currentlevel];
    NSString *path = [[NSBundle mainBundle] pathForResource:s ofType:@"data"];
    NSLog(@"path is %@", path);
    NSArray *spriteArray = [JsonParser getAllSprite:path];
    NSLog(@"count is : %d",(int)spriteArray.count);
//    b2World* world=NULL;
    for (SpriteModel *sm in spriteArray) {
//    for (JsonParser *sm in spriteArray) {

      /*  if(sm.tag==PIG_ID){
            CCSprite *pig= [[Pig alloc] initWithX:sm.x andY:sm.y andWorld:world  andLayer:self];
            NSLog(@"PIG: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);
            [self addChild:pig];
            NSLog(@"PIG: ");
            [pig release];
        }
        else if(sm.tag==ICE_ID){
            CCSprite *ice = [[Ice alloc] initWithX:sm.x andY:sm.y andWorld:world  andLayer:self];
            [self addChild:ice];
            NSLog(@"ICE: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);
            [ice release];

        }*/
        switch (sm.tag) {
            case PIG_ID:
            {
                CCSprite *pig= [[Pig alloc] initWithX:sm.x andY:sm.y andWorld:world  andLayer:self];
                NSLog(@"PIG: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);
                [self addChild:pig];
                NSLog(@"PIG: ");
                [pig release];
                break;
            }
            case ICE_ID:
            {
                CCSprite *ice = [[Ice alloc] initWithX:sm.x andY:sm.y andWorld:world  andLayer:self];
                [self addChild:ice];
                NSLog(@"ICE: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);

                [ice release];
                break;
            }
            default:
                break;
        }
    }
    CCSprite* pig=[[Pig alloc]initWithX:200 andY:93 andWorld:world andLayer:self];
//    NSLog(@"PIG: tag:%d,x:%f,y:%f",sm.tag,sm.x,sm.y);
    
    [self addChild:pig];
    [pig release];
    
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
