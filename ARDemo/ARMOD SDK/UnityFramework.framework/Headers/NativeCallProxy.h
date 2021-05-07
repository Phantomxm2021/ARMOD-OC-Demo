//
//  NativeCallProxy.h
//  NativatePlugin
//
//  Created by NSWell on 2020/8/22.
//  Copyright © 2020 CellStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

// NativeCallsProtocol defines protocol with methods you want to be called from managed
@protocol NativeCallsProtocol

/*!
 @Discussion 出现异常将执行该方法
*/

- (void)throwException:(NSString *)message errorCode:(int) code;

/*!
 @Discussion 添加加载叠层
 */
@required
- (void)addLoadingOverlay;

- (void) updateLoadingProgress:(float) progress;

/*!
 @Discussion 移除加载叠层
 */
@required
- (void)removeLoadingOverlay;


/*!
 @Discussion 当不支持ARMOD时该方法将被执行
 */
@required
- (void)deviceNotSupport;

/*!
 @Discussion AR算法初始化完毕该方法将被执行
 */
@required
- (void)sdkInitialized;


/*!
 @url 要打开的URL
 */

@required
- (void)openBuiltInBrowser:(NSString *)url;


/*!
 @Discussion 启动识别
 */

@required
- (void)recognitionStart;


/*!
@Discussion 识别成功
 */

@required
- (void)recognitionComplete;

/*!
@Discussion 获取app信息
 */

@required
- (NSString* )tryAcquireInformation:(NSString*) opTag;

/*!
@Discussion 检测到包体积过大
 */

@required
- (void )packageSizeMoreThanPresetSize:(float) currentSize preset:(float) presetSize;

@end

__attribute__ ((visibility("default")))
@interface FrameworkLibAPI : NSObject
/*!
 @Discussion call it any time after ARMODLOAD to set object implementing NativeCallsProtocol methods
 在UnityFrameworkLoad之后随时调用它以设置实现NativeCallsProtocol方法的对象
 */
+(void) registerAPIforNativeCalls:(id<NativeCallsProtocol>) aApi;
@end
