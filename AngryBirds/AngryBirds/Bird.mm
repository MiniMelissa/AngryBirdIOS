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

@end
