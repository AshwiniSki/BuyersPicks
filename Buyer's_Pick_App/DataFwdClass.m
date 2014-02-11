//
//  DataFwdClass.m
//  Buyer's_Pick_App
//
//  Created by Anish on 1/10/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "DataFwdClass.h"

@implementation DataFwdClass
@synthesize noteTagsArray,fieldCalled;
static DataFwdClass *instance=nil;
static DataFwdClass *instance2 =nil;

+(DataFwdClass *)getInstance
{
	@synchronized(self)
	{
		if(instance==nil)
		{
			
			instance= [DataFwdClass new];
		}
	}
	return instance;
}
@end
