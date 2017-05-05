//
//  GameUtils.h
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameUtils : NSObject

+(int) readLevelFromFile;
+(void) writeLevelToFiel:(int)level;
@end
