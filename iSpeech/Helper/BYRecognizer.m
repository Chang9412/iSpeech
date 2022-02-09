//
//  BYRecognizer.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import "BYRecognizer.h"
#import <Speech/Speech.h>
#import <FCFileManager.h>

@interface BYRecognizer ()<SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate>

@property (nonatomic, strong) SFSpeechRecognizer *recognizer;
@property (nonatomic, strong) SFSpeechRecognitionTask *task;

@end

@implementation BYRecognizer


- (instancetype)init {
    if (self = [super init]) {
        [self start];
    }
    return self;
}


- (SFSpeechRecognizer *)recognizer {
    if (_recognizer) {
        return _recognizer;
    }
    _recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[BYRecognizer supportedLocaled].firstObject];
    _recognizer.delegate = self;
    return _recognizer;
}

- (void)start {
    if (SFSpeechRecognizer.authorizationStatus != SFSpeechRecognizerAuthorizationStatusAuthorized) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            NSLog(@"%ld", status);
            if (status != SFSpeechRecognizerAuthorizationStatusAuthorized) {
            }
        }];
    }
}

- (void)recognitionWithUrl:(NSURL *)url  {
    if (!url) {
        return;
    }
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    request.shouldReportPartialResults = YES; // 实时翻译
//    [self.recognizer recognitionTaskWithRequest:request delegate:self];
    SFSpeechRecognitionTask *task = [self.recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            if ([self.delegate respondsToSelector:@selector(recognizerError:)]) {
                [self.delegate recognizerError:error];
            }
            return;
        }
        if ([self.delegate respondsToSelector:@selector(recognitionResult:finished:)]) {
            if (result && result.bestTranscription) {
                NSLog(@"%@", result.bestTranscription.formattedString);
                [self.delegate recognitionResult:result.bestTranscription.formattedString finished:result.final];
            }
        }
        
    }];
    self.task = task;
}

#pragma mark -

- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available {
    
}

#pragma mark -

- (void)speechRecognitionTaskWasCancelled:(SFSpeechRecognitionTask *)task {
    
}

- (void)speechRecognitionDidDetectSpeech:(SFSpeechRecognitionTask *)task {
    
}

- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didHypothesizeTranscription:(SFTranscription *)transcription {
    
}

- (void)speechRecognitionTaskFinishedReadingAudio:(SFSpeechRecognitionTask *)task {
    
}

- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition:(SFSpeechRecognitionResult *)recognitionResult {
    
}

- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishSuccessfully:(BOOL)successfully {
    
}

+ (BOOL)supportedFile:(NSString *)file {
    static NSSet *set;
    if (!set) {
        NSMutableSet *aset = [NSMutableSet set];
        [aset addObject:@"mp3"];
        [aset addObject:@"wav"];
        [aset addObject:@"m4a"];
        set = aset;
    }
    return [set containsObject:file];
}

+ (NSArray *)supportedLocaled {
    return @[[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"],
            [NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSString *)fileDirectory {
    NSString *dir = [[FCFileManager pathForCachesDirectory] stringByAppendingString:@"/Input"];
    if (![FCFileManager isDirectoryItemAtPath:dir]) {
        [FCFileManager createDirectoriesForPath:dir];
    }
    return dir;
}

@end
