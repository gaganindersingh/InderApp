//
//  WebserviceCallManager.m
//  VideoTag
//
//  Created by Aditya Aggarwal on 02/04/14.
//
//

#import "WebserviceManager.h"
#import "WebserviceConstants.h"

@implementation WebserviceManager

+ (id)sharedInstance {
    
    static WebserviceManager *sharedMyManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (id)init {
    
    if (self = [super init]) {
        
        webservicesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Webservice calls

-(void)callWebserviceForSignInWithSuccessSelectorNotification:(SEL)successSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall)
        return;
    
    if(successSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:successSelector name:WebserviceManagerSignInSuccessNotification object:nil];
    
    if(failureSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:failureSelector name:WebserviceManagerSignInFailureNotification object:nil];
    
    [self callWebserviceWithUrl:[NSURL URLWithString:Webservice_SignIn] successNotification:WebserviceManagerSignInSuccessNotification failureNotification:WebserviceManagerSignInFailureNotification withWebserviceCall:webserviceCall];
}

-(void)callWebserviceForSignUpWithSuccessSelectorNotification:(SEL)successSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall)
        return;
    
    if(successSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:successSelector name:WebserviceManagerSignUpSuccessNotification object:nil];
    
    if(failureSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:failureSelector name:WebserviceManagerSignInFailureNotification object:nil];
    
    [self callWebserviceWithUrl:[NSURL URLWithString:Webservice_SignUp] successNotification:WebserviceManagerSignUpSuccessNotification failureNotification:WebserviceManagerSignUpFailureNotification withWebserviceCall:webserviceCall];
}


#pragma mark - File download calls

-(void)downloadFileFromUrl:(NSString *)url withSuccessSelectorNotification:(SEL)successSelector progressSelector:(SEL)progressSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall || ![APPUtility checkIfStringContainsText:url])
        return;
    
    NSString *successNotification = [NSString stringWithFormat:@"%@_Success",url];
    NSString *failureNotification = [NSString stringWithFormat:@"%@_Failure",url];
    NSString *progressNotification = [NSString stringWithFormat:@"%@_Progress",url];
    
    if(successSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:successSelector name:successNotification object:nil];
    
    if(failureSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:failureSelector name:failureNotification object:nil];
    
    if(progressSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:progressSelector name:progressNotification object:nil];
    
    [webserviceCall setProgressNotification:progressNotification];
    
    [self downloadFileWithUrl:[NSURL URLWithString:url] successNotification:successNotification failureNotification:failureNotification withWebserviceCall:webserviceCall];
}

-(void)downloadFileAtPath:(NSString *)path fromUrl:(NSString *)url withSuccessSelectorNotification:(SEL)successSelector progressSelector:(SEL)progressSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall || ![APPUtility checkIfStringContainsText:url])
        return;
    
    NSString *successNotification = [NSString stringWithFormat:@"%@_Success",url];
    NSString *failureNotification = [NSString stringWithFormat:@"%@_Failure",url];
    NSString *progressNotification = [NSString stringWithFormat:@"%@_Progress",url];
    
    if(successSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:successSelector name:successNotification object:nil];
    
    if(failureSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:failureSelector name:failureNotification object:nil];
    
    if(progressSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:progressSelector name:progressNotification object:nil];
    
    [webserviceCall setDownloadFilePath:path];
    
    [webserviceCall setProgressNotification:progressNotification];
    
    [self downloadFileWithUrl:[NSURL URLWithString:url] successNotification:successNotification failureNotification:failureNotification withWebserviceCall:webserviceCall];
}

#pragma mark - Upload file calls

-(void)uploadFile:(NSData *)file withFileType:(NSString *)fileType onUrl:(NSString *)url withSuccessSelectorNotification:(SEL)successSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall || ![APPUtility checkIfStringContainsText:url])
        return;
    
    NSString *successNotification = [NSString stringWithFormat:@"%@_Success",url];
    NSString *failureNotification = [NSString stringWithFormat:@"%@_Failure",url];
    
    if(successSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:successSelector name:successNotification object:nil];
    
    if(failureSelector)
        [[NSNotificationCenter defaultCenter] addObserver:[webserviceCall notificationDelegate] selector:failureSelector name:failureNotification object:nil];

    [self addAccessTokenInHeaderFieldForWebService:webserviceCall];
    
    [self uploadFile:file withFileType:fileType onUrl:[NSURL URLWithString:url] successNotification:successNotification failureNotification:failureNotification withWebserviceCall:webserviceCall];
}

#pragma mark - Webservice Call

-(WebserviceCall *)getWebserviceCallObjectWithDelegate:(id)delegate withResponseType:(WebserviceCallResponseType)responseType cachePolicy:(CachePolicy)cachePolicy
{
    if(!delegate)
        return nil;
    
    WebserviceCall *webserviceCall = [[WebserviceCall alloc] init];
    
    [webserviceCall setNotificationDelegate:delegate];
    
    if(responseType)
        [webserviceCall setResponseType:responseType];
    if(cachePolicy)
        [webserviceCall setCachePolicy:cachePolicy];
    
    return webserviceCall;
}

#pragma mark - Call webservice with url

-(void)callWebserviceWithUrl:(NSURL *)url successNotification:(NSString *)successNotification failureNotification:(NSString *)failureNotification withWebserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall || !url)
        return;
    
    [webserviceCall setSuccessNotification:successNotification];
    [webserviceCall setFailureNotification:failureNotification];

    [webservicesArray addObject:webserviceCall];
    
    [webserviceCall callWebserviceForURL:url withDelegate:self successSelector:@selector(successCallBackFromWebserviceCall:withResponse:) failureSelector:@selector(failureCallBackFromWebserviceCall:withError:)];
}

#pragma mark - Download file from url

-(void)downloadFileWithUrl:(NSURL *)url successNotification:(NSString *)successNotification failureNotification:(NSString *)failureNotification withWebserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall || !url)
        return;
    
    [webservicesArray addObject:webserviceCall];
    [webserviceCall setSuccessNotification:successNotification];
    [webserviceCall setFailureNotification:failureNotification];
    
    [webserviceCall downloadFileFromUrl:url withDelegate:self successSelector:@selector(successCallBackFromWebserviceCall:withResponse:) failureSelector:@selector(failureCallBackFromWebserviceCall:withError:)];
}

#pragma mark - Upload file on url

-(void)uploadFile:(NSData *)file withFileType:(NSString *)fileType onUrl:(NSURL *)url successNotification:(NSString *)successNotification failureNotification:(NSString *)failureNotification withWebserviceCall:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall)
        return;
    
    [webservicesArray addObject:webserviceCall];
    [webserviceCall setSuccessNotification:successNotification];
    [webserviceCall setFailureNotification:failureNotification];
    
    [webserviceCall uploadFile:file withFileType:fileType onUrl:url withDelegate:self successSelector:@selector(successCallBackFromWebserviceCall:withResponse:) failureSelector:@selector(failureCallBackFromWebserviceCall:withError:)];
}

#pragma mark - Web service selector

-(void)successCallBackFromWebserviceCall:(WebserviceCall *)webserviceCall withResponse:(WebserviceResponse *)webserviceResponse
{
    if([webserviceCall successNotification])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:[webserviceCall successNotification] object:webserviceResponse];
    }

    if([webservicesArray containsObject:webserviceCall])
        [webservicesArray removeObject:webserviceCall];
}

-(void)failureCallBackFromWebserviceCall:(WebserviceCall *)webserviceCall withError:(NSError *)error
{
    if([webserviceCall failureNotification])
        [[NSNotificationCenter defaultCenter] postNotificationName:[webserviceCall failureNotification] object:error];
    
//    [webserviceCall setDownloadFilePath:nil];
//    [webserviceCall setSuccessNotification:nil];
//    [webserviceCall setFailureNotification:nil];
//    [webserviceCall setProgressNotification:nil];
//    [webserviceCall setPostDataDict:nil];
//    [webserviceCall setHeaderFieldsDict:nil];
//    [webserviceCall setUrl:nil];
//    [webserviceCall setDownloadFilePath:nil];
    
    if([webservicesArray containsObject:webserviceCall])
        [webservicesArray removeObject:webserviceCall];
    
    webserviceCall = nil;
}

#pragma mark - Deregister for web service response

-(void)removeObserverForWebserviceResponse:(id)delegate
{
    if(delegate)
        [[NSNotificationCenter defaultCenter] removeObserver:delegate];
}

#pragma mark - AccessToken

-(void)addAccessTokenInHeaderFieldForWebService:(WebserviceCall *)webserviceCall
{
    if(!webserviceCall)
        return;
    
//    UserInfoModel *userInfoModel = [UserInfoManager getUserInfo];
//    [webserviceCall setHeaderFieldsDict:@{WebserviceAuthTokenKey:[userInfoModel accessToken]}];
}

- (void)dealloc
{
    webservicesArray = nil;
}

-(void)releaseInstanceVarialbles
{
    if([webservicesArray count] > 0)
        [webservicesArray removeAllObjects];
}

@end
