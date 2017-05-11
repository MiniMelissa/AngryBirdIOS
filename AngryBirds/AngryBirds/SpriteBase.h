//
//  SpriteBase.h
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#define PTM_RATIO 32
#define BIRD_ID 1
#define PIG_ID 2
#define ICE_ID 3
#define WOOD_ID 4
#define SHORTWOOD_ID 5

@protocol SpriteDelegate;

@interface SpriteBase: CCSprite
{
    float HP; //当前生命值
    float fullHP;//总生命值
    NSString* imageURL;//pic relative path
    CCLayer<SpriteDelegate>* myLayer;//which layer the sprite shoud be put on
    b2World* myWorld;
    b2Body* myBody;
}
@property (nonatomic,assign) float HP;
//construcotr
-(id)initWithX:(float)x andY:(float)y andWorld:(b2World*) world andLayer:(CCLayer<SpriteDelegate>*)layer;
-(void)destroy;
@end

@protocol SpriteDelegate <NSObject>
-(void) sprite:(SpriteBase*)sprite withScore:(int)score;
@end
