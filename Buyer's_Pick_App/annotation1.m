//
//  annotation1.m
//  Dabangg2App
//
//  Created by Javed Sunesra on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "annotation1.h"

@implementation annotation1
@synthesize title;
@synthesize subtitle;
@synthesize coordinate=_coordinate;


- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andID:(NSUInteger)pinID{
	self = [super init];
	if (self != nil) {
		_coordinate = coordinate;
		_pinID = pinID;
	}
	return self;
}

- (NSString *)title {
	return [NSString stringWithFormat:@"%@", title];
}

- (NSString *)subtitle {
	return [NSString stringWithFormat:@"%@", subtitle];
}


-(NSString *) reuseIdentifier {
    return @"annotation1Identifier";
    
}
@end
