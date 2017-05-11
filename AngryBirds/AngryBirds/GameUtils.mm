//
//  GameUtils.m
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameUtils.h"

@implementation GameUtils
//@synthesize _isFinished=isFinished;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self =[super init];
    if(self){
        maxLevel=1;
    }
    return self;
}

+(NSString*) getFilePath{
    //get 通关succesfully 的文件
    
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SuccessLevel"];
}

-(int) readLevelFromFile{
    NSString* file=[[self class] getFilePath];
    NSString* s = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    if(s) return [s intValue];
    
    if(isFinished){
        if(currentlevel==maxLevel){
            return currentlevel+1;
        }else{
            return maxLevel;
        }
    }
    return maxLevel;
}

+(void) writeLevelToFiel:(int)level{
    //transfer integer to string
    NSString* s=[NSString stringWithFormat:@"%d",level];
    //取得要存放的文件
    NSString* file=[[self class] getFilePath];
    [s writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(void) unlock:(int)level when:(BOOL)finish{
    currentlevel=level;
    isFinished=finish;
    if(maxLevel<currentlevel) maxLevel=currentlevel;
    NSLog(@"maxLevel:%d currentlevel%d",maxLevel,currentlevel);
    
}



@end
