//
//  ListViewCell.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 02/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell
@synthesize cellImageView,cellLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
