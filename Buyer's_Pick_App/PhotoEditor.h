//
//  PhotoEditor.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 07/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "AFPhotoEditorController.h"
#import "AFPhotoEditorCustomization.h"
#import "DatabaseClass.h"

@interface PhotoEditor : DatabaseClass <UIGestureRecognizerDelegate,AFPhotoEditorControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UIImageView *bgImageCustmFldsScroller[1000];
    UITextField *custmTextField[1000];
    UIImageView *bgImageCustmFldsScroller1;
    UITextField *custmTextField1;
    NSMutableArray  *obj1;
    NSMutableArray  *obj2;


}

@property (nonatomic,strong)NSString* TAG;
@property(nonatomic,retain) NSString    *DATATYPE;
@property(nonatomic,retain) NSString    *DATAPATH;
@property(nonatomic,retain) NSString    *DATAID;
@property(nonatomic)int yDistance;
@property(nonatomic,retain) NSMutableArray    *editOptionsArray;
@property (strong, nonatomic) IBOutlet UIImageView *imageToEdit;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBgImage;
@property (strong, nonatomic) IBOutlet UIScrollView *optionsScroller;
@property (strong, nonatomic) IBOutlet UIButton *addCustmFldsInTbl;
@property (strong, nonatomic) IBOutlet UIButton *addCustmFldsInScrll;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;
@property (strong, nonatomic) IBOutlet UILabel *beltLabel;
@property (strong, nonatomic) IBOutlet UILabel *availabilityLabel;
@property (strong, nonatomic) IBOutlet UILabel *briefDescLabel;

@property (strong, nonatomic) IBOutlet UITextField *productTextFld;
@property (strong, nonatomic) IBOutlet UITextField *priceTextFld;
@property (strong, nonatomic) IBOutlet UITextField *QuantityTextFld;
@property (strong, nonatomic) IBOutlet UITextField *modelTextFld;
@property (strong, nonatomic) IBOutlet UITextField *CertifctnTextFld;
@property (strong, nonatomic) IBOutlet UITextField *minOrderTextFld;
@property (strong, nonatomic) IBOutlet UITextField *paymentTextFld;
@property (strong, nonatomic) IBOutlet UITextField *manufacturerTextFld;
@property (weak, nonatomic) IBOutlet UIImageView *changeIndustrybgImage;
- (IBAction)addCustmFldsInTbl:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *changeIndustrylabel;
@property (weak, nonatomic) IBOutlet UIImageView *addColorbgImage;
@property (weak, nonatomic) IBOutlet UILabel *addColorlabel;
- (IBAction)addDetailsButton:(id)sender;
- (IBAction)addCustmFldsinScrll:(id)sender;
@end
