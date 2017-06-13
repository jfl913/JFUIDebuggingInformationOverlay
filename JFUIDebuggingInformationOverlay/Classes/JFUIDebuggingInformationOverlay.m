//
//  JFUIDebuggingInformationOverlay.m
//  Pods
//
//  Created by junfeng.li on 2017/6/13.
//
//

#import "JFUIDebuggingInformationOverlay.h"

@implementation JFUIDebuggingInformationOverlay

+ (void)load {
#if DEBUG
    // Notification Once: http://blog.sunnyxx.com/2015/03/09/notification-once/
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    __block id observer = [defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                     object:nil
                                                      queue:nil
                                                 usingBlock:^(NSNotification * _Nonnull note) {
                                                     [self setupUIDebuggingInformationOverlay];
                                                     [[NSNotificationCenter defaultCenter] removeObserver:observer];
                                                 }];
#endif
}

/**
 * 双指点击手机状态栏可开启苹果自带的调试工具
 * You’ll need to include a value for the NSPhotoLibraryUsageDescription key in your Info.plist.
 * Tapping the ‘Add’ button presents a UIImagePickerController, and doing so without setting this value will cause your app to crash.
 * ⚠️：直接在load方法里调用无效，等应用启动后再调用
 */
+ (void)setupUIDebuggingInformationOverlay {
#if DEBUG
    Class uiDebuggingInformationOverlay = NSClassFromString(@"UIDebuggingInformationOverlay");
    if (uiDebuggingInformationOverlay) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [uiDebuggingInformationOverlay performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
#pragma clang diagnostic pop
    }
#endif
}

@end
