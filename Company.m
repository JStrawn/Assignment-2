//
//  Company.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import "Product.h"

@implementation Company
-(id)initWithName:(NSString *)name
        andTicker: (NSString *) ticker
        andProducts: (NSMutableArray*)products
         andImage: (NSString*)photo {
    self.name = name;
    self.ticker = ticker;
    self.products = products;
    self.photo = photo;
    return self;
}
@end
