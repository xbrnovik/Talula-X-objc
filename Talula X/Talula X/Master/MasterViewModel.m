//
//  MasterViewModel.m
//  Talula X
//
//  Created by Diana Brnovik on 11/05/2021.
//

#import "MasterViewModel.h"

@interface MasterViewModel ()

//TODO @property serviceHolder
@property (weak, nonatomic) MasterViewController * controller;

@end

@implementation MasterViewModel

- (NSArray<NSString *> *) places
{
    return  @[@"Bratislava", @"Brno", @"Košice"];
}

- (instancetype)initWithServiceHolder:(MasterViewController *)serviceHolder //TODO serviceHolder
                           controller:(MasterViewController *)controller
{
    //TODO set serviceHolder property
    _controller = controller;
    self = [super init];
    if (self) {
        //NOTE: set delegates
    }
    return self;
}


@end
