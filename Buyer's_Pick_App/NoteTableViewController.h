//
//  NoteTableViewController.h
//  Buyer's_Pick_App
//
//  Created by Anish on 1/9/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "noteTableCell.h"
#import "DataFwdClass.h"
#import "DatabaseClass.h"

@interface NoteTableViewController : DatabaseClass<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    UITableView*  _tableView;
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
    
    NSMutableArray *searchedNames;
	NSMutableArray *names;
    DataFwdClass *dataFwdObj;

    
}
@property(nonatomic, retain)NSMutableArray* addedTags;
@property(nonatomic, retain)NSMutableArray* names;


@property (nonatomic)     BOOL    isFiltered;
@property (nonatomic, retain) 	 UISearchBar *searchBar;
@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain) IBOutlet UITableView* addedTableView;
@property(nonatomic, retain) IBOutlet UIView* addingTagslable;

-(IBAction)BackBtnPressed;
-(IBAction)AddTagPressed;
- (id)initWithFrame:(CGRect)frame;


@end
