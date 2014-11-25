//
//  NSIImageView.m
//  VideoTag
//
//  Created by Aditya Aggarwal on 24/04/14.
//
//

#import "NSIImageView.h"
#import "WebserviceManager.h"

@implementation NSIImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setImageFromURL:(NSString *)url
{
    if(url.length==0)
        return;
    
    [self setImage:nil];
    
    if(![APPUtility checkIfStringContainsText:url])
        return;
    
    [self setImageUrl:url];
    
    [[WebserviceManager sharedInstance] removeObserverForWebserviceResponse:self];
    [self fetchImageFromUrl:url];
}

#pragma mark - Webservice manager

-(void)fetchImageFromUrl:(NSString *)url
{
    WebserviceCall *webserviceCall = [[WebserviceManager sharedInstance] getWebserviceCallObjectWithDelegate:self withResponseType:WebserviceCallResponsePNG cachePolicy:WebserviceCallCachePolicyRequestFromCacheIfAvailableOtherwiseFromUrlAndUpdateInCache];
    [[WebserviceManager sharedInstance] downloadFileFromUrl:url withSuccessSelectorNotification:@selector(onSuccessfulDownloadNotification:) progressSelector:nil failureSelectorNotification:@selector(onFailureDownloadNotification:) webserviceCall:webserviceCall];
}

-(void)onSuccessfulDownloadNotification:(NSNotification *)notification
{
    WebserviceResponse *response = [notification object];
    NSString *url = [response webserviceUrl];
    
    if(![[response webserviceUrl] isEqualToString:url])
        return;
    
    [self setImage:[UIImage imageWithContentsOfFile:[response webserviceResponse]]];
}

-(void)onFailureDownloadNotification:(NSNotification *)notification
{
    
}

- (void)dealloc
{
    [[WebserviceManager sharedInstance] removeObserverForWebserviceResponse:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
