//
//  IPOperation.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import "IPOperation.h"

@implementation IPOperation

+ (NSArray *)operationsForRecorder {
    NSMutableArray *marray = [NSMutableArray array];
    {
        IPOperation *op = [[IPOperation alloc] init];
        op.title = @"开始录音";
        op.image = @"";
        op.type = IPOperationTypeRecorder;
        [marray addObject:op];
    }
    {
        IPOperation *op = [[IPOperation alloc] init];
        op.title = @"外部音频导入";
        op.image = @"";
        op.type = IPOperationTypeInput;
        [marray addObject:op];
    }
    {
        IPOperation *op = [[IPOperation alloc] init];
        op.title = @"文字转音频";
        op.image = @"";
        op.type = IPOperationTypeTextToAudio;
        [marray addObject:op];
    }
    
    return marray;
}

+ (NSArray *)operationsForAudio {
    NSMutableArray *marray = [NSMutableArray array];
    {
        IPOperation *op = [[IPOperation alloc] init];
        op.title = @"视频提取音频";
        op.image = @"";
        op.type = IPOperationTypeVideoToAudio;
        [marray addObject:op];
    }
    {
        IPOperation *op = [[IPOperation alloc] init];
        op.title = @"视频提取文字";
        op.image = @"";
        op.type = IPOperationTypeRecorder;
        [marray addObject:op];
    }
    {
        IPOperation *op = [[IPOperation alloc] init];
        op.title = @"音频合并";
        op.image = @"";
        op.type = IPOperationTypeRecorder;
        [marray addObject:op];
    }
    
    return marray;
}
@end
