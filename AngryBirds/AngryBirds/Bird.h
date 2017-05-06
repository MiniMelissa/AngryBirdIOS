//
//  Bird.h
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpriteBase.h"

@interface Bird : SpriteBase{
    BOOL _isFly;
    BOOL _isReady;
}

@property(nonatomic,assign)BOOL isFly;
@property(nonatomic,assign)BOOL isReady;
@end
