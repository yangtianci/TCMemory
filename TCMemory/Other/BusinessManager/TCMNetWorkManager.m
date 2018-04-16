//
//  TCMNetWorkManager.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMNetWorkManager.h"

@interface TCMNetWorkManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic,copy) void(^successB)(id ResObj);
@property (nonatomic,copy) void(^failB)(NSError *error);
@property (nonatomic,copy) void(^progressBlock)(NSProgress *progress);

// 文件数组
@property (nonatomic,copy) NSArray *fileArr;
//网络状态
@property (assign, nonatomic) NetStatue netStatus;
//方法
@property (nonatomic,assign) RequestMethod requestMethod;
//地址 >>> 此处使用全路径
@property (nonatomic,copy) NSString *requestUrl;
//参数
@property (nonatomic,copy) NSDictionary *requestParameter;
//特殊参数
@property (nonatomic,copy) NSDictionary *info;
//错误信息
@property (nonatomic,strong) NSError *error;

@end

@implementation TCMNetWorkManager

#pragma mark >>>>>>>>>> 创建单例对象

static id _instance;
+(instancetype)sharedManager
{
    if(_instance == nil)
    {
        @synchronized(self)
        {
            if(_instance == nil)
            {
                _instance = [[self alloc]init];
            }
        }
    }
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if(_instance == nil)
    {
        @synchronized(self)
        {
            if(_instance == nil)
            {
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark >>>>>>>>>> 功能函数

#pragma mark GET请求
- (void)GET_URL:(NSString *)url PARA:(NSDictionary *)para info:(NSDictionary *)info success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    [self requestMethod:RequestMethod_GET URL:url PARA:para Info:info Progress:_progressBlock success:success failure:failure];
}

#pragma mark POST请求
- (void)POST_URL:(NSString *)url PARA:(NSDictionary *)para info:(NSDictionary *)info success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    [self requestMethod:RequestMethod_POST URL:url PARA:para Info:info Progress:_progressBlock success:success failure:failure];
}

#pragma mark 文件请求
- (void)POSTFILE_URL:(NSString *)url PARA:(NSDictionary *)para fileArr:(NSArray *)fileArr success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure{
    //暂时不启用
}

#pragma mark >>>>>>>>>> 实际执行函数
- (void)GET{
    [self.sessionManager GET:self.requestUrl parameters:self.requestParameter progress:^(NSProgress * _Nonnull downloadProgress) {
        if (self.progressBlock) {
            self.progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.successB(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
        self.failB(error);
    }];
}

//POST
- (void)POST {

    [self.sessionManager POST:self.requestUrl parameters:self.requestParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        if (self.progressBlock) {
            self.progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self.successB) {
            self.successB(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _error = error;
        if (self.failB) {
            self.failB(error);
        }
    }];
}

#pragma mark >>> 公共函数

- (void)requestMethod:(RequestMethod)method URL:(NSString *)url PARA:(NSDictionary *)para Info:(NSDictionary *)info Progress:(void(^)(NSProgress *progress))progress success:(void(^)(id result))success failure:(void(^)(NSDictionary *errorInfo))failure {
    
    self.requestUrl = url;
    self.requestParameter = para;
    self.info = info;
    self.requestMethod = method;
    
    [self requestProgress:^(NSProgress *p) {
        if (progress) {
            progress(p);
        }
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:error.userInfo];
        if (failure) {
            // 适情况有不同的提示语和展示画面
            if (error.code == kCFURLErrorNotConnectedToInternet) {
                // 连接不到网
            }
            else if (error.code == kCFURLErrorTimedOut) {
                // 连接超时
            }else if (error.code == kCFURLErrorCannotConnectToHost){
                // 连接不到服务器
            }
            else if (error.code == kCFURLErrorCannotFindHost) {
                // 找不到服务器
            }
            else {
                // 其他情况
            }
            failure(mdic);
        }
    }];
}

- (void)requestProgress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    self.progressBlock = progress;
    self.successB = success;
    self.failB = failure;
    self.requestTimeOut = 10;
    self.sessionManager.requestSerializer.timeoutInterval = self.requestTimeOut;
    if (self.requestMethod == RequestMethod_GET) {
        [self GET];
    }else if (self.requestMethod == RequestMethod_POST){
        [self POST];
    }
    
}

#pragma mark >>>>>>>>>> 检查网络状态
-(void)MoniterNetStatus:(void (^)(NetStatue))netStautsBlock{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.netStatus = NetStatue_UnKnow;
                netStautsBlock(NetStatue_UnKnow);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.netStatus = NetStatue_NoReachable;
                netStautsBlock(NetStatue_NoReachable);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.netStatus = NetStatue_Cellular;
                netStautsBlock(NetStatue_Cellular);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.netStatus = NetStatue_WiFi;
                netStautsBlock(NetStatue_WiFi);
                break;
        }
        
    }];
    
    [manager startMonitoring];
    
}


#pragma mark >>>>>>>>>> 懒加载
-(AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return _sessionManager;
}



@end
