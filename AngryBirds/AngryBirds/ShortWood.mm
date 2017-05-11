//
//  ShortWood.m
//  AngryBirds
//
//  Created by xumeng on 17/5/10.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "ShortWood.h"

@implementation ShortWood

-(id)initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer<SpriteDelegate> *)layer{
    myWorld = world;
    myLayer = layer;
    imageURL = @"shortwood";
    
    HP = 27;
    fullHP = HP;
    self=[super initWithFile:[NSString stringWithFormat:@"%@1.png",imageURL]];
    
    //    self = [self initWithFile:[NSString stringWithFormat:@"%@1.png",imageURL]];
    self.position = ccp(x, y);
    self.tag = SHORTWOOD_ID;
    float scale = 2;
    self.scale = scale/10;
    
    // Create ball body
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(x/PTM_RATIO, y/PTM_RATIO);
    ballBodyDef.userData = self;
    
    b2Body * ballBody = world->CreateBody(&ballBodyDef);
    
    //Create block shape
    b2PolygonShape blockShape;
    blockShape.SetAsBox(self.contentSize.width/11/PTM_RATIO,self.contentSize.height/11/PTM_RATIO);
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &blockShape;
    ballShapeDef.density = 10.0f;
    ballShapeDef.friction = 3.0f;
    ballShapeDef.restitution = 0;
    ballBody->CreateFixture(&ballShapeDef);
    
    return self;
}



@end
