//
//  GameUtils.h
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"
@interface GameUtils : NSObject <LockDelegate>{
    int currentlevel;
    int maxLevel;
    BOOL isFinished;
}

//@property(nonatomic,assign)BOOL _isFinished;
-(id)init;
-(int) readLevelFromFile;
+(void) writeLevelToFiel:(int)level;
@end
