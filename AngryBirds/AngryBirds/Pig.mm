//
//  Pig.m
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "Pig.h"

@implementation Pig

-(id)initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer<SpriteDelegate> *)layer{
    myWorld = world;
    imageURL=@"pig";
    myLayer = layer;
    
    self=[super initWithFile:[NSString stringWithFormat:@"%@1.png",imageURL]];

    self.position = ccp(x, y);
    self.tag = PIG_ID;
    HP = 1;
    float scale = 2;
    self.scale = scale/10;
    
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(x/PTM_RATIO, y/PTM_RATIO);
    ballBodyDef.userData = self;
    
    b2Body * body = world->CreateBody(&ballBodyDef);
    myBody = body;
    
    b2CircleShape shape;
    shape.m_radius=5.0f/PTM_RATIO;
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &shape;
    ballShapeDef.density = 80.0f;
    ballShapeDef.friction = 80.0f; // We don't want the ball to have friction!
    ballShapeDef.restitution = 0.15f;
    body->CreateFixture(&ballShapeDef);

    
    return self;
}

@end
