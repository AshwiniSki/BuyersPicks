//
//  GlobalClass.m
//  Dabaang2Application
//
//  Created by Javed Sunesra on 11/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GlobalClass.h"

@implementation GlobalClass

@synthesize fetchall;
@synthesize vendorid1,IAPStatus,VenID,CHECK_CATALOG,CHECK_NETWORK,industryname,industryIDfromGC;
static GlobalClass *instance=nil;
static GlobalClass *instance2 =nil; 

+(GlobalClass *)getInstance    
{    
	@synchronized(self)    
	{    
		if(instance==nil)    
		{    
			
			instance= [GlobalClass new];    
		}    
	}    
	return instance;    
}    


+(GlobalClass *)onset    
{    
	@synchronized(self)    
	{    
		if(instance2==nil)    
		{    
			
			instance2= [GlobalClass new];    
		}    
	}    
	return instance2;    
}    



@end
