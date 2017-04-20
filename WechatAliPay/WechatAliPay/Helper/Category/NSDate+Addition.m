//
//  NSDate+Addition.m
//  Teshehui
//
//  Created by ChengQian on 13-11-17.
//  Copyright (c) 2013年 Charse. All rights reserved.
//

#import "NSDate+Addition.h"

#define DateFormat			@"yyyy-MM-dd"
#define TimeFormat			@"MM-dd HH:mm:ss"
#define FullFormat          @"yyyy-MM-dd HH:mm:ss"
#define LocalFormat          @"MM月dd日"

#define CALENDAR_YMDHM_FLAGS               (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute)

static NSDateFormatter *df;

@implementation NSDate (Addition)

+ (NSDateFormatter *)dateformatter
{
    if (!df) {
        df = [[NSDateFormatter alloc] init];
    }
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    return df;
}

+ (NSString*)stringFromDate:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *f = [[self class] dateformatter];
    [f setDateFormat:format];
    return [f stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString*)string format:(NSString*)format
{
    if (!string)
    {
        return nil;
    }
    
    NSDateFormatter *f = [[self class] dateformatter];
    [f setDateFormat:format];
    return [f dateFromString:string];
}

+ (NSDate*)dateFromString:(NSString *)string
{
    return [[self class] dateFromString:string format:DateFormat];
}

+ (NSDate *)dateFromString:(NSString *)string withFormate:(NSString *)formate
{
    return [[self class] dateFromString:string format:formate];
}

+ (NSString*)nowDataToString
{
    return [[self class] stringFromDate:[NSDate date]
                                 format:FullFormat];
}

- (NSString *)timeDescription
{
    return [[self class] stringFromDate:self
                                 format:DateFormat];
}

- (NSString *)localDescription
{
    return [[self class] stringFromDate:self
                                 format:LocalFormat];
}

- (NSString *)hoursDescription
{
    return [[self class] stringFromDate:self
                                 format:TimeFormat];
}

- (NSString *)timeDescriptionFull
{
    return [[self class] stringFromDate:self
                                 format:FullFormat];
}

- (NSString*)toStringWithFormat:(NSString*)format
{
    return [[self class] stringFromDate:self format:format];
}

- (NSUInteger)getWeekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    return [weekdayComponents weekday];
}

- (NSUInteger)getYears
{
    NSCalendar* chineseClendar = [NSCalendar currentCalendar];
    NSDateComponents *targetCom = [ chineseClendar components:NSCalendarUnitYear fromDate:self];
    
    return [targetCom year];
}

- (NSUInteger)getMonth
{
    NSCalendar* chineseClendar = [NSCalendar currentCalendar];
    NSDateComponents *targetCom = [ chineseClendar components:NSCalendarUnitMonth fromDate:self];
    
    return [targetCom month];
}

- (NSUInteger)getDay
{
    NSCalendar* chineseClendar = [NSCalendar currentCalendar];
    NSDateComponents *targetCom = [ chineseClendar components:NSCalendarUnitDay fromDate:self];
    
    return  [targetCom day];
}

- (NSUInteger)getIntervalOtherDate:(NSDate *)other
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags
                                           fromDate:self
                                             toDate:other
                                            options:0];
    return [comps day];
}


- (NSString *)formatDateToAvatar
{
    return [[self class] stringFromDate:self
                                 format:@"MM-dd HH:mm"];
}

- (NSArray *)timeFullSection
{
    NSString *time = [[self class] stringFromDate:self
                                           format:@"yyyy:MM:dd:HH:mm:ss"];
    if ([time length] > 0)
    {
        return [time componentsSeparatedByString:@":"];
    }
    
    return nil;
}


- (NSString *)formatDateToViewShow;
{
    NSDate *currTime = [NSDate date];
    
    NSCalendar* chineseClendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    //NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:date toDate:startDate options:0];
    NSDateComponents *targetCom = [ chineseClendar components:unitFlags fromDate:self];
    NSDateComponents *NowCom = [ chineseClendar components:unitFlags fromDate:currTime];
    
    NSInteger diffDay  = [NowCom day]-[targetCom day];
    NSInteger diffmonth  = [NowCom month]-[targetCom month];
    NSInteger diffYear = [NowCom year]-[targetCom year];
    NSInteger diffMinute = [NowCom minute]-[targetCom minute];
    NSInteger diffHour = [NowCom hour] - [targetCom hour];
    NSString *returnText = nil;
    if (diffYear >= 1)
    {
        returnText = [[self class] stringFromDate:self
                                           format:@"yy-MM-dd"];
    }
    else
    {
        if (!(diffmonth+diffDay))//一天之内
        {
            if (diffHour <= 0 && diffMinute < 5)
            {
                returnText = @"刚刚";
            }
            else if (diffHour <= 0 && diffMinute <= 30)
            {
                returnText = [NSString stringWithFormat:@"%ld分钟前", (long)diffMinute];
            }
            else
            {
                returnText = [[self class] stringFromDate:self
                                                   format:@"今天 HH:mm"];
            }
        }
        else if (!diffmonth && 1 == diffDay)
        {
            returnText = [[self class] stringFromDate:self
                                               format:@"昨天 HH:mm"];
        }
        else
        {
            returnText = [[self class] stringFromDate:self
                                               format:@"MM-dd HH:mm"];
        }
    }
    
    return returnText;
}

//人人返回的时间格式为yyyy-MM-dd HH:mm:ss或者yyyy-mm-dd hh:mm
+ (NSDate *)formateDateWithString:(NSString *)str
{
    NSUInteger cnt = [[[[str componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"] count];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    //yyyy-MM-dd HH:mm:ss
    if(3 == cnt)
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    yyyy-mm-dd hh:mm
    else
        [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formater dateFromString:str];
}

- (BOOL)isSameDay:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear;
    NSDateComponents *curr = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *user = [calendar components:unitFlags fromDate:self];
    
    return curr.year == user.year;
    
}

- (BOOL)isThisMonth;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *curr = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *user = [calendar components:unitFlags fromDate:self];
    
    return (curr.year == user.year) && (curr.month == user.month);
}


//------------------------------------------------------------------------------
//  时间字符串（2016-05-06 12:25:36）转化为时间戳
//------------------------------------------------------------------------------
+(NSString *)timeStampTurnToString:(NSString *)dateStr {
    
    NSDate *date =[NSDate formateDateWithString:dateStr];
    
    NSString *timeStamp =[NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeStamp;
    
    
}

//------------------------------------------------------------------------------
//  时间戳转化为时间格式
//  paramsKind:
//@"/":表示2016/05/06 12:25
//@"-":表示2016-05-06 12:25
//------------------------------------------------------------------------------
// time 目前是秒
+(NSString *)IntervalToDateString:(long long)time andParms:(NSString *)paramsKind{
    NSCalendar *cal     = [NSCalendar currentCalendar];
    NSDate *date        = [NSDate dateWithTimeIntervalSince1970:time];
//    NSDate *date        = [NSDate dateWithTimeIntervalSince1970:(time / 1000)];

    NSDateComponents *comp = [cal components:CALENDAR_YMDHM_FLAGS fromDate:date];
//    return [NSString stringWithFormat:@"%ld-%ld-%ld",(long)comp.year,(long)comp.month,(long)comp.day];
    if([paramsKind isEqualToString:@"/"]) {
        return [NSString stringWithFormat:@"%04ld/%02ld/%02ld %02ld:%02ld",(long)comp.year,(long)comp.month,(long)comp.day,(long)comp.hour,(long)comp.minute];
    }
    return [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld",(long)comp.year,(long)comp.month,(long)comp.day,(long)comp.hour,(long)comp.minute];
    
}

@end
