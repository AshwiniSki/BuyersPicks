//
//  noteTableCell.m
//  Buyer's_Pick_App
//
//  Created by Anish on 1/9/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "noteTableCell.h"

@implementation noteTableCell
@synthesize noteTableCellTextView;

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
