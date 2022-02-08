//
//  RefrenceMacro.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#ifndef RefrenceMacro_h
#define RefrenceMacro_h

#if __has_feature(objc_arc)

#define BYWeak(x) __weak __typeof__(x) __weak_##x##__ = x;

#else

#define BYWeak(x) __block __typeof__(x) __block_##x##__ = x;

#endif

#if __has_feature(objc_arc)

#define BYStrong(x) __typeof__(x) x = __weak_##x##__;

#else

#define BYStrong(x) __typeof__(x) x = __block_##x##__;

#endif

#endif /* ReferenceMacro_h */
