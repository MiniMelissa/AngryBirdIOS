//
//  ContactListener.m
//  AngryBirds
//
//  Created by xumeng on 17/5/8.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "ContactListener.h"

ContactListener::ContactListener(){
    
}

ContactListener::ContactListener(b2World* w, CCLayer* c){
    _world=w;
    _layer=c;
}

ContactListener::~ContactListener(){
    
}


void ContactListener:: BeginContact(b2Contact* contact){
    
}
void ContactListener:: EndContact(b2Contact* contact){
    
}
void ContactListener:: PreSolve(b2Contact* contact, const b2Manifold* oldManifold){
    
}
void ContactListener:: PostSolve(b2Contact* contact, const b2ContactImpulse* impulse){
    //solver 计算完成后调用的函数
    //取冲量
    float force = impulse->normalImpulses[0];
    if(force>2){
        //contact includes A and B
        SpriteBase *spriteA=(SpriteBase*) contact->GetFixtureA()->GetBody()->GetUserData();
        SpriteBase *spriteB=(SpriteBase*) contact->GetFixtureB()->GetBody()->GetUserData();
        if(spriteA && spriteB){
            if(spriteA.tag==BIRD_ID){
                Bird* bird=(Bird*)spriteA;
                [bird hitAnimationX:bird.position.x andY:bird.position.y];
            }else{
                [spriteA setHP:spriteA.HP-force];
            }
            if(spriteB.tag==BIRD_ID){
                Bird* bird=(Bird*)spriteB;
                [bird hitAnimationX:bird.position.x andY:bird.position.y];
            }else{
                [spriteB setHP:spriteB.HP-force];
            }
        }
    }
    
}

