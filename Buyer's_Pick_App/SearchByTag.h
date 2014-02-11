//
//  SearchByTag.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 29/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"

@interface SearchByTag :  DatabaseClass<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    UIButton *vendorImage[5000];
    UIImageView *lineImage[5000];
    UIView *viewForList[5000];
    UILabel *vendorName[5000];
    UILabel *vendorTitle[5000];
    UILabel *vendorDate[5000];
    UILabel *vendorDetails[5000];
    
    
    UIButton *vendorImageLand[5000];
    UIImageView *lineImageLand[5000];
    UIView *viewForListLand[5000];
    UILabel *vendorNameLand[5000];
    UILabel *vendorTitleLand[5000];
    UILabel *vendorDateLand[5000];
    UILabel *vendorDetailsLand[5000];
    UIImageView *imageOnVendorGrid[5000];
    UIImageView *imageOnVendorList[5000];
    
    UITextField *searchTextField;
}
@property (nonatomic)int orientationChanged;

@property (nonatomic,strong)NSString* tagSearch;
@property (nonatomic,strong)NSString* TAG;
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (nonatomic)int totalVendors;
@property (nonatomic)int INDEX;
@property (nonatomic)int listAndGridIndex;
@property (nonatomic,retain)NSArray *sortedArray;

@property (strong, nonatomic) IBOutlet UIButton *listView;
@property (strong, nonatomic) IBOutlet UIButton *gridView;
@property (strong, nonatomic) IBOutlet UIButton *sortByDate;
@property (strong, nonatomic) IBOutlet UIButton *syncButton;
@property (strong, nonatomic) IBOutlet UIScrollView *vendorScroller;
@property (strong, nonatomic) IBOutlet UIImageView *tableViewBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *headerLineImage;
@property (strong, nonatomic) IBOutlet UITextField *searchTextFld1;
@property (strong, nonatomic) IBOutlet UITableView *sortingTable;
@property (strong, nonatomic) IBOutlet UIButton *listViewLand;
@property (strong, nonatomic) IBOutlet UIButton *gridViewLand;
@property (strong, nonatomic) IBOutlet UIButton *sortByDateLand;
@property (strong, nonatomic) IBOutlet UIButton *syncButtonLand;
@property (strong, nonatomic) IBOutlet UIScrollView *vendorScrollerLand;
@property (strong, nonatomic) IBOutlet UIImageView *tableViewBgImageLand;
@property (strong, nonatomic) IBOutlet UITableView *sortingTableLand;


- (IBAction)sortByDate:(id)sender;
- (IBAction)displayGridView:(id)sender;
- (IBAction)displayListView:(id)sender;
- (IBAction)syncButton:(id)sender;

@end
