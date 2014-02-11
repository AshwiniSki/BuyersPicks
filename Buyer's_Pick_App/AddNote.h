//
//  AddNote.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 24/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyLocation.h"
#import "annotation1.h"

#define METERS_PER_MILE 1609.344
#import "DatabaseClass.h"
#import "DataFwdClass.h"
#import "GlobalClass.h"
#import "AppDelegate.h"


@interface AddNote : DatabaseClass<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIWebViewDelegate,UITextViewDelegate>
{
    UIImageView *frame[1000];
    UITextField *tagField[1000];
    BOOL _doneInitialZoom;
    CLLocationCoordinate2D theCoordinate;
    CLLocationManager *currentLocation;
    NSString                *CurrentLatitude;
    NSString                *CurrentLongitude;
    NSString *locationString;
    
    float CurrentLatitudeValue;
    float CurrentLongitudeValue;
    NSMutableArray              *Map_Annotaions;
//    NSArray *ContactsArray;
    NSString* vendorTitle;
    NSString* vendorDesciption;
    NSString* vendorWebsite;
    DataFwdClass *dataFwdObj;
    UIButton *cardScannerButton;
    UIButton *barcodeReaderButton;
    int check;
    
    UILabel *addressLabel[10];
    UILabel *address[10];
    UILabel *websiteLabel[10];
    UILabel *websites[10];
    UILabel *emailLabel[10];
    UILabel *emails[10];
    UILabel *contactLabel[10];
    UILabel *contacts[10];
    UIImageView *lineImage[10];
    UIButton *editBtn[10];
//    NSMutableArray *industryArray;
//    NSMutableArray  *industryid;
    AppDelegate *appD;
}

@property (nonatomic,strong)NSString* calledfromopenvendor;
//@property (nonatomic, retain) NSArray *ContactsArray;
//@property (nonatomic, retain) NSArray *EmailIDArray;
//@property (nonatomic, retain) NSArray *AddressArray;
//@property (nonatomic, retain) NSArray *WebsiteArray;
@property (nonatomic, retain) NSMutableArray *tagsArray;
@property (nonatomic, retain) NSMutableArray *displayTagsArray;
@property (nonatomic) float yAxis;
@property (nonatomic) float xAxis;
@property (nonatomic) float strLength ;
@property (nonatomic)int numOfInfo;
@property (strong, nonatomic) IBOutlet UIScrollView *tagTextView;



@property (strong, nonatomic) NSMutableString *tagTextViewString;
//@property (strong, nonatomic) NSMutableString *websiteTextViewString;
//@property (strong, nonatomic) NSMutableString *emailIdTextViewString;
//@property (strong, nonatomic) NSMutableString *contactNoTextViewString;
//@property (strong, nonatomic) NSMutableString *addressTextViewString;

@property (nonatomic,strong) NSString* vendorTagsString;
//@property (nonatomic,strong) NSString* vendorContactsString;
//@property (nonatomic,strong) NSString* vendorEmailIdString;
//@property (nonatomic,strong) NSString* vendorAddressString;
//@property (nonatomic,strong) NSString* vendorWebsiteString;
@property (nonatomic,strong) NSString*  SHORTCUTCLICKED;



@property (nonatomic,strong)NSString* TAG;
@property (nonatomic,strong)NSString* vendorTitle;
@property (nonatomic,strong)NSString* vendorDesciption;
@property (nonatomic,strong)NSString* vendorWebsite;
@property (nonatomic,strong)NSString* vendorid;
@property (nonatomic,strong)NSString* vendorName;



@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray              *Map_Annotaions;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScroller;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *selectIndustryLabel;

@property (strong, nonatomic) IBOutlet UITextView *currentLocationTextView;
@property (strong, nonatomic) NSMutableArray *noteArray;
@property (strong, nonatomic) IBOutlet UIScrollView *noteScroller;

@property (strong, nonatomic) IBOutlet UIImageView *titleBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *selectIndusBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *tagBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *mapIcon;
@property (strong, nonatomic) IBOutlet UIImageView *currntLocBgImage;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentLocLabel;
@property (strong, nonatomic) IBOutlet UIButton *tagButton;

@property (strong, nonatomic) IBOutlet UIButton *addContactBtn;
//@property (strong, nonatomic) IBOutlet UIImageView *mapImage;
@property (strong, nonatomic) IBOutlet UITableView *selectIndustryTbl;

@property (nonatomic, retain) NSMutableArray *industryArray;
@property (nonatomic, retain) NSMutableArray  *industryid;

@property (strong, nonatomic) IBOutlet UIImageView *contactInfoBgImage;
@property (strong, nonatomic) IBOutlet UIScrollView *contactInfoScroller;





- (IBAction)addContactBtn:(id)sender;

- (IBAction)tagButton:(id)sender;

@end
