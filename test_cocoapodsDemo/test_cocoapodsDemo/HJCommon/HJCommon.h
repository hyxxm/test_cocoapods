//
//  HJCommon.h
//  thrallplus
//
//  Created by HeJia on 16/6/21.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#ifdef MAC
#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
#else
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif


@interface HJCommon : NSObject

@end

/**
 *  动态创建
 *
 *  @param name 类名
 *
 *  @return 如果创建成功，返回实例，否则返回空
 */
extern id dynamicCreate(NSString* name);

/**
 *  获取app版本号
 *
 *  @return app版本号：如：3.01
 */
extern NSString* appVersion();

extern NSString* bulidVersion();

/**
 *  是否是全数字
 *
 *  @param number 需要检验的字符串
 *
 *  @return yes 就是全是字符，no 含有其它字符
 */
extern bool validateNumber(NSString* number);


#ifdef MAC
extern NSObject<NSApplicationDelegate>* appDelegate();
#else
/**
 *  返回appDelegate实例
 *
 *  @return 当前 appdelegate 实例
 */
extern NSObject<UIApplicationDelegate>* appDelegate();
#endif


#define __LazyCreate(property_name,class) \
-(class *)property_name{ \
    if(_##property_name == nil){ \
        _##property_name = [class new]; \
    }  \
    return _##property_name; \
}


#define __LazyCreateViewController(property_name , class) \
-(class *)property_name{ \
    if(_##property_name == nil){ \
        _##property_name = (class *)createViewController(@#class); \
    }  \
    return _##property_name; \
}

//! 输出，断言 仅在debug模式下有效
#ifdef DEBUG
#define HJLog(format,...) NSLog(format,##__VA_ARGS__)
#define HJAssert(condition, desc, ...) NSAssert(condition,desc,##__VA_ARGS__)
#else
#define HJLog(format,...)
#define HJAssert(condition, desc, ...)
#endif


/**
 *  校验手机号
 *
 *  @param mobile 手机号
 *
 *  @return 是否有效
 */
extern bool validateMobile(NSString *mobile);

/**
 *  通过时间秒数获得时间文字，用于倒计时。 返回格式： 00时00分00秒
 *
 *  @param time 时间秒数
 *
 *  @return 时间文字
 */
extern NSString* timeFromTimeInterval(NSTimeInterval time);

/**
 *  通过时间秒数获得时间文字，用于倒计时。 返回格式： 00:00:00
 *
 *  @param time 时间秒数
 *
 *  @return 时间文字
 */
extern NSString* timeFromTimeIntervalOtherKind(NSTimeInterval time);

/**
 *  通过时间戳获得时间文字，用于倒计时。返回格式yyyy-MM-dd
 *
 *  @param time 时间戳
 *
 *  @return 时间
 */
extern NSString* dateFromTimeInterval(NSTimeInterval time);

/**
 *  通过时间戳获得时间文字，用于倒计时。返回格式yyyy.MM.dd
 *
 *  @param time 时间戳
 *
 *  @return 时间
 */
extern NSString* dateFromTimeIntervalOtherKind(NSTimeInterval time);

/**
 *  通过时间戳获得时间文字，用于倒计时。返回格式：yyyy-MM-dd hh:mm:ss
 *
 *  @param time 时间戳
 *
 *  @return 时间
 */
extern NSString* dateTimeFromTimeInterval(NSTimeInterval time);

/**
 *  通过时间戳获得时间文字，用于倒计时。返回格式：yyyy-MM-dd hh:mm
 *
 *  @param time 时间戳
 *
 *  @return 时间
 */
extern NSString* dateTimeNoSecondFromTimeInterval(NSTimeInterval time);

extern NSTimeInterval getCurTimeInterval();

extern NSTimeInterval getRoundCurTimeInterval();

/**
 *  从url的query中读取字典格式的参数表
 *
 *  @param url url地址
 *
 *  @return 参数表
 */
extern NSDictionary<NSString *,NSString *> *urlQuery(NSURL *url);


//extern void freeTable(UITableView *tb);
//
//
//extern void freeCollectionView(UICollectionView *collectionView);


/**
 *  给定金额的值，返回金额的格式化后的形态 如：13500 格式化后返回13.5万，默认向上取整
 *
 *  @param 金额数值
 *  @param 保留几位小数
 *
 *  @return 格式化后的数值
 */
extern NSString *moneyFormat(CGFloat money,short decimal);

/**
 *  给定金额的值，返回金额的格式化后的形态 如：13500 格式化后返回13.5万，默认向上取整
 *
 *  @param 金额数值
 *  @param 保留几位小数
 *  @param 取整方式. 0 = 四舍五入，1 = 向下取整，2 = 向下取整
 *
 *  @return 格式化后的数值
 */
extern NSString *moneyFormat1(CGFloat money,short decimal,short mode);


typedef NS_ENUM(NSUInteger, DeviceModel) {
    DM_iPhone2G = 1,
    DM_iPhone3G,
    DM_iPhone3GS,
    DM_iPhone4,
    DM_iPhone4S,
    DM_iPhone5,
    DM_iPhone5C,
    DM_iPhone5S,
    DM_iPhone6,
    DM_iPhone6Plus,
    DM_iPhone6s,
    DM_iPhone6sPlus,
    DM_iPhoneSE,
    DM_iPhone7,
    DM_iPhone7Plus,
    DM_UNKONW
};

extern DeviceModel getCurrentDeviceModel();

extern NSString *deviceID();


#define weak(A) __weak typeof(A) w_##A = A;






