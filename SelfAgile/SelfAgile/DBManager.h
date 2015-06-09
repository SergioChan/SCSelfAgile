//
//  DBManager.h
//  iCampus
//
//  Created by Siyu Yang on 14-8-14.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
- (NSArray *)loadDataFromDB:(NSString *)query;
- (void)executeQuery:(NSString *)query;

- (BOOL)saveImage:(UIImage *)image withId:(NSString *)identifier inTable:(NSString *)table;
- (UIImage *)loadImage:(NSString *)identifier inTable:(NSString *)table;
- (BOOL)updateImage:(UIImage *)image withId:(NSString *)identifier inTable:(NSString *)table;
@end
