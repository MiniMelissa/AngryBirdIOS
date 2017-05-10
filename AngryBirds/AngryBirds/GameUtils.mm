//
//  GameUtils.m
//  AngryBirds
//
//  Created by xumeng on 17/5/5.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameUtils.h"

@implementation GameUtils

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(NSString*) getFilePath{
    //get 通关succesfully 的文件
    
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SuccessLevel"];
}

+(int) readLevelFromFile{
    NSString* file=[[self class] getFilePath];
    NSString* s = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    if(s) return [s intValue];
    return 2;
}

+(void) writeLevelToFiel:(int)level{
    //transfer integer to string
    NSString* s=[NSString stringWithFormat:@"%d",level];
    //取得要存放的文件
    NSString* file=[[self class] getFilePath];
    [s writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
