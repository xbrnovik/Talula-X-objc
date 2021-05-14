//
//  CoreDataContainer.m
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import "CoreDataContainer.h"

@implementation CoreDataContainer

+ (CoreDataContainer *) shared
{
    static CoreDataContainer *coreDataContainer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataContainer = [[CoreDataContainer alloc] init];
    });
    return coreDataContainer;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) { //NOTE: mutex
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Talula_X"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
            _persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            _persistentContainer.viewContext.undoManager = nil;
            _persistentContainer.viewContext.shouldDeleteInaccessibleFaults = true;
            _persistentContainer.viewContext.automaticallyMergesChangesFromParent = YES;
        }
    }
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
