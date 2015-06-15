//
//  DBManager.m
//  iCampus
//
//  Created by Siyu Yang on 14-8-14.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
#import "DBExecutingQueue.h"

@interface DBManager()


@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;


@end

@implementation DBManager

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename
{
    self = [super init];
    
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
        
        self.databaseFilename = dbFilename;
        
        [self copyDatabaseIntoDocumentsDirectory];
    }
    
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectory
{
    NSString *destinationPath = [self.documentsDirectory stringByAppendingString:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", self.databaseFilename]];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable
{
    sqlite3 *sqlite3Database;
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingString:self.databaseFilename];
    
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    //open the database
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    sqlite3_busy_timeout(sqlite3Database, 10);
    if (openDatabaseResult == SQLITE_OK) {
        sqlite3_stmt *compiledStatement;
        
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);

        if (prepareStatementResult == SQLITE_OK) {
            if (!queryExecutable) {
                
                NSMutableDictionary *dicDataRow;
                
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    dicDataRow = [[NSMutableDictionary alloc] init];
                    
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
                    for (int i=0; i<totalColumns; i++) {
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        char *columnNameAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                        
                        if (dbDataAsChars != NULL) {
                            [dicDataRow setObject:[NSString stringWithUTF8String:dbDataAsChars] forKey:[NSString stringWithUTF8String:columnNameAsChars]];
                        }
                    }
                    
                    if (dicDataRow != nil) {
                        [self.arrResults addObject:dicDataRow];
                    }
                }
                //NSLog(@"arrresult:%@",self.arrResults);
                
            } else {
              
                int executeQueryResults = sqlite3_step(compiledStatement);
                if (executeQueryResults == SQLITE_DONE) {
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                } else {
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
            sqlite3_finalize(compiledStatement);
            
        } else {
            NSLog(@"Prepare Statement Error: %s", sqlite3_errmsg(sqlite3Database));
        }
        sqlite3_close(sqlite3Database);
    } else {
        NSLog(@"DB Open Error: %s", sqlite3_errmsg(sqlite3Database));
    }
}

- (NSArray *)loadDataFromDB:(NSString *)query
{
    //NSLog(@"run query:%@",query);
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    
    return (NSArray *)self.arrResults;
}

- (void)executeQuery:(NSString *)query
{
    //NSLog(@"run execute query:%@",query);
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

- (BOOL)saveImage:(UIImage *)image withId:(NSString *)identifier inTable:(NSString *)table
{
    //return YES;
    dispatch_sync([DBExecutingQueue getQueue], ^{
    
    NSData *img = UIImageJPEGRepresentation(image, 1.0);
    
    sqlite3 *sqlite3Database;
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingString:self.databaseFilename];
    
    //open the database
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if (openDatabaseResult == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat:@"insert into %@ values(null, '%@', ?)", table, identifier];
        
        sqlite3_stmt *compiledStatement;
        
        BOOL prepareStatementResult = sqlite3_prepare(sqlite3Database, [query UTF8String], -1, &compiledStatement, 0);
        if (prepareStatementResult == SQLITE_OK) {
            
            sqlite3_bind_blob(compiledStatement, 1, [img bytes], [img length], NULL);
            
            BOOL executeQueryResults = sqlite3_step(compiledStatement);
            
            if (executeQueryResults == SQLITE_DONE) {
                self.affectedRows = sqlite3_changes(sqlite3Database);
                self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                NSLog(@"Save Image successfully");
            } else {
                NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
            }
            sqlite3_finalize(compiledStatement);
        } else {
            NSLog(@"Prepare Statement Error: %s", sqlite3_errmsg(sqlite3Database));
        }
        sqlite3_close(sqlite3Database);
    } else {
        NSLog(@"DB Open Error: %s", sqlite3_errmsg(sqlite3Database));
    }
    
    });

    return YES;
}

- (BOOL)updateImage:(UIImage *)image withId:(NSString *)identifier inTable:(NSString *)table
{
    //return YES;
    dispatch_sync([DBExecutingQueue getQueue], ^{
        
        NSData *img = UIImageJPEGRepresentation(image, 1.0);
        
        sqlite3 *sqlite3Database;
        
        NSString *databasePath = [self.documentsDirectory stringByAppendingString:self.databaseFilename];
        
        //open the database
        BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
        if (openDatabaseResult == SQLITE_OK) {
            NSString *query = [NSString stringWithFormat:@"update %@ set data=? where identifier='%@'", table , identifier];
            
            sqlite3_stmt *compiledStatement;
            
            BOOL prepareStatementResult = sqlite3_prepare(sqlite3Database, [query UTF8String], -1, &compiledStatement, 0);
            if (prepareStatementResult == SQLITE_OK) {
                
                sqlite3_bind_blob(compiledStatement, 1, [img bytes], (int)[img length], NULL);
                
                int executeQueryResults = sqlite3_step(compiledStatement);
                
                if (executeQueryResults == SQLITE_DONE) {
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                    NSLog(@"update Image successfully");
                } else {
                    NSLog(@"update Image DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
                sqlite3_finalize(compiledStatement);
            } else {
                NSLog(@"update Image Prepare Statement Error: %s", sqlite3_errmsg(sqlite3Database));
            }
            sqlite3_close(sqlite3Database);
        } else {
            NSLog(@"update Image DB Open Error: %s", sqlite3_errmsg(sqlite3Database));
        }
        
    });
    
    return YES;
}


- (UIImage *)loadImage:(NSString *)identifier inTable:(NSString *)table
{
    UIImage *image;
    
    sqlite3 *sqlite3Database;
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingString:self.databaseFilename];
    
    //open the database
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if (openDatabaseResult == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat:@"select data from %@ where identifier = '%@'", table, identifier];
        
        sqlite3_stmt *compiledStatement;
        
        BOOL prepareStatementResult = sqlite3_prepare(sqlite3Database, [query UTF8String], -1, &compiledStatement, NULL);
        
        if (prepareStatementResult == SQLITE_OK) {
            
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                int bytes = sqlite3_column_bytes(compiledStatement, 0);
                const void *value = sqlite3_column_blob(compiledStatement, 0);
                if (value != NULL && bytes != 0) {
                    NSData *data = [NSData dataWithBytes:value length:bytes];
                    image = [UIImage imageWithData:data];
                }
            }
            
            sqlite3_finalize(compiledStatement);
            
        } else {
            NSLog(@"Prepare Statement Error: %s", sqlite3_errmsg(sqlite3Database));
        }
        sqlite3_close(sqlite3Database);
    } else {
        NSLog(@"DB Open Error: %s", sqlite3_errmsg(sqlite3Database));
    }
    
    return image;
}

@end
