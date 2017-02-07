//
//  Product.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product
-(id)initWithName: (NSString*)name andImage: (NSString*)image andURL:(NSString*)url
{
    self = [super init];
    self.name = name;
    self.image = image;
    self.url = url;
    return self;
}

-(void)dealloc {
    [_name release];
    [_image release];
    [_url release];
    [super dealloc];
}
@end
