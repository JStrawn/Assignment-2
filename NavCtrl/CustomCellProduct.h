//
//  CustomCellProduct.h
//  NavCtrl
//
//  Created by Juliana Strawn on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellProduct : UITableViewCell
@property (retain, nonatomic) IBOutlet UIView *productImageView;
@property (retain, nonatomic) IBOutlet UIImageView *productImage;
@property (retain, nonatomic) IBOutlet UILabel *productName;

@end
