//
//  ContactListener.h
//  AngryBirds
//
//  Created by xumeng on 17/5/8.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "cocos2d.h"
#import "SpriteBase.h"
#import "Bird.h"

class ContactListener: public b2ContactListener{
public:
    b2World* _world;
    CCLayer *_layer;

    ContactListener();
    ContactListener(b2World* w, CCLayer* c);
    ~ContactListener();
    
    virtual void BeginContact(b2Contact* contact);
    virtual void EndContact(b2Contact* contact);
    virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
    virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
    
};
