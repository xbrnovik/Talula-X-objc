//
//  MeteoriteStorage.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataContainer.h"
#import "Meteorite.h"
#import "CDMeteorite+CoreDataClass.h"
#import "CDMeteorite+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteStorage : NSObject

@property(readonly, nonatomic) NSFetchedResultsController * fetchedResultsController;

- (instancetype)init;
- (void)storeMeteorites:(NSArray<Meteorite*>*)meteorites;
- (NSArray<CDMeteorite*>*)loadMeteorites;

@end

NS_ASSUME_NONNULL_END
