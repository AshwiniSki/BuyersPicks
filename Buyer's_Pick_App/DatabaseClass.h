//
//  DatabaseClass.h
//  Dabangg2App
//
//  Created by Javed Sunesra on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface DatabaseClass : UIViewController

{
    NSString                    *databasePath;
    sqlite3                     *contactDB;
    NSString                    *MobileNo;
    NSString                    *imageLinks[500];
    NSString                    *MusicLinks[500];
    NSString                    *IsDownloaded[500];
    NSString            *WebViewLinks[500];
    NSString            *WebViewImageLinks[500];
	NSString			*smallwallpaper[1000];
	NSString			*Bigwallpaper[1000];
	NSString			*wallpapertype[1000];
	NSString				*wallpaperID;
    NSString			*vendorLatitudeDB[1000];
    NSString			*vendorLongitudeDB[1000];
    NSString			*vendorLocationDB[1000];
    NSString            *IsImageDownloaded[500];
    NSString            *WebViewRingtoneLinks[50];
    NSString            *Email;
    NSString    *set[5];
	
	
	NSString            *MESSAGEID[50000];
	NSString            *MESSAGE[50000];
	NSString            *DATE[50000];
	NSString            *TIME[50000];
	NSString            *USERNAME[50000];
	NSString            *USERID[50000];
	NSString			*MAXID;
    
    NSString            *Blockedusers[500];
    int  totalblockedusers;

	NSString			*CHATUSERNAME;
	NSString			*CHATPASSWORD;
    
    
    NSString			*dataid[1000];

    NSString			*datatype[1000];
	NSString			*datapath[1000];
    NSString			*datatitle[1000];
    
    NSString			*datadate[1000];
    NSString			*datadateNote[1000];
     NSString			*noteTag[1000];

    int numberOfItems;

    
    
    NSString			*vendoridDB[1000];
    
    NSString			*vendornameDB[1000];
	NSString			*vendordescDB[1000];
    NSString             *vendorContactnoDB[1000];
    NSString             *vendortitleDB[1000];



	//NSString    *set[5];


    int                         NumOfRows;
    int TotalData;
    
    NSString* data1[1000];
	NSString* data2[1000];
	NSString* data3[1000];
	
	NSString* data4[1000];
	
	NSString* data5[1000];
	NSString* data6[1000];
	NSString* data7[1000];
	NSString* data8[1000];
    
    NSString* data9[1000];
	NSString* data10[1000];
	NSString* data11[1000];
    NSString* data12[1000];
    
    NSString* data13[1000];
	NSString* data14[1000];
    NSString* data15[1000];
    
    NSString* data16[1000];
    NSString* data17[1000];
    NSString* data18[1000];
    NSString* data19[1000];
    NSString* data20[1000];
    NSString* data21[1000];
    NSString* data22[1000];
    NSString* data23[1000];
    NSString* data24[1000];
    NSString* data25[1000];
    NSString* data26[1000];
    NSString* data27[1000];
    NSString* data28[1000];
    NSString* data29[1000];
    NSString* data30[1000];

    
    
    NSString			*vendorTagsDB[1000];
    NSString			*vendorEmailIdDB[1000];
    NSString			*vendorAddressDB[1000];
    // NSString			*vendorContactsDB[1000];
    NSString			*vendorWebsitesDB[1000];
    
    NSString *userName;
    NSString *lastNameUser;
    int   TotalContentData;


    int TotalImages;
    NSString *imageForVendor[5000];
    NSString *imageIdForVendor[5000];
    NSString *imageTypeForVendor[5000];
    
    
}

@property (nonatomic,retain) NSString *Email;
@property (nonatomic,retain)NSString *userName;
@property (nonatomic,retain)NSString *lastNameUser;

-(void)displayImageForVendor:(NSString*)qSQL;
-(void)getDataFrom_ba_tbl_attributes:(NSString*)qSQL;


-(void)getDataFrom_ba_tbl_vendor_master:(NSString*)qSQL;
-(void)getDataFrom_ba_tbl_content:(NSString*)qSQL;

-(void)getDataFrom_ba_tbl_vendor:(NSString*)qSQL;

-(void)displayContentData:(NSString*)qSQL;
-(void)displayAllVendorsInDB:(NSString*)qSQL;
-(void)DATABASECALLED;
-(void)displayCHATUSER:(NSString*)qSQL;
-(void)displayVideoData:(NSString*)qSQL;

-(void)saveData:(NSString*)insertSQL1;
-(void)displayAll:(NSString*)qSQL;
-(void)getMusicLib:(NSString*)qSQL;
-(void)getRingtoneLib:(NSString*)qSQL;
-(void)getPhotoGallery:(NSString*)qSQL;
-(void)getProfileDetails:(NSString*)qSQL;
-(void)SwitchDetails:(NSString*)qSQL;
-(void)getChat:(NSString*)qSQL;
-(void)displayBlockeduser:(NSString*)qSQL;
-(void)getMaxID:(NSString*)qSQL;
-(void)displaySelctedVendor:(NSString*)qSQL;
-(void)getDataFrom_ba_tbl_industry_master:(NSString*)qSQL;


@end
