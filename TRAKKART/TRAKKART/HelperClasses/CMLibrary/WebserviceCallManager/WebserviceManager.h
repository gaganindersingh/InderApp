//
//  WebserviceCallManager.h
//  VideoTag
//
//  Created by Aditya Aggarwal on 02/04/14.
//
//

#import <Foundation/Foundation.h>
#import "WebserviceCall.h"
#import "WebserviceResponse.h"

@interface WebserviceManager : NSObject{
    
    NSMutableArray *webservicesArray;
}

+ (id)sharedInstance;

#pragma mark - Webservice calls

-(void)callWebserviceForSignInWithSuccessSelectorNotification:(SEL)successSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall;

-(void)callWebserviceForSignUpWithSuccessSelectorNotification:(SEL)successSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall;

#pragma mark - File download calls

-(void)downloadFileFromUrl:(NSString *)url withSuccessSelectorNotification:(SEL)successSelector progressSelector:(SEL)progressSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall;
-(void)downloadFileAtPath:(NSString *)path fromUrl:(NSString *)url withSuccessSelectorNotification:(SEL)successSelector progressSelector:(SEL)progressSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall;

#pragma mark - Upload file on url

-(void)uploadFile:(NSData *)file withFileType:(NSString *)fileType onUrl:(NSString *)url withSuccessSelectorNotification:(SEL)successSelector failureSelectorNotification:(SEL)failureSelector webserviceCall:(WebserviceCall *)webserviceCall;

#pragma mark - Deregister for web service response

-(void)removeObserverForWebserviceResponse:(id)delegate;

#pragma mark - Webservice Call

-(WebserviceCall *)getWebserviceCallObjectWithDelegate:(id)delegate withResponseType:(WebserviceCallResponseType)responseType cachePolicy:(CachePolicy)cachePolicy;

-(void)releaseInstanceVarialbles;



@end
