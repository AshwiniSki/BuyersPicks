//
//  FAQViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 17/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIWebViewDelegate>
{
    NSString *dataForSection[1000];
    NSString *data1[1000];
    NSString *data2[1000];
    UITextField *searchTextField;
}
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (retain, nonatomic) IBOutlet UITableView *faqTable;
@property (retain, nonatomic) NSString *dataForSection0;
@property (retain, nonatomic) NSString *dataForSection2;
@property (retain, nonatomic) NSMutableArray *demoData;
@property (retain, nonatomic) NSMutableArray *ansArray;
@property (nonatomic) int selectedValueIndex;
@property (nonatomic) bool isShowingList;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIImageView *underlineImage;
@property (strong, nonatomic) IBOutlet UIWebView *ads;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator1;

@end
