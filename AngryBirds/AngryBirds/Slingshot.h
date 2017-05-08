//
//  Slingshot.h
//  AngryBirds
//
//  Created by xumeng on 17/5/7.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "CCSprite.h"

@interface Slingshot : CCSprite{
    CGPoint _startPoint1;
    CGPoint _startPoint2;
    CGPoint _endPoint;
}

@property(nonatomic,assign)CGPoint startPoint1;
@property(nonatomic,assign)CGPoint startPoint2;
@property(nonatomic,assign)CGPoint endPoint;



@end
