//
//  WebserviceCall.h
//  VideoTag
//
//  Created by Aditya Aggarwal on 02/04/14.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define NSError_Request_Timed_Out_Code -1001

@class Loader;

typedef enum{
 
    WebserviceCallResponseJSON,
    WebserviceCallResponseXML,
    WebserviceCallResponsePNG,
    WebserviceCallResponseJPEG,
    WebserviceCallResponsePDF,
    WebserviceCallResponseMP4,
    WebserviceCallResponseSqliteFile
    
}WebserviceCallResponseType;

typedef enum{
    
    WebserviceCallCachePolicyRequestFromUrlNoCache,   // For file download this will not work
    WebserviceCallCachePolicyRequestFromCacheIfAvailableOtherwiseFromUrlAndUpdateInCache,
    WebserviceCallCachePolicyRequestFromCacheFirstAndThenFromUrlAndUpdateInCache
    
}CachePolicy;

typedef enum{
    
    WebserviceCallRequestTypePost,
    WebserviceCallRequestTypeGet
    
}RequestType;

@interface WebserviceCall : NSObject{
    
    NSMutableData *receivedData;
    NSURLConnection * connectionForFile;
    long long expectedBytes;
    __weak id fileOwner;
    SEL fileOwnerSuccessSelector;
    SEL fileOwnerFailureSelector;
    Reachability *internetReach;
    UIActivityIndicatorView *activityView;
    Loader *ObjLoader;
    
    UIBackgroundTaskIdentifier bgTask;
    NSFileHandle *fileHandle;
}

@property (nonatomic, assign) int downloadId; // ref for Webservice response for accurate delegate
@property (nonatomic, assign) id notificationDelegate;
@property (nonatomic, copy) NSString *successNotification;
@property (nonatomic, copy) NSString *failureNotification;
@property (nonatomic, copy) NSString *progressNotification;
@property (nonatomic, assign) WebserviceCallResponseType responseType;
@property (nonatomic, assign) CachePolicy cachePolicy;
@property (nonatomic, assign) RequestType requestType;
@property (nonatomic, copy) NSDictionary *postDataDict;
@property (nonatomic, assign) BOOL isShowLoader;
@property (nonatomic, copy) NSDictionary *headerFieldsDict;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSString *downloadFilePath;

-(void)callWebserviceForURL:(NSURL *)url withDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector;
-(void)downloadFileFromUrl:(NSURL *)url withDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector;
-(void)uploadFile:(NSData *)file withFileType:(NSString *)fileType onUrl:(NSURL *)url withDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector;

@end
