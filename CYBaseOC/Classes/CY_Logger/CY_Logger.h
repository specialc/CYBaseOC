//
//  CY_Logger.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *
 * 功能说明
 * 与StarConsoleLink相关联的日志输出头文件
 *
 * 使用文档
 * NSLog();         -- 相当于LogInfo();
 * LogInfo();       -- 打印信息，黑色
 * LogDebug();      -- 打印Debug，蓝色
 * LogWarning();    -- 打印警告，黄色
 * LogError();      -- 打印错误，红色
 * LogSuccess();    -- 打印成功，绿色
 * LogFailure();    -- 打印失败，红色
 * LogAsset();      -- 打印错误拦，截暂时还没做好
 * LogBackTrace();  -- 打印堆栈情况
 *
 */

#ifndef CY_Logger_h
#define CY_Logger_h


#define CY_Debug DEBUG        // DEBUG环境下使用
#define CY_XCodeColors    1   // 开关颜色
#define CY_BackTrace      0   // 开关方法调用栈输出
#define CY_BackTraceDepth 8   // 栈深度


//#define XCode_Colors_Escape "\033["
//#define XCode_Colors_Escape_BG "\033[bg"
#define XCode_Colors_Escape_FG "\033[fg"

//#define XCode_Colors_Reset "\033[;"
//#define XCode_Colors_Reset_BG "\033[bg;"
#define XCode_Colors_Reset_FG "\033[fg;"


#define NSLogColor "22,22,22" // 黑色
#define NSLogTitle "Info"

#define InfoColor "22,22,22" // 黑色
#define InfoTitle "Info"

#define DebugColor "28,0,207" // 蓝色
#define DebugTitle "Debug"

#define WarningColor "218,130,53" // 黄色
#define WarningTitle "Warning"

#define ErrorColor "196,26,22" // 红色
#define ErrorTitle "Error"

#define SuccessColor "0,116,0" // 绿色
#define SuccessTitle "Success"

#define FailureColor "196,26,22" // 红色
#define FailureTitle "Failure"

#define AssertColor "196,26,22" // 红色
#define AssertTitle "Assert"

#define BackTraceColor "22,22,22" // 黑色
#define BackTraceTitle "BackTrace"


#if CY_Debug /* Debug Begin */

#if CY_XCodeColors != 0 /* Color Begin */

//
#define PrivateLog(color, title, stack, format, ...)\
printf("%s%s;<%s> [%s][%s:%d] %s %s %s\n",\
XCode_Colors_Escape_FG,\
color,\
cc_current_time(),\
title,\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
__LINE__,\
[[NSString stringWithFormat:format,##__VA_ARGS__] UTF8String],\
XCode_Colors_Reset_FG,\
cc_back_trace(stack, CY_BackTraceDepth)\
)\

// NSLog
#define NSLog(format, ...) \
PrivateLog(NSLogColor, NSLogTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Information
#define LogInfo(format, ...) \
PrivateLog(InfoColor, InfoTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Debug
#define LogDebug(format, ...) \
PrivateLog(DebugColor, DebugTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Warning
#define LogWarning(format, ...) \
PrivateLog(WarningColor, WarningTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Error
#define LogError(format, ...) \
PrivateLog(ErrorColor, ErrorTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Success
#define LogSuccess(format, ...) \
PrivateLog(SuccessColor, SuccessTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Failure
#define LogFailure(format, ...) \
PrivateLog(FailureColor, FailureTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Assert
#define LogAssert(condition, format, ...) \
PrivateLog(AssertColor, AssertTitle, CY_BackTrace, format, ##__VA_ARGS__);\
NSAssert(condition, format, ##__VA_ARGS__)

// LogBackTrace
#define LogBackTrace(format, ...) \
PrivateLog(BackTraceColor, BackTraceTitle, 1, format, ##__VA_ARGS__)\


#else /* Color Else */

#define PrivateLog(color, title, stack, format, ...)\
printf("<%s> [%s][%s:%d] %s %s\n",\
cc_current_time(),\
title,\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
__LINE__,\
[[NSString stringWithFormat:format,##__VA_ARGS__] UTF8String],\
cc_back_trace(stack, CY_BackTraceDepth)\
);\

// NSLog
#define NSLog(format, ...) \
PrivateLog(0, NSLogTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Information
#define LogInfo(format, ...) \
PrivateLog(0, InfoTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Debug
#define LogDebug(format, ...) \
PrivateLog(0, DebugTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Warning
#define LogWarning(format, ...) \
PrivateLog(0, WarningTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Error
#define LogError(format, ...) \
PrivateLog(0, ErrorTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Success
#define LogSuccess(format, ...) \
PrivateLog(0, SuccessTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Failure
#define LogFailure(format, ...) \
PrivateLog(0, FailureTitle, CY_BackTrace, format, ##__VA_ARGS__)

// Assert
#define LogAssert(condition, format, ...) \
PrivateLog(0, FailureTitle, CY_BackTrace, format, ##__VA_ARGS__);\
NSAssert(condition, format, ##__VA_ARGS__)

// Stack
#define LogBackTrace(format, ...) \
PrivateLog(0, BackTraceTitle, 1, format, ##__VA_ARGS__)\


#endif /* Color End*/
#else /* Debug Else */


#define PrivateLog(color, title, format, ...) while(0){}
#define NSLog(...) while(0){}
#define LogInfo(...) while(0){}
#define LogDebug(...) while(0){}
#define LogError(...) while(0){}
#define LogWarning(...) while(0){}
#define LogSuccess(...) while(0){}
#define LogFailure(...) while(0){}
#define LogAssert(condition, format, ...) while(0){}
#define LogBackTrace(...) while(0){}


#endif /* Debug End */


/* Function Begin */
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <execinfo.h>
#include <time.h>
#include <sys/timeb.h>

#define CY_Back_Trace_Buffer 4096
#define CY_Time_Buffer 255


//
static inline const char * cc_back_trace(int open, int depth) {
    if (!open) {
        return "";
    }
    
    static char cc_back_trace_str[CY_Back_Trace_Buffer];
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    memset(cc_back_trace_str, 0, CY_Back_Trace_Buffer * sizeof(char));
    strcat(cc_back_trace_str, "\n<BackTrace Begin>");
    for (int i = 1; i < frames; i++) {
        // if (strlen(star_back_trace_str) + strlen(strs[i]) + 16 > STAR_BACK_TRACE_BUFFER) break;
        strcat(cc_back_trace_str, "\n\t");
        strcat(cc_back_trace_str, strs[i]);
        if (i == depth) {
            break;
        }
    }
    strcat(cc_back_trace_str, "\n<End>");
    
    free(strs);
    strs = NULL;
    
    return cc_back_trace_str;
}

//
static inline const char * cc_current_time() {
    static char cc_time_str[CY_Time_Buffer];
    time_t rawtime;
    struct tm * timeinfo;
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    memset(cc_time_str, 0, CY_Time_Buffer * sizeof(char));
    strftime(cc_time_str, CY_Time_Buffer, "%Y-%m-%d %H:%M:%S", timeinfo);
    return cc_time_str;
}


/**
 * 如果需要用到毫秒，那就替换成下列函数好了
 */
static inline const char * cc_current_time_milli() {
    static char cc_time_str[CY_Time_Buffer];
    struct timeb timeinfo;
    ftime(&timeinfo);
    struct tm * second_timeinfo;
    second_timeinfo = localtime(&timeinfo.time);
    memset(cc_time_str, 0, CY_Time_Buffer * sizeof(char));
    strftime(cc_time_str, CY_Time_Buffer, "%Y-%m-%d %H:%M:%S", second_timeinfo);
    char millitm[16];
    sprintf(millitm, ".%03d", timeinfo.millitm);
    strcat(cc_time_str, millitm);
    return cc_time_str;
}

/* Function End */



#endif /* CY_Logger_h */
