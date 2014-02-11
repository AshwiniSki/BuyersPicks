//
//  OpenVendor.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 11/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "AppDelegate.h" 

@interface OpenVendor : DatabaseClass<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>
{
    NSArray *dateArray;
    UIButton *vendorImage[5000];
    UIButton *tickmarkButtonlist[5000];
    UIButton *tickmarkButtonlistLand[5000];
    UIButton *tickmarkButtonGrid[5000];
    UIButton *tickmarkButtonGridLand[5000];
    UIImageView *lineImage[5000];
    UIView *viewForList[5000];
    UILabel *vendorName[5000];
    UILabel *vendorDetails[5000];
    
    UIButton *vendorImageLand[5000];
    UIImageView *lineImageLand[5000];
    UIView *viewForListLand[5000];
    UILabel *noteTagLand[5000];
    UILabel *noteTagLabel[5000];
     UILabel *noteTagGrid[5000];
     UILabel *noteTagGridLand[5000];
    UILabel *noteDate[5000];
    UILabel *noteDateLand[5000];
    UITextView *tagTextView[5000];
    UITextField *searchTextField;
    AppDelegate *appD;  // Anish ***********************************************
    
}
@property (nonatomic, strong) NSString *pinCheck;  // Anish ***********************************************
@property (nonatomic, strong) NSString *pinCheckUser;  // Anish

@property (nonatomic,retain)NSMutableArray *deleteItems;
@property (nonatomic)int listAndGridIndex;
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (nonatomic,retain)NSArray *sortedArray;
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;
@property (strong, nonatomic) IBOutlet UIButton *listView;
@property (strong, nonatomic) IBOutlet UIButton *gridView;
@property (strong, nonatomic) IBOutlet UIButton *sortByDate;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *syncButton;
@property (strong, nonatomic) IBOutlet UIScrollView *noteScroller;
@property (strong, nonatomic) IBOutlet UIImageView *tableViewBgImage;
@property (strong, nonatomic) IBOutlet UITableView *sortingTable;
@property (strong, nonatomic) IBOutlet UIButton *deleteNoteButton;
@property (strong, nonatomic) IBOutlet UIButton *offEditModeBtn;
@property (strong, nonatomic) IBOutlet UIButton *offEditModeBtnLand;
@property (strong, nonatomic) IBOutlet UIWebView *adsLand;
@property (strong, nonatomic) IBOutlet UIWebView *ads;
- (IBAction)offEditModeBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *shareNoteButton;
@property (nonatomic)int INDEX;
@property (nonatomic,strong)NSString* vendorTitle;
@property (nonatomic,strong)NSString* vendorDesciption;
@property (nonatomic,strong)NSString* vendorWebsite;
@property (nonatomic,strong)NSString* vendorid;
@property (nonatomic,strong)NSString* vendorname;

@property (strong, nonatomic) IBOutlet UIButton *listViewLand;
@property (strong, nonatomic) IBOutlet UIButton *gridViewLand;
@property (strong, nonatomic) IBOutlet UIButton *sortByDateLand;
@property (strong, nonatomic) IBOutlet UIButton *editButtonLand;
@property (strong, nonatomic) IBOutlet UIButton *syncButtonLand;
@property (strong, nonatomic) IBOutlet UIScrollView *noteScrollerLand;
@property (strong, nonatomic) IBOutlet UIImageView *tableViewBgImageLand;
@property (strong, nonatomic) IBOutlet UITableView *sortingTableLand;
@property (strong, nonatomic) IBOutlet UIButton *deleteNoteButtonLand;
@property (strong, nonatomic) IBOutlet UIButton *shareNoteButtonLand;

- (IBAction)sortByDate:(id)sender;
- (IBAction)displayGridView:(id)sender;
- (IBAction)displayListView:(id)sender;
- (IBAction)syncButton:(id)sender;
- (IBAction)editButton:(id)sender;
- (IBAction)sharedButton:(id)sender;
- (IBAction)deleteVendorButton:(id)sender;
@end
