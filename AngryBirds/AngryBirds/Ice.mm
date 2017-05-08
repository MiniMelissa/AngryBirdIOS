//
//  Ice.m
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "Ice.h"

@implementation Ice
-(id)initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer<SpriteDelegate> *)layer{
    myWorld = world;
    myLayer = layer;
    imageURL = @"ice";
    
    HP = 27;
    fullHP = HP;
    self=[super initWithFile:[NSString stringWithFormat:@"%@2.png",imageURL]];

//    self = [self initWithFile:[NSString stringWithFormat:@"%@1.png",imageURL]];
    self.position = ccp(x, y);
    self.tag = ICE_ID;
    float scale = 2;
    self.scale = scale/10;

    return self;
}

@end
