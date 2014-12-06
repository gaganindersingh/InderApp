//
//  WebserviceResponseParser.m
//  VideoTag
//
//  Created by Aditya Aggarwal on 21/04/14.
//
//

#import "WebserviceResponseParser.h"



@implementation WebserviceResponseParser

#pragma mark - Helper methods


+(id)getObjectForKey:(NSString *)key fromDict:(NSDictionary *)dict
{
    if(!dict || ![APPUtility checkIfStringContainsText:key])
        return nil;
    
    id value = [dict objectForKey:key];
    
    if([value isEqual:[NSNull null]] || value == NULL)
        return nil;
    
    return value;
}

+(NSMutableArray*)getDashboardDetailsWithArray:(NSArray*)data
{
    return nil;
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i < data.count; i++) {
//        NSDictionary *dict = [data objectAtIndex:i];
//        ParentDashboardModel *objItem = [[ParentDashboardModel alloc] init];
//        
//        // fill item details
//        [objItem fillDetails:dict];
//        
//        [tempArray addObject:objItem];
//        objItem = nil;
//    }
//    
//    return tempArray;
}




@end
