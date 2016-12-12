//
//  DAO.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/12/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAO : NSObject
@property (nonatomic, retain) NSMutableArray *companyList;
+ (id)sharedManager ;
@end
