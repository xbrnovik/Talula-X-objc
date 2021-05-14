//
//  MeteoriteCellModel.h
//  Talula X
//
//  Created by Diana Brnovik on 13/05/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CDMeteorite+CoreDataProperties.h"
#import "CDMeteorite+CoreDataClass.h"
#import "Meteorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeteoriteCellModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *massRounded;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) UIImage *icon;

- (void)setupFromCDMeteorite:(CDMeteorite *)meteorite;
- (void)setupFromMeteorite:(Meteorite *)meteorite;

@end

NS_ASSUME_NONNULL_END
