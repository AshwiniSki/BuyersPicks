//
//  DataFwdClass.h
//  Buyer's_Pick_App
//
//  Created by Anish on 1/10/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFwdClass : NSObject
{
    NSMutableArray *noteTagsArray;
    NSString *fieldCalled;
}
@property (nonatomic,retain) NSMutableArray *noteTagsArray;
@property (nonatomic,retain) NSString *fieldCalled;
+(DataFwdClass *)getInstance;

@end
