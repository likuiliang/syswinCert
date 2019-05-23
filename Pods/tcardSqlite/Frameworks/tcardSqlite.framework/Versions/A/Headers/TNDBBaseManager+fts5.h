//
//  TNDBBaseManager+fts5.h
//  tcardSqlite
//
//  Created by luhongdeng on 2018/8/13.
//

#import "TNDBBaseManager.h"

#if 0
@class FMDatabase;

@interface TNDBBaseManager (fts5)


@property(nonatomic, strong) FMDatabaseQueue *virtualQueue;

- (BOOL)registerTokenizerWithDBBase:(FMDatabase *)dbBase;

- (BOOL)createVirtaulTableWithDBBase:(FMDatabase *)dbBase withTables:(NSArray <Class> *)tableList;

- (NSArray <NSDictionary *> *)queryItemsInTable:(Class)tableClass withSearchTxt:(NSString *)searchTxt where:(NSString *)where, ...NS_REQUIRES_NIL_TERMINATION;

@end

#endif
