//
//  ParticalManager.m
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "ParticalManager.h"

static ParticalManager* s;
@implementation ParticalManager

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id) sharedParticalManager{
    if(s==nil){
        s=[[ParticalManager alloc]init];
    }
    return s;
}

-(CCParticleSystem*) particalWithType:(ParticalType)type{
    CCParticleSystem* sys=nil;
    switch (type) {
        case ParticalSnow:
        {
            //get partical object of snow
            sys=[CCParticleSnow node];
            //transfer snow png to texture纹理,pic:30*30 ,<65 pixel
            CCTexture2D* t=[[CCTextureCache sharedTextureCache] addImage:@"snow.png"];
            [sys setTexture:t];
        }
            
            break;
            
        case ParticalBirdExplosion:
        {
            //use plist as partical file
            sys=[ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"bird-explosion.plist"];
            //设置粒子效果独立性
            [sys setPositionType:kCCPositionTypeFree];
            //after finishing explosion, remove
            [sys setAutoRemoveOnFinish:YES];
        }
            
        default:
            break;
    }
    return sys;
}

@end
