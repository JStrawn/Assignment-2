//
//  Company.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* ticker;
@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSString* photo;
-(id)initWithName:(NSString *)name andTicker: (NSString *) title andProducts: (NSMutableArray*)products andImage: (NSString*)photo;
@end
