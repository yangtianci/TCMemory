//
//  TCMNetWorkManager.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//确定请求方式
typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethod_GET,
    RequestMethod_POST,
    RequestMethod_File
};

typedef NS_ENUM(NSInteger, NetStatue){
    NetStatue_UnMonite,//未监控
    NetStatue_UnKnow,//未知状态
    NetStatue_NoReachable,//未联网
    NetStatue_Cellular,//蜂窝网络
    NetStatue_WiFi//wifi
};

@interface TCMNetWorkManager : NSObject

//超时
@property (nonatomic,assign) NSTimeInterval requestTimeOut;

#pragma mark GET请求
- (void)GET_URL:(NSString *)url PARA:(NSDictionary *)para info:(NSDictionary *)info success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark POST请求
- (void)POST_URL:(NSString *)url PARA:(NSDictionary *)para info:(NSDictionary *)info success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark 文件请求
- (void)POSTFILE_URL:(NSString *)url PARA:(NSDictionary *)para fileArr:(NSArray *)fileArr success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure;

#pragma mark >>>>>>>>>> 检查网络状态
-(void)MoniterNetStatus:(void (^)(NetStatue))netStautsBlock;


@end
