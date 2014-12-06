//
//  WebserviceCall.m
//  VideoTag
//
//  Created by Aditya Aggarwal on 02/04/14.
//
//

#import "WebserviceCall.h"
#import "XMLDictionary.h"
#import "CacheManager.h"
#import "CacheModel.h"
#import "Loader.h"
#import "WebserviceResponse.h"

@implementation WebserviceCall

- (id)init
{
    self = [super init];
    if (self) {
        _cachePolicy = WebserviceCallCachePolicyRequestFromUrlNoCache;
    }
    return self;
}

#pragma mark - Web service calls

-(void)callWebserviceForURL:(NSURL *)url withDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    if(!url)
        return;
    
    [self setUrl:url];
    
    fileOwner = delegate;
    fileOwnerSuccessSelector = successSelector;
    fileOwnerFailureSelector = failureSelector;
    
    if(_cachePolicy != WebserviceCallCachePolicyRequestFromUrlNoCache)
    {
        NSString *cacheKey = [self getKeyForCacheAccordingToUrl:url];
        
        if([[CacheManager sharedInstance] isDataAvailableForKey:cacheKey])
        {
            CacheModel *cache = [[CacheManager sharedInstance] dataInCacheForKey:cacheKey];
            
            [self respondToDelegate:delegate onSelector:successSelector withData:cache.cacheValue];
            
            [self setIsShowLoader:NO];
            
            if(_cachePolicy == WebserviceCallCachePolicyRequestFromCacheIfAvailableOtherwiseFromUrlAndUpdateInCache)
                return;
        }
    }
    
    if(_isShowLoader)////self showLoader];
    {
        if(!ObjLoader)
            ObjLoader = [[Loader alloc] init];
        
        [ObjLoader showLoader];
    }
    
    [self makeRequestForWebServiceAtURL:url forDelegate:delegate successSelector:successSelector failureSelector:failureSelector];
}

-(void)makeRequestForWebServiceAtURL:(NSURL *)url forDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    if (![self checkNetworkConnectivity])
    {
        if([fileOwner respondsToSelector:fileOwnerFailureSelector])
            ([fileOwner performSelector:fileOwnerFailureSelector withObject:self withObject:[NSError errorWithDomain:@"No Internet" code:NotReachable userInfo:nil]]);
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    if(_requestType == WebserviceCallRequestTypeGet)
    {
        [request setHTTPMethod:@"GET"];
    }
    else if(_requestType == WebserviceCallRequestTypePost)
    {
        [request setHTTPMethod:@"POST"];
        if(_postDataDict)
        {
            NSError *error;
            
            NSData *postData = [NSJSONSerialization dataWithJSONObject:_postDataDict options:NSJSONWritingPrettyPrinted error:&error];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
        }
        if(_headerFieldsDict)
        {
            NSArray *allKeys = [_headerFieldsDict allKeys];
            
            for (NSString *key in allKeys)
            {
                [request setValue:[_headerFieldsDict objectForKey:key] forHTTPHeaderField:key];
            }
        }
    }
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if(_isShowLoader)
         {
             if (ObjLoader)
                 [ObjLoader hideLoader];
         }
         //[self hideLoader];
         
         if (data.length > 0 && connectionError == nil)
         {
             NSString *cacheKey = [self getKeyForCacheAccordingToUrl:url];

             if(_cachePolicy == WebserviceCallCachePolicyRequestFromCacheIfAvailableOtherwiseFromUrlAndUpdateInCache)
             {
                 [[CacheManager sharedInstance] cacheData:data forKey:cacheKey];
             }
             else if(_cachePolicy == WebserviceCallCachePolicyRequestFromCacheFirstAndThenFromUrlAndUpdateInCache)
             {
                 if([[CacheManager sharedInstance] isDataAvailableForKey:cacheKey])
                 {
                     [[CacheManager sharedInstance] updateData:data forKey:cacheKey];
                 }
                 else
                 {
                     [[CacheManager sharedInstance] cacheData:data forKey:cacheKey];
                 }
             }
             
             [self respondToDelegate:delegate onSelector:successSelector withData:data];
         }
         else if(connectionError)
         {
             if([delegate respondsToSelector:failureSelector])
                 ([delegate performSelector:failureSelector withObject:self withObject:connectionError]);
         }
     }];
}

#pragma mark - Network Reachability
-(BOOL)checkNetworkConnectivity
{
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    NetworkStatus internetStatus = [internetReach currentReachabilityStatus];
    
    switch(internetStatus)
    {
        case NotReachable:
        {
            [APPUtility showAlert:@"No Internet Connection" withMessage:@"Please check your internet connection and try again." delegate:nil];
            
            return NO;
        }
        case ReachableViaWiFi:
        {
            return YES;
        }
        case ReachableViaWWAN:
        {
            return YES;
        }
    }
    return YES;
}

#pragma mark - Loader

-(void) showLoader
{
    //Add loading indicator
    activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    
    activityView.center= window.center;
    
    [activityView startAnimating];
    
    [window addSubview:activityView];
}

-(void)hideLoader
{
    [activityView removeFromSuperview];
    [activityView stopAnimating];
}

#pragma mark - Download files

-(void)downloadFileFromUrl:(NSURL *)url withDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    if(!url || !delegate)
        return;
    
//    WebserviceResponse *errorResponse = [WebserviceResponse new];
//    [errorResponse setWebserviceUrl:[url absoluteString]];
//    [errorResponse setWebserviceResponse:[NSError errorWithDomain:@"No Internet" code:NotReachable userInfo:nil]];
//    [errorResponse setDownloadId:_downloadId];
//    
//    if([delegate respondsToSelector:failureSelector])
//        ([delegate performSelector:failureSelector withObject:self withObject:errorResponse]);
//    
//    return;
    
    [self setUrl:url];
    
    fileOwner = delegate;
    fileOwnerSuccessSelector = successSelector;
    fileOwnerFailureSelector = failureSelector;
    
    if(_cachePolicy != WebserviceCallCachePolicyRequestFromUrlNoCache)
    {
        NSString *cacheKey = [self getKeyForCacheAccordingToUrl:url];
        
        cacheKey = [cacheKey stringByReplacingOccurrencesOfString:@"'" withString:@""];
        
        if([[CacheManager sharedInstance] isDataAvailableForKey:cacheKey])
        {
            CacheModel *cache = [[CacheManager sharedInstance] dataInCacheForKey:cacheKey];
            NSString *filePath = [[NSString alloc] initWithData:cache.cacheValue encoding:NSUTF8StringEncoding];
    //            NSData *file = [self getFileFromPath:filePath];
    //            
            [self respondToDelegate:delegate onSelector:successSelector withData:filePath];
            
            if(_cachePolicy == WebserviceCallCachePolicyRequestFromCacheIfAvailableOtherwiseFromUrlAndUpdateInCache)
                return;
        }
    }
    
    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
        // Clean up any unfinished task business by marking where you
        
        // stopped or ending the task outright.
        
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    [self resumeOrStartDownload];
}

-(void)resumeOrStartDownload
{
    if (![self checkNetworkConnectivity])
    {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        
        bgTask = UIBackgroundTaskInvalid;
        
        WebserviceResponse *errorResponse = [WebserviceResponse new];
        [errorResponse setWebserviceUrl:[_url absoluteString]];
        [errorResponse setWebserviceResponse:[NSError errorWithDomain:@"No Internet" code:NotReachable userInfo:nil]];
        [errorResponse setDownloadId:_downloadId];
        
        if([fileOwner respondsToSelector:fileOwnerFailureSelector])
            ([fileOwner performSelector:fileOwnerFailureSelector withObject:self withObject:errorResponse]);
        
        return;
    }
    
    if(_isShowLoader)////self showLoader];
    {
        if(!ObjLoader)
            ObjLoader = [[Loader alloc] init];
        
        [ObjLoader showLoader];
    }
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSUInteger downloadedLength = 0;
    
    if([APPUtility checkIfStringContainsText:_downloadFilePath])
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:_downloadFilePath])
        {
            NSError *error = nil;
            NSDictionary *fileDictionary = [fm attributesOfItemAtPath:_downloadFilePath error:&error];
            if (!error && fileDictionary)
                downloadedLength = (NSUInteger)[fileDictionary fileSize];
        }
    }
    else
    {
        if(receivedData)
        {
            downloadedLength = receivedData.length;
        }
    }
    
    if(downloadedLength > 0)
    {
        NSILog(@"restart download %d",downloadedLength)
        NSString *range = [NSString stringWithFormat:@"bytes=%i-", downloadedLength];
        [theRequest setValue:range forHTTPHeaderField:@"Range"];
    }
    
    connectionForFile = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    [connectionForFile start];
}

#pragma mark - NSURLConnection delegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    if([APPUtility checkIfStringContainsText:_downloadFilePath])
    {
        unsigned long long downloadedBytes = 0;
//        BOOL isFileCreated = YES;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:_downloadFilePath])
        {
            NSError *error = nil;
            NSDictionary *fileDictionary = [fm attributesOfItemAtPath:_downloadFilePath error:&error];
            if (!error && fileDictionary)
                downloadedBytes = [fileDictionary fileSize];
        }
        else
        {
            [fm createFileAtPath:_downloadFilePath contents:nil attributes:nil];
        }
        
        if([response expectedContentLength] == downloadedBytes)
            expectedBytes = downloadedBytes;
        else
            expectedBytes = [response expectedContentLength] + downloadedBytes;
    }
    else
    {
        if(!receivedData)
        {
            expectedBytes = [response expectedContentLength];
            receivedData = [[NSMutableData alloc] initWithLength:0];
        }
        else
        {
            expectedBytes = [response expectedContentLength] + receivedData.length;
        }
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    float progressive = 0.0f;
    
    if([APPUtility checkIfStringContainsText:_downloadFilePath])
    {
        unsigned long long downloadedBytes = 0;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:_downloadFilePath])
        {
            if(!fileHandle)
            {
                fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:_downloadFilePath];
                [fileHandle seekToEndOfFile];
            }
            
            [fileHandle writeData:data];
//            [fileHandle closeFile];
//            fileHandle = nil;
            
            NSError *error = nil;
            NSDictionary *fileDictionary = [fm attributesOfItemAtPath:_downloadFilePath error:&error];
            if (!error && fileDictionary)
                downloadedBytes = [fileDictionary fileSize];
        }
        
        progressive = (float)downloadedBytes / (float)expectedBytes;
    }
    else
    {
        [receivedData appendData:data];
        progressive = (float)[receivedData length] / (float)expectedBytes;
    }
    
    if(_progressNotification)
    {
        WebserviceResponse *response = [WebserviceResponse new];
        [response setWebserviceUrl:[_url absoluteString]];
        [response setWebserviceResponse:[NSNumber numberWithFloat:progressive]];
        [response setDownloadId:_downloadId];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:_progressNotification object:response];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if(_isShowLoader)
    {
        if (ObjLoader)
            [ObjLoader hideLoader];
    }
    
    [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    
    bgTask = UIBackgroundTaskInvalid;
    
//    {
//    NSError *newError = nil;
//    NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:_downloadFilePath error:&newError];
//    if (!newError && fileDictionary)
//        NSILog(@"error download end %@",[NSNumber numberWithUnsignedLongLong:[fileDictionary fileSize]]);
//    }
//    if(error.code == NSError_Request_Timed_Out_Code)
//    {
//        [self performSelector:@selector(resumeOrStartDownload) withObject:nil afterDelay:1];
//        
//        return;
//    }

    if(fileHandle)
    {
        [fileHandle closeFile];
        fileHandle = nil;
    }
    
    WebserviceResponse *response = [WebserviceResponse new];
    [response setWebserviceUrl:[_url absoluteString]];
    [response setWebserviceResponse:error];
    [response setDownloadId:_downloadId];
    
    if([fileOwner respondsToSelector:fileOwnerFailureSelector])
        ([fileOwner performSelector:fileOwnerFailureSelector withObject:self withObject:response]);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if(_isShowLoader)
    {
        if (ObjLoader)
            [ObjLoader hideLoader];
    }
    
    if(fileHandle)
    {
        [fileHandle closeFile];
        fileHandle = nil;
    }
    
    if(_cachePolicy == WebserviceCallCachePolicyRequestFromUrlNoCache)
    {
        if([APPUtility checkIfStringContainsText:_downloadFilePath])
        {
            [self respondToDelegate:fileOwner onSelector:fileOwnerSuccessSelector withData:_downloadFilePath];
        }
        else
        {
            [self respondToDelegate:fileOwner onSelector:fileOwnerSuccessSelector withData:receivedData];
        }
        
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        
        bgTask = UIBackgroundTaskInvalid;
        
        return;
    }

    NSString *filePath = @"";
    NSString *currentURL = [[[connection currentRequest] URL] absoluteString];
    
    if([APPUtility checkIfStringContainsText:_downloadFilePath])
    {
        filePath = _downloadFilePath;
    }
    else
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *fileName = [self getFileNameAccordingToCurrentUrl:currentURL];
        NSString *cachesDirectory = [paths objectAtIndex:0];
        NSError *error;
        NSString *directoryPath = [cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/CachedResources"]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        filePath = [directoryPath stringByAppendingPathComponent:fileName];
        
        [receivedData writeToFile:filePath atomically:YES];
    }
    
    
    [self respondToDelegate:fileOwner onSelector:fileOwnerSuccessSelector withData:filePath];
    
    NSData *filePathData = [filePath dataUsingEncoding:NSUTF8StringEncoding];
    
    currentURL = [currentURL stringByReplacingOccurrencesOfString:@"'" withString:@""];
    
    if(_cachePolicy == WebserviceCallCachePolicyRequestFromCacheIfAvailableOtherwiseFromUrlAndUpdateInCache)
    {
        [[CacheManager sharedInstance] cacheData:filePathData forKey:currentURL];
    }
    else if(_cachePolicy == WebserviceCallCachePolicyRequestFromCacheFirstAndThenFromUrlAndUpdateInCache)
    {
        if([[CacheManager sharedInstance] isDataAvailableForKey:currentURL])
        {
            [[CacheManager sharedInstance] updateData:filePathData forKey:currentURL];
        }
        else
        {
            [[CacheManager sharedInstance] cacheData:filePathData forKey:currentURL];
        }
    }
    
    [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    
    bgTask = UIBackgroundTaskInvalid;
}

#pragma mark - Helper methods

-(NSString *)getFileNameAccordingToCurrentUrl:(NSString *)currentUrl
{
    if(![APPUtility checkIfStringContainsText:currentUrl])
        return currentUrl;
    
    NSString *fileName = [currentUrl lastPathComponent];
    
    if(_responseType == WebserviceCallResponsePNG)
    {
        if(![[fileName pathExtension] isEqualToString:@"png"])
            fileName = [fileName stringByAppendingString:@".png"];
    }
    else if(_responseType == WebserviceCallResponseJPEG)
    {
        if(![[fileName pathExtension] isEqualToString:@"jpeg"] && ![[fileName pathExtension] isEqualToString:@"jpg"])
            fileName = [fileName stringByAppendingString:@".jpg"];
    }
    else if(_responseType == WebserviceCallResponsePDF)
    {
        if(![[fileName pathExtension] isEqualToString:@"pdf"])
            fileName = [fileName stringByAppendingString:@".pdf"];
    }
    else if(_responseType == WebserviceCallResponseMP4)
    {
        if(![[fileName pathExtension] isEqualToString:@"mp4"])
            fileName = [fileName stringByAppendingString:@".mp4"];
    }
    else if(_responseType == WebserviceCallResponseSqliteFile)
    {
        if(![[fileName pathExtension] isEqualToString:@"sqlite"])
            fileName = [fileName stringByAppendingString:@".sqlite"];
    }
    
    return fileName;
}

-(NSData *)getFileFromPath:(NSString *)filePath
{
    if(![APPUtility checkIfStringContainsText:filePath])
        return nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        return nil;
    
    NSData *file = [NSData dataWithContentsOfFile:filePath];
    
    return file;
}

-(void)respondToDelegate:(id)delegate onSelector:(SEL)selector withData:(id)data
{
    id responseData;
    if(_responseType == WebserviceCallResponseJSON)
        responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    else if(_responseType == WebserviceCallResponseXML)
        responseData = [NSDictionary dictionaryWithXMLData:data];
    else if(_responseType == WebserviceCallResponsePNG || _responseType == WebserviceCallResponseJPEG)
        responseData = data;
    else
        responseData = data;
    
    WebserviceResponse *webserviceResponse = [WebserviceResponse new];
    [webserviceResponse setWebserviceUrl:[_url absoluteString]];
    [webserviceResponse setWebserviceResponse:responseData];
    [webserviceResponse setDownloadId:_downloadId];
    
    if([delegate respondsToSelector:selector])
        ([delegate performSelector:selector withObject:self withObject:webserviceResponse]);
}

-(NSString *)getKeyForCacheAccordingToUrl:(NSURL *)url
{
    if(!url)
        return nil;
    
    NSString *cacheKey = url.absoluteString;
    
    if(_postDataDict)
    {
        NSArray *allKeys = [_postDataDict allKeys];
        
        for (NSString *key in allKeys)
        {
            cacheKey = [cacheKey stringByAppendingString:[NSString stringWithFormat:@"%@:%@",key,[_postDataDict objectForKey:key]]];
        }
    }
    
    return cacheKey;
}

#pragma mark - File upload

-(void)uploadFile:(NSData *)file withFileType:(NSString *)fileType onUrl:(NSURL *)url withDelegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    if(!url)
        return;
    
    if (![self checkNetworkConnectivity])
    {
        if([fileOwner respondsToSelector:fileOwnerFailureSelector])
            ([fileOwner performSelector:fileOwnerFailureSelector withObject:self withObject:[NSError errorWithDomain:@"No Internet" code:NotReachable userInfo:nil]]);
        return;
    }

    if(_isShowLoader)////self showLoader];
    {
        if(!ObjLoader)
            ObjLoader = [[Loader alloc] init];
        
        [ObjLoader showLoader];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";

//    Open form
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    if(file)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"File\"; filename=\"%@\"\r\n",fileType] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:file]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSArray *allKeys = [_postDataDict allKeys];
    
    for (NSString *key in allKeys)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[_postDataDict valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPMethod:@"POST"];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    if(_headerFieldsDict)
    {
        NSArray *allKeys = [_headerFieldsDict allKeys];
        
        for (NSString *key in allKeys)
        {
            [request setValue:[_headerFieldsDict objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if(_isShowLoader)
         {
             if (ObjLoader)
                 [ObjLoader hideLoader];
         }
         //[self hideLoader];
         
         if (data.length > 0 && connectionError == nil)
         {
             [self respondToDelegate:delegate onSelector:successSelector withData:data];
         }
         else if(connectionError)
         {
             if([delegate respondsToSelector:failureSelector])
                 ([delegate performSelector:failureSelector withObject:self withObject:connectionError]);
         }
     }];
}

#pragma mark - Dealloc

- (void)dealloc
{
    receivedData = nil;
    _downloadFilePath = nil;
    fileOwner = nil;
    
    if(_isShowLoader)
    {
        if (ObjLoader) {
            [ObjLoader hideLoader];
        }
    }
        //[self hideLoader];
    
    if(connectionForFile)
        [connectionForFile cancel];
    
    connectionForFile = nil;
    
    if(_notificationDelegate)
    {
        if([APPUtility checkIfStringContainsText:_successNotification])
            [[NSNotificationCenter defaultCenter] removeObserver:_notificationDelegate name:_successNotification object:nil];
        if([APPUtility checkIfStringContainsText:_failureNotification])
            [[NSNotificationCenter defaultCenter] removeObserver:_notificationDelegate name:_failureNotification object:nil];
        if([APPUtility checkIfStringContainsText:_progressNotification])
            [[NSNotificationCenter defaultCenter] removeObserver:_notificationDelegate name:_progressNotification object:nil];
    }
}

@end
