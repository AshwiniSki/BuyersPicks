//
//  noteTableCell.h
//  Buyer's_Pick_App
//
//  Created by Anish on 1/9/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noteTableCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UILabel *noteTableCellTextView;

@end
