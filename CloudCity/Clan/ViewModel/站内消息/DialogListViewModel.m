//
//  DialogListViewModel.m
//  Clan
//
//  Created by 昔米 on 15/4/13.
//  Copyright (c) 2015年 Youzu. All rights reserved.
//

#import "DialogListViewModel.h"
#import "DialogListModel.h"
#import "NotificationModel.h"

@implementation DialogListViewModel

/*
 *  标记当前消息为已读
 */
- (void)readWarnListWithReturnBlockWithID:(NSString *)notificaction_id andReturnBlock:(void(^)(bool success, id data))block;
{
    WEAKSELF
    
    [[Clan_NetAPIManager sharedManager] read_WarnListWithID:notificaction_id andResultBlock:^(id data, NSError *error) {
        STRONGSELF
        if (error) {
            //错误
            [strongSelf showHudTipStr:NetError];
            block(NO, nil);
            return ;
        }
        else {
            block(YES,nil);
        }
        
    } ];
}

/**
 * 获取未读提醒
 */
- (void)requestUnReadWarnListWithReturnBlock:(void(^)(bool success, id data))block
{
    WEAKSELF
    [[Clan_NetAPIManager sharedManager] request_UnReadWarnListWithResultBlock:^(id data, NSError *error) {
        STRONGSELF
        if (error) {
            //错误
            [strongSelf showHudTipStr:NetError];
            block(NO, nil);
            return ;
        }
        else {
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"NotificationCount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GET_UNREAD_NOTIFICATION_COUNT" object:nil];
            block(YES,data);
        }
        
    } ];
}

/**
 * 提醒列表
 */
- (void)requestWarnListWithReturnBlock:(void(^)(bool success, id data))block
{
    WEAKSELF
    [[Clan_NetAPIManager sharedManager] request_WarnListWithResultBlock:^(id data, NSError *error) {
        STRONGSELF
        if (error) {
            //错误
            [strongSelf showHudTipStr:NetError];
            block(NO, nil);
            return ;
        }
        else {
            /*
            if ((data && data[@"auth"] == [NSNull null]) || [data[@"auth"] isEqualToString:@""]) {
                UserModel *cUser = [UserModel currentUserInfo];
                if (cUser.logined) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kCookie_expired object:nil];
                }
                block(NO, kCookie_expired);
                return;
            }
             */
            NSMutableArray *arr = [NSMutableArray new];
            for (NSDictionary *dic in data) {
                NotificationModel *dialog = [NotificationModel mj_objectWithKeyValues:dic];
                [arr addObject:dialog];
            }
            block(YES,arr);
        }
        
    } ];
}


/**
 * 消息列表
 */
- (void)requestDialogListWithReturnBlock:(void(^)(bool success, id data))block
{
    WEAKSELF
    [[Clan_NetAPIManager sharedManager] request_DialogListWithResultBlock:^(id data, NSError *error) {
        STRONGSELF
        if (error) {
            //错误
            [strongSelf showHudTipStr:NetError];
            block(NO, nil);
            return ;
        }
        else {
            if ((data && data[@"auth"] == [NSNull null]) || [data[@"auth"] isEqualToString:@""]) {
                UserModel *cUser = [UserModel currentUserInfo];
                if (cUser.logined) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kCookie_expired object:nil];
                }
                block(NO, kCookie_expired);
                return;
            }
            NSMutableArray *arr = [NSMutableArray new];
            NSArray *arra = [data valueForKey:@"list"];
            for (NSDictionary *dic in arra) {
                DialogListModel *dialog = [DialogListModel mj_objectWithKeyValues:dic];
                [arr addObject:dialog];
            }
            block(YES,arr);
        }
        
    } ];
}

/**
 * 删除消息列表
 */
- (void)delete_DialogListwithDeletepm_deluid:(NSString *)deletepm_deluid andReturnBlock:(void(^)(bool success, id data))block
{
    WEAKSELF
    [[Clan_NetAPIManager sharedManager] delete_DialogListWithDeleteID:deletepm_deluid andResultBlock:^(id data, NSError *error) {
        STRONGSELF
        if (error) {
            [strongSelf showHudTipStr:NetError];
            return ;
        }
        else {
            NSString *flag = [data valueForKey:@"Message"][@"messageval"];
            NSString *errMess = [data valueForKey:@"Message"][@"messagestr"];
            if ([@"delete_pm_success" isEqualToString:flag]) {
                [strongSelf showHudTipStr:@"删除消息成功"];
                block(YES, data);

            } else {
                [strongSelf showHudTipStr:errMess];
                block(NO, nil);

            }
        }
    }];
}

@end
