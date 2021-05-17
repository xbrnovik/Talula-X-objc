//
//  MeteoriteStorage.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "MeteoriteStorage.h"

@interface MeteoriteStorage ()
    
@property (readwrite, assign) NSFetchedResultsController * fetchedResultsController;

@end

@implementation MeteoriteStorage

- (instancetype)init
{
    [self createFetchedResultsController];
    self = [super init];
    return self;
}

- (void)createFetchedResultsController {
    if (!_fetchedResultsController) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *managedObjectContext = [[[CoreDataContainer shared] persistentContainer ] viewContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDMeteorite" inManagedObjectContext:managedObjectContext];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mass" ascending:NO];
        [request setSortDescriptors:@[sort]];
        [request setEntity:entity];
        [request setFetchBatchSize:20];
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                                initWithFetchRequest:request
                                                                managedObjectContext:managedObjectContext
                                                                sectionNameKeyPath:nil
                                                                cacheName:nil];
        NSError *error = nil;
        @try {
            [aFetchedResultsController performFetch:&error];
         }
        @catch (NSException *exception) {
            NSLog(@"Unable to perform fetch. Error: %@. Reason: %@.", error, exception.reason);
        }
        @finally {
           NSLog(@"Performed fetch.");
        };
        _fetchedResultsController = aFetchedResultsController;
    }
}

- (void)storeMeteorites:(NSArray<Meteorite*>*)meteorites
{
    // fetch
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = [[[CoreDataContainer shared] persistentContainer ] viewContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDMeteorite" inManagedObjectContext:managedObjectContext];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mass" ascending:NO];
    [request setSortDescriptors:@[sort]];
    [request setEntity:entity];
    [request setFetchBatchSize:20];
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:request
                                                            managedObjectContext:managedObjectContext
                                                            sectionNameKeyPath:nil
                                                            cacheName:nil];
    NSError *error = nil;
    @try {
        [fetchedResultsController performFetch:&error];
     }
    @catch (NSException *exception) {
        NSLog(@"Unable to perform fetch. Error: %@. Reason: %@.", error, exception.reason);
    }
    @finally {
       NSLog(@"Performed fetch.");
    };
    //delete
    NSFetchRequest *deleteFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CDMeteorite"];
    NSBatchDeleteRequest *batchDeleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:deleteFetchRequest];
    NSError *deleteError = nil;
    [[[[CoreDataContainer new] persistentContainer ] persistentStoreCoordinator] executeRequest:batchDeleteRequest withContext:managedObjectContext error:&deleteError];
    //add
    for (Meteorite* meteorite in meteorites) {
        CDMeteorite *newMeteorite = [NSEntityDescription insertNewObjectForEntityForName:@"CDMeteorite" inManagedObjectContext:managedObjectContext];
        newMeteorite.place = meteorite.place;
        newMeteorite.category = meteorite.category;
        newMeteorite.identifier = meteorite.identifier;
        newMeteorite.year = meteorite.year;
        newMeteorite.latitude = [meteorite.latitude doubleValue];
        newMeteorite.longitude = [meteorite.longitude doubleValue];
        newMeteorite.mass = [meteorite.mass doubleValue];
        newMeteorite.name = meteorite.name;
    }
    //save
    [[CoreDataContainer shared] saveContext];
    //get
    NSFetchedResultsController *fetchedResultsController2 = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:request
                                                            managedObjectContext:managedObjectContext
                                                            sectionNameKeyPath:nil
                                                            cacheName:nil];
    NSError *error2 = nil;
    @try {
        [fetchedResultsController2 performFetch:&error2];
     }
    @catch (NSException *exception) {
        NSLog(@"Unable to perform fetch. Error: %@. Reason: %@.", error, exception.reason);
    }
    @finally {
       NSLog(@"Performed fetch.");
    };
}

- (NSArray<CDMeteorite*>*)storedMeteorites
{
    // fetch
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = [[[CoreDataContainer shared] persistentContainer ] viewContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDMeteorite" inManagedObjectContext:managedObjectContext];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mass" ascending:NO];
    [request setSortDescriptors:@[sort]];
    [request setEntity:entity];
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:request
                                                            managedObjectContext:managedObjectContext
                                                            sectionNameKeyPath:nil
                                                            cacheName:nil];
    NSError *error = nil;
    @try {
        [fetchedResultsController performFetch:&error];
     }
    @catch (NSException *exception) {
        NSLog(@"Unable to perform fetch. Error: %@. Reason: %@.", error, exception.reason);
    }
    @finally {
       NSLog(@"Performed fetch.");
    };
    return fetchedResultsController.fetchedObjects;
}

@end
