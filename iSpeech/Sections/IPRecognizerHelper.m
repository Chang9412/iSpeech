//
//  IPRecognizerHelper.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/11.
//

#import "IPRecognizerHelper.h"
#import "IPRecordViewController.h"
#import "BYRecognizer.h"
#import "UIViewController+Utils.h"
#import <FCFileManager.h>

@implementation IPRecognizerHelper

+ (BOOL)openUrl:(NSURL *)url {
    
    if (![BYRecognizer supportedFile:url.pathExtension]) {
        return NO;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *path = [[BYRecognizer fileDirectory] stringByAppendingPathComponent:url.lastPathComponent];
    BOOL isWrited = [data writeToFile:path atomically:YES];
    if (!isWrited) {
        NSLog(@"failed");
        return NO;
    }
    // 删除Inbox 文件
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:url.relativePath error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    [self openRecognizerViewControllerWithUrl:[NSURL fileURLWithPath:path]];
    return YES;
}

+ (IPRecordViewController *)openRecorderViewController {
    IPRecordViewController *vc = [[IPRecordViewController alloc] initWithStyle:IPRecordViewControllerStyleRecorder url:nil];
    [[UIViewController topNavigationViewController] pushViewController:vc animated:YES];
    return vc;
}

+ (IPRecordViewController *)openRecognizerViewControllerWithUrl:(NSURL *)url {
    IPRecordViewController *vc = [[IPRecordViewController alloc] initWithStyle:IPRecordViewControllerStylePlayAudio url:url];
    [[UIViewController topNavigationViewController] pushViewController:vc animated:YES];
    return vc;
}



@end
