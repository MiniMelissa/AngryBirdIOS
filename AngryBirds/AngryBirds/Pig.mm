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
//    self = [super initWithFile:[NSString stringWithFormat:@"pig1.png"]];

    self.position = ccp(x, y);
    self.tag = PIG_ID;
    HP = 1;
    float scale = 2;
    self.scale = scale/10;
    
    return self;
}

@end
