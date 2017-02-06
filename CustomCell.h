//
//  CustomCell.h
//  NavCtrl
//
//  Created by Juliana Strawn on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIView *companyImageView;
@property (retain, nonatomic) IBOutlet UIImageView *companyImage;
@property (retain, nonatomic) IBOutlet UILabel *companyName;
@property (retain, nonatomic) IBOutlet UILabel *stockPrice;

@end
