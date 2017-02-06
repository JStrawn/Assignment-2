//
//  CustomCellProduct.m
//  NavCtrl
//
//  Created by Juliana Strawn on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CustomCellProduct.h"

@implementation CustomCellProduct

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_productImageView release];
    [_productImage release];
    [_productName release];
    [super dealloc];
}
@end
