//
//  Bird.m
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "Bird.h"

@implementation Bird
@synthesize isFly=_isFly,isReady=_isReady;

-(id)initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer<SpriteDelegate> *)layer{
    myLayer=layer;
    imageURL=@"bird";
    myWorld=world;
    self=[super initWithFile:[NSString stringWithFormat:@"%@1.png",imageURL]];
    
    self.tag=BIRD_ID;
    self.position=ccp(x, y);
    HP=10000;
    self.scale=0.3f;
    
    return self;
}


-(void) setSpeedX:(float)x andY:(float)y andWorld:(b2World*)world{
//    _world=world;
//    myWorld=world;
    
    //create a b2body for sprite
    b2BodyDef bodyDef;
    bodyDef.type=b2_dynamicBody;
    bodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
    bodyDef.userData=self;
    b2Body* body=world->CreateBody(&bodyDef);
    myBody=body;
    
    //create a fixture based on physical attribute
    b2CircleShape shape;
    shape.m_radius=5.0f/PTM_RATIO;
    b2FixtureDef fixtureDef;
    fixtureDef.shape=&shape;
    fixtureDef.density=80.0f;
    fixtureDef.friction=1.0f;
    fixtureDef.restitution=0.5f;
    body->CreateFixture(&fixtureDef);
    
    //给球的中心点一个力
    b2Vec2 force=b2Vec2(x,y);
    body->ApplyLinearImpulse(force, bodyDef.position);
    
}


@end
