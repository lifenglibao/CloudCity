//
//  CustomBusMode.h
//  CloudCity
//
//  Created by iAPPS Pte Ltd on 26/04/16.
//  Copyright © 2016年 Youzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <MapKit/MapKit.h>

@interface CustomBusMode : NSObject
{
    
}

+(NSArray *)getGridTitle;
+(NSArray *)getTransferGridTitle;
+(NSArray *)getTransferFilterTitle;

+(UITextField*)setSearchTextFieldWithFrame:(CGRect)frame;
+(UIButton*)setGPSButtonWithTitle:(NSString *)title imageName:(NSString *)imageName CGRect:(CGRect)frame target:(id)tar action:(SEL)ac;
+(UIView*)setTrafficButtonWithTitle:(NSString *)title imageName:(NSString *)imageName CGRect:(CGRect)frame target:(id)tar action:(SEL)ac;
+(UIView*)setZoomViewWithFrame:(CGRect)frame target:(id)tar action1:(SEL)ac1 action2:(SEL)ac2;

+ (NSString *)handleStringWithBrackets:(NSString *)str;
+ (NSString *)handleStringGetBrackets:(NSString *)str;
+ (NSString *)replaceStringWithBusModel:(NSString *)str;
+ (NSString *)getBusTimeFromString:(NSString *)string;
+ (NSString *)handleStringWithCharRoad:(NSString *)str;
+ (NSString *)getRoutePlanningBusStartStop:(NSArray *)array;
+ (NSString *)getRoutePlanningBusNumber:(NSArray*)array;
+ (NSString *)getRoutePlanningBusInfo:(AMapTransit *)transit;
+ (NSString *)handleStringWithHalfBrackets:(NSString *)str;
+ (NSMutableArray *)getRoutePlanningBusDetailLine:(AMapTransit *)transit;
+ (UIView *)locationServiceUnEnabled:(CGRect) frame;
+ (NSString *)handleStringIncludeBrackets:(NSString *)str;
+ (NSMutableAttributedString *) changeTextColorToRed :(NSString *)string withRange:(NSString *)subString;
+ (NSDictionary *)calculateNearestStopWithUserLocation:(CLLocationCoordinate2D )userLocation data:(NSArray *)array;

+ (void)cleanUpLocalFavoArray;
+ (void)deleteFavoed_withID:(NSString *)sid withFavoID:(NSString *)favoID forType:(CollcetionType)type;
+ (NSString *)getFavoIDFromID:(NSString *)fid forType:(CollcetionType)type;
+ (BOOL)addFavoed_withID:(NSString *)sid withFavoID:(NSString *)favoID forType:(CollcetionType) type;
+ (BOOL)isFavoed_withID:(NSString *)sid withFavoID:(NSString *)favoID forType:(CollcetionType)type;

+ (NSArray *)getFilterRoutePlanning:(NSArray*)array withParameter:(NSString*)par;
@end
