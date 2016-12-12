//
//  Product.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

//name, weburl (string), and image (string)
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* image;
@property (strong, nonatomic) NSString* url;
-(id)initWithName: (NSString*)name andImage: (NSString*)image andURL:(NSString*)url;

@end
