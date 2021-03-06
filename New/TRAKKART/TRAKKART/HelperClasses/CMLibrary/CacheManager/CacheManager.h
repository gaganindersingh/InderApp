//
//  CacheManager.h
//  VideoTag
//
//  Created by Aditya Aggarwal on 08/04/14.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class CacheModel;

@interface CacheManager : NSObject{
    
    sqlite3 *dataBaseConnection;
}

+(id)sharedInstance;

//Cache Methods
//Gets Cache Data
- (CacheModel *)dataInCacheForKey:(NSString *)key;

//Sets Cache Data
- (BOOL)cacheData:(id)data forKey:(NSString *)key;

//Clears Cache Data
- (BOOL)clearDataForKey:(NSString *)key;

//Check for data availability
-(BOOL)isDataAvailableForKey:(NSString *)key;

-(void)createCopyOfDatabaseInDocumentDirectory:(BOOL)isReplaceOlderDB;

-(BOOL)updateData:(NSData *)data forKey:(NSString *)key;

-(void)releaseInstanceVarialbles;

@end
