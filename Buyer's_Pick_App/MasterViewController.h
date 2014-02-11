//
//  MasterViewController.h
//  MasterDetail


#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
@class DetailViewController;
#import "DDMenuController.h"
#import "DatabaseClass.h"

@interface MasterViewController : UITableViewController<UIGestureRecognizerDelegate>
{
    UIImageView *userPic;
}
@property(nonatomic,retain)UIImageView *userPic;
@property(nonatomic,retain)DatabaseClass *dataBase;
@end
