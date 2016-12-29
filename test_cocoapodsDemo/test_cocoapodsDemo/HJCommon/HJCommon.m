//
//  HJCommon.m
//  thrallplus
//
//  Created by HeJia on 16/6/21.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#import "HJCommon.h"
#import <objc/runtime.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation HJCommon

@end


#ifdef MAC
NSObject<NSApplicationDelegate>* appDelegate(){
    return [NSApplication sharedApplication].delegate;
}

#else
NSObject<UIApplicationDelegate>* appDelegate(){
    
    return [UIApplication sharedApplication].delegate;
}
#endif


id dynamicCreate(NSString* className){
    
    Class class = objc_getClass([className UTF8String]);
    if(class == nil) return nil;
    id instance = [class new];
    
    return instance;
}

NSString* appVersion(){
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

NSString* bulidVersion(){
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

#ifdef MAC
#else
NSString* deviceID(){
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
#endif

bool validateNumber(NSString* number) {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


bool validateMobile(NSString *mobile)
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,152,155,156,185,186,145,176
     * 电信：133,153,177,180,181,189
     */
    NSString * MOBILE = @"^[1][34578][0-9][0-9]{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
//    if (([regextestmobile evaluateWithObject:mobile] == YES)
//        || ([regextestcm evaluateWithObject:mobile] == YES)
//        || ([regextestct evaluateWithObject:mobile] == YES)
//        || ([regextestcu evaluateWithObject:mobile] == YES))
    if([regextestmobile evaluateWithObject:mobile] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


NSString *timeFromTimeInterval(NSTimeInterval time){
    NSString *string = [NSString stringWithFormat:@"%02li时%02li分%02li秒",
                        lround(floor(time / 3600)) % 100,
                        lround(floor(time / 60)) % 60,
                        lround(floor(time)) % 60];
    return string;
}

NSString *timeFromTimeIntervalOtherKind(NSTimeInterval time){
    NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li",
                        lround(floor(time / 3600)) % 100,
                        lround(floor(time / 60)) % 60,
                        lround(floor(time)) % 60];
    return string;
}

NSString *dateFromTimeInterval(NSTimeInterval time){
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;
}

extern NSString* dateFromTimeIntervalOtherKind(NSTimeInterval time){
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;
}

NSString* dateTimeFromTimeInterval(NSTimeInterval time){
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;
}

NSString* dateTimeNoSecondFromTimeInterval(NSTimeInterval time){
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;
}

NSTimeInterval getCurTimeInterval(){
    return [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970;
}

NSTimeInterval getRoundCurTimeInterval(){
    return lround(getCurTimeInterval());
}


NSDictionary<NSString *,NSString *> *urlQuery(NSURL *url){
    NSString *qry = [url query];
    NSArray *ary = [qry componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:ary.count];
    for (NSString *qry in ary) {
        NSArray *aryParam = [qry componentsSeparatedByString:@"="];
        dic[aryParam[0]] = aryParam[1];
    }
    
    return dic;
}

NSString *moneyFormat(CGFloat money,short decimal){
    return moneyFormat1(money, decimal, 2);
}

NSString *moneyFormat1(CGFloat money,short decimal,short mode){
    long nMoney = roundf(money);
    long base = pow(10,decimal);
    NSString *format = nil;
    CGFloat fMoney = 0;
    CGFloat fTmpMoney = 0;
    if(nMoney > 10000){
        format = [NSString stringWithFormat:@"%%.%df万元",decimal];
        fTmpMoney = nMoney/10000.0;
        
    }else{
        format = [NSString stringWithFormat:@"%%.%df元",decimal];
        fTmpMoney = money;
    }
    
    switch (mode) {
        case 0:
            fMoney = round(fTmpMoney *base)/base;
            break;
        case 1:
            fMoney = floor(fTmpMoney *base)/base;
            break;
        case 2:
            fMoney = ceil(fTmpMoney *base)/base;
            break;
        default:
            break;
    }

    
    NSString *strMoney = [NSString stringWithFormat:format,fMoney];
    return strMoney;
}


extern DeviceModel getCurrentDeviceModel(){
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return DM_iPhone2G;
    if ([platform isEqualToString:@"iPhone1,2"]) return DM_iPhone3G;
    if ([platform isEqualToString:@"iPhone2,1"]) return DM_iPhone3GS;
    if ([platform isEqualToString:@"iPhone3,1"]) return DM_iPhone4;
    if ([platform isEqualToString:@"iPhone3,2"]) return DM_iPhone4;
    if ([platform isEqualToString:@"iPhone3,3"]) return DM_iPhone4;
    if ([platform isEqualToString:@"iPhone4,1"]) return DM_iPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"]) return DM_iPhone5;
    if ([platform isEqualToString:@"iPhone5,2"]) return DM_iPhone5;
    if ([platform isEqualToString:@"iPhone5,3"]) return DM_iPhone5C;
    if ([platform isEqualToString:@"iPhone5,4"]) return DM_iPhone5C;
    if ([platform isEqualToString:@"iPhone6,1"]) return DM_iPhone5S;
    if ([platform isEqualToString:@"iPhone6,2"]) return DM_iPhone5S;
    if ([platform isEqualToString:@"iPhone7,2"]) return DM_iPhone6;
    if ([platform isEqualToString:@"iPhone7,1"]) return DM_iPhone6Plus;
    if ([platform isEqualToString:@"iPhone8,1"]) return DM_iPhone6s;
    if ([platform isEqualToString:@"iPhone8,2"]) return DM_iPhone6Plus;
    if ([platform isEqualToString:@"iPhone8,3"]) return DM_iPhoneSE;
    if ([platform isEqualToString:@"iPhone8,4"]) return DM_iPhoneSE;
    if ([platform isEqualToString:@"iPhone9,1"]) return DM_iPhone7;
    if ([platform isEqualToString:@"iPhone9,2"]) return DM_iPhone7Plus;
    
    return DM_UNKONW;
}



