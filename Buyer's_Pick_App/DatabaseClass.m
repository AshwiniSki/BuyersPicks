//
//  DatabaseClass.m
//  Dabangg2App
//
//  Created by Javed Sunesra on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatabaseClass.h"
#import "CameraAudioVideoNote.h"

@interface DatabaseClass ()

@end

@implementation DatabaseClass
@synthesize Email,userName,lastNameUser;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self DATABASECALLED];
      

    // Do any additional setup after loading the view from its nib.
}

-(void)DATABASECALLED1
{
	NSString *docsDir;
	NSArray *dirPaths;
	
	// Get the documents directory
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	docsDir = [dirPaths objectAtIndex:0];
	
	// Build the path to the database file
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"App.db"]];
	
	NSFileManager *filemgr = [NSFileManager defaultManager];
	
	if ([filemgr fileExistsAtPath: databasePath ] == NO)
	{
		const char *dbpath = [databasePath UTF8String];
		
		if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
		{
			char *errMsg;
			const char *sql_stmt = "CREATE TABLE IF NOT EXISTS USER (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT,  PHONE TEXT, EMAIL TEXT, USERNAME TEXT, IMAGE BLOB)";
			
			if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
			{
				NSLog(@"DB CREATED");
			}
			
			sqlite3_close(contactDB);
			
		} else {
		}
	}
	
	
	
	NSLog(@"reached");
    
}
-(void)DATABASECALLED
{
	NSLog(@"DB");
	
	NSString *docsDir;
	NSArray *dirPaths;
	
	// Get the documents directory
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	docsDir = [dirPaths objectAtIndex:0];
	
	// Build the path to the database file
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"BuyersPicks.sqlite"]];
    NSLog(@"reach0");

	NSFileManager *filemgr = [NSFileManager defaultManager];
	
	if ([filemgr fileExistsAtPath: databasePath ] == NO)
	{
		const char *dbpath = [databasePath UTF8String];
        NSLog(@"reach1");

		if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
		{
            NSLog(@"reach2");
			char *errMsg;
			//const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PROPERTY (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, agentId NUMERIC, ADDRESS TEXT, CITY TEXT)";
			const char *ba_tbl_user = "CREATE TABLE IF NOT EXISTS ba_tbl_user (id INTEGER PRIMARY KEY , email VARCHAR, password VARCHAR, f_name VARCHAR,l_name VARCHAR, device VARCHAR, last_login TIMESTAMP, active INTEGER, created_date TIMESTAMP, verification_key VARCHAR, active_date TIMESTAMP, old_password VARCHAR, last_modified TIMESTAMP, created_by VARCHAR, subscribtion_type VARCHAR, user_type VARCHAR, security_pin VARCHAR, password_mod INTEGER)";
			//const char *LoginTable= "CREATE TABLE IF NOT EXISTS VALIDUSER (agentId NUMERIC,EMAIL TEXT, FIRSTNAME TEXT, LASTNAME TEXT, APIKey TEXT)";
			const char *ba_tbl_vendor_MASTER="CREATE TABLE IF NOT EXISTS ba_tbl_vendor_master (id INTEGER PRIMARY KEY , vendor_name VARCHAR, user_id VARCHAR,vendor_title VARCHAR,   tags TEXT, created_date TIMESTAMP, description TEXT,  security_pin VARCHAR, old_security_pin VARCHAR, last_modified_security_pin TIMESTAMP, geo_latitude VARCHAR, geo_longitude VARCHAR, last_modified_date TIMESTAMP, is_deleted INTEGER, delete_date TIMESTAMP, industry_id VARCHAR, current_location VARCHAR, path VARCHAR, sync_status INTEGER)";
            
            
            
            const char *ba_tbl_vendor="CREATE TABLE IF NOT EXISTS ba_tbl_vendor (id INTEGER PRIMARY KEY  , vendor_id VARCHAR,  website VARCHAR,  email_id VARCHAR, address VARCHAR, contact_no VARCHAR,sync_status INTEGER,street1 TEXT, street2 TEXT,city VARCHAR, state VARCHAR, country VARCHAR)";
            
            
            
            
             const char *ba_tbl_user_type_master="CREATE TABLE IF NOT EXISTS ba_tbl_user_type_master(id INTEGER PRIMARY KEY , user_type VARCHAR,created_date TIMESTAMP, is_deleted INTEGER, last_modified Timestamp)";
            
			const char *ba_tbl_content = "CREATE TABLE IF NOT EXISTS ba_tbl_content (id INTEGER PRIMARY KEY , content_name VARCHAR, vendor_id VARCHAR, industry_id VARCHAR, tags TEXT, title VARCHAR, content_size FLOAT, description TEXT, website VARCHAR, created_date TIMESTAMP, update_date TIMESTAMP, is_deleted INTEGER, delete_date TIMESTAMP, path VARCHAR, type VARCHAR,sync_status INTEGER, cloud_path VARCHAR)";
            
            
            //	const char *appointments = " CREATE TABLE IF NOT EXISTS APPOINTMENTS(id INTEGER PRIMARY KEY, clientId NUMERIC, agentId NUMERIC, start_time BLOB, end_time BLOB, status TEXT)";
          const char *ba_tbl_plan_master = "CREATE TABLE IF NOT EXISTS ba_tbl_plan_master (id INTEGER PRIMARY KEY AUTOINCREMENT, plan VARCHAR, created_date TIMESTAMP, active INTEGER, last_modified TIMESTAMP, plan_tags INTEGER, size_allocated FLOAT)";
            
            
            
            const char *ba_tbl_feature_master = "CREATE TABLE IF NOT EXISTS ba_tbl_feature_master (id INTEGER PRIMARY KEY AUTOINCREMENT, feature VARCHAR, created_date TIMESTAMP, active INTEGER, last_modified TIMESTAMP)";
            

            
            const char *tbl_vendor_share = "CREATE TABLE IF NOT EXISTS tbl_vendor_share (id INTEGER PRIMARY KEY AUTOINCREMENT, vendor_id VARCHAR, share_with VARCHAR, share_date TIMESTAMP, description TEXT, share_remove_date TIMESTAMP, share_email VARCHAR)";
            
            
            const char *ba_tbl_feature_plan = "CREATE TABLE IF NOT EXISTS ba_tbl_feature_plan (id INTEGER PRIMARY KEY AUTOINCREMENT, feature_id VARCHAR, plan_id VARCHAR, created_date TIMESTAMP, active INTEGER, last_modified TIMESTAMP)";

            
             const char *tbl_user_history = "CREATE TABLE IF NOT EXISTS tbl_user_history (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id VARCHAR, action VARCHAR, timestamp TIMESTAMP)";

            
            
            const char *ba_tbl_plan_user = "CREATE TABLE IF NOT EXISTS ba_tbl_plan_user (id INTEGER PRIMARY KEY AUTOINCREMENT, plan_id VARCHAR, user_id VARCHAR, created_date TIMESTAMP,active INTEGER, last_modified TIMESTAMP)";
            
            
         

            

            const char *ba_tbl_industry_master = "CREATE TABLE IF NOT EXISTS ba_tbl_industry_master (id INTEGER PRIMARY KEY , industry VARCHAR, created_date TIMESTAMP, is_deleted ENUM(0,1), last_modified TIMESTAMP)";
            
            const char *ba_tbl_link_content = "CREATE TABLE IF NOT EXISTS ba_tbl_link_content (id INTEGER PRIMARY KEY AUTOINCREMENT, content_id VARCHAR, industry_id VARCHAR, brand_id VARCHAR, gender VARCHAR, gender_visible ENUM(0,1), created_date TIMESTAMP, is_deleted ENUM(0,1), last_modified TIMESTAMP, delete_date TIMESTAMP)";
            
            const char *ba_tbl_brand_master = "CREATE TABLE IF NOT EXISTS ba_tbl_brand_master (id INTEGER PRIMARY KEY AUTOINCREMENT, brand VARCHAR, created_date TIMESTAMP, is_deleted ENUM(0,1), last_modified TIMESTAMP, delete_date TIMESTAMP,industry_id INTEGER, created_by VARCHAR)";
            
            
            const char *ba_tbl_related_link_content = "CREATE TABLE IF NOT EXISTS ba_tbl_related_link_content (id INTEGER PRIMARY KEY , attibute_id VARCHAR, content_id VARCHAR, value VARCHAR, last_modified TIMESTAMP, is_deleted VARCHAR)";
            
            
            
            const char *ba_tbl_attributes = "CREATE TABLE IF NOT EXISTS ba_tbl_attributes (id INTEGER PRIMARY KEY , attibute VARCHAR, display_attribute VARCHAR, industry_id VARCHAR, last_modified TIMESTAMP, is_deleted VARCHAR, master_attibute_id VARCHAR, created_by VARCHAR)";


            
            
            

			
			do
				do
					do
                        do
                            do
                                
                                 do
                                   
                                     do
                                         
                                         do
                                     
                                             do
                                                 
                                                do
                                                   do
                                                       do
                                                           do
                                                               do
                                                                   do
                                                                       
                                if(sqlite3_exec(contactDB, ba_tbl_vendor,  NULL, NULL, &errMsg) != SQLITE_OK)
                                    
                                {
                                    //	status.text = @"Failed to create table";
                                    NSLog(@" TABLEs CREATED");
                                }
            while(sqlite3_exec(contactDB, ba_tbl_industry_master,  NULL, NULL, &errMsg) != SQLITE_OK);
            while(sqlite3_exec(contactDB, ba_tbl_link_content,  NULL, NULL, &errMsg) != SQLITE_OK);
            while(sqlite3_exec(contactDB, ba_tbl_brand_master,  NULL, NULL, &errMsg) != SQLITE_OK);
            while(sqlite3_exec(contactDB, ba_tbl_related_link_content,  NULL, NULL, &errMsg) != SQLITE_OK);
            while(sqlite3_exec(contactDB, ba_tbl_attributes,  NULL, NULL, &errMsg) != SQLITE_OK);


            while(sqlite3_exec(contactDB, ba_tbl_vendor_MASTER,  NULL, NULL, &errMsg) != SQLITE_OK);

			while(sqlite3_exec(contactDB, ba_tbl_user_type_master,  NULL, NULL, &errMsg) != SQLITE_OK);
			while(sqlite3_exec(contactDB, ba_tbl_user,  NULL, NULL, &errMsg) != SQLITE_OK);
			while (sqlite3_exec(contactDB, ba_tbl_content,  NULL, NULL, &errMsg) != SQLITE_OK);
			while(sqlite3_exec(contactDB, ba_tbl_plan_master,  NULL, NULL, &errMsg) != SQLITE_OK);
            
            
            
            while(sqlite3_exec(contactDB, ba_tbl_feature_master,  NULL, NULL, &errMsg) != SQLITE_OK);
			while(sqlite3_exec(contactDB, tbl_vendor_share,  NULL, NULL, &errMsg) != SQLITE_OK);
			while(sqlite3_exec(contactDB, ba_tbl_feature_plan,  NULL, NULL, &errMsg) != SQLITE_OK);
			while(sqlite3_exec(contactDB, tbl_user_history,  NULL, NULL, &errMsg) != SQLITE_OK);
			while(sqlite3_exec(contactDB, ba_tbl_plan_user,  NULL, NULL, &errMsg) != SQLITE_OK);

            
		}	
        else {
			NSLog(@"Tables already exists");
        }
		sqlite3_close(contactDB);	
        
	}
    
    
    
   
}

-(void)saveData:(NSString*)insertSQL1
{
    NSLog(@"query==%@",insertSQL1);

	sqlite3_stmt    *statement;
	
	const char *dbpath = [databasePath UTF8String];
	
	if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
	{
		const char *insert_stmt = [insertSQL1 UTF8String];
		
		sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
            NSLog(@"query inserted");
		} else {
            NSLog(@"query not inserted");
		}
		sqlite3_finalize(statement);
		sqlite3_close(contactDB);
        
	}
}



-(void)displayAll:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK) 
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
              //  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                
                MobileNo = [NSString stringWithFormat:@"%@",Field1];
                
            //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
			}
			NSLog(@"MOB=%@",MobileNo);
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)displayAllVendorsInDB:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *Field0 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
                NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3) ];
                NSString *Field4 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 4) ];
                
                
                dataid[i] = [NSString stringWithFormat:@"%@",Field0];
                
                datapath[i] = [NSString stringWithFormat:@"%@",Field1];
                datatype[i] = [NSString stringWithFormat:@"%@",Field2];
                datatitle[i] = [NSString stringWithFormat:@"%@",Field3];
                datadate[i] = [NSString stringWithFormat:@"%@",Field4];
                
                //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
                
                
                NSLog(@"dataid=%@",dataid[i]);
                
                NSLog(@"datapath=%@",datapath[i]);
                
                NSLog(@"datatitle=%@",datatitle[i]);
                
                i++;
			}
            
            TotalData=i;
            NSLog(@"TotalData=%d",TotalData);
            
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)displayVideoData:(NSString*)qSQL
{
    
    NSLog(@"qSQL=%@",qSQL);
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
            int i=0;
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
				NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
				NSString *Field4 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3) ];
				NSString *Field5 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 4) ];
				NSString *Field6 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 5) ];
				NSString *Field7 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 6) ];
				NSString *Field8 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 7) ];
//				NSString *Field9 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 8) ];
//				NSString *Field10 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement,9) ];
//              NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                
                data1[i] = [NSString stringWithFormat:@"%@",Field1];
                data2[i] = [NSString stringWithFormat:@"%@",Field2];
                data3[i] = [NSString stringWithFormat:@"%@",Field3];
                data4[i] = [NSString stringWithFormat:@"%@",Field4];
                data5[i] = [NSString stringWithFormat:@"%@",Field5];
                data6[i] = [NSString stringWithFormat:@"%@",Field6];
                data7[i] = [NSString stringWithFormat:@"%@",Field7];
                data8[i] = [NSString stringWithFormat:@"%@",Field8];
//                data9[i] = [NSString stringWithFormat:@"%@",Field9];
//                data10[i] = [NSString stringWithFormat:@"%@",Field10];

                //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
                
                
                i++;
                
			}
            TotalData=i;
			NSLog(@"TotalData=%d",TotalData);
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)displayContentData:(NSString*)qSQL
{
    NSLog(@"displayContentData=%@",qSQL);
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *Field0 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];

				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
                NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3) ];
                
                dataid[i] = [NSString stringWithFormat:@"%@",Field0];

                datapath[i] = [NSString stringWithFormat:@"%@",Field1];
                datatype[i] = [NSString stringWithFormat:@"%@",Field2];
                datadateNote[i] = [NSString stringWithFormat:@"%@",Field3];

                //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
                
                
                NSLog(@"dataid=%@",dataid[i]);

                NSLog(@"datapath=%@",datapath[i]);
                
                NSLog(@"datatype=%@",datatype[i]);

                i++;
			}
            
            TotalData=i;
            NSLog(@"TotalData=%d",TotalData);

			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)displayImageForVendor:(NSString*)qSQL
{
    NSLog(@"displayContentData=%@",qSQL);
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *Field0 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
                
                
                
                imageIdForVendor[i] = [NSString stringWithFormat:@"%@",Field0];
                imageForVendor[i] = [NSString stringWithFormat:@"%@",Field1];
                imageTypeForVendor[i] = [NSString stringWithFormat:@"%@",Field2];
                
                //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
                
                
                
                i++;
			}
            
            TotalImages=i;
            NSLog(@"TotalData=%d",TotalImages);
            
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)displaySelctedVendor:(NSString*)qSQL
{
    NSLog(@"qSQL=%@",qSQL);
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
                
              const  char *tmp = (const char*)sqlite3_column_text(statement, 0);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendoridDB[i] = [NSString stringWithFormat:@"%@",Field0];

                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 1);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendornameDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }

                tmp = (const char*)sqlite3_column_text(statement, 2);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendordescDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 3);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorWebsitesDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 4);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorTagsDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }

                
                tmp = (const char*)sqlite3_column_text(statement, 5);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorEmailIdDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }

                tmp = (const char*)sqlite3_column_text(statement, 6);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorAddressDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 7);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorContactnoDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 8);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendortitleDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                


                tmp = (const char*)sqlite3_column_text(statement, 9);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorLatitudeDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 10);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorLongitudeDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 11);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    vendorLocationDB[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
//                
//                NSString *Field0 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
//                
//				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
//                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
//                NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3) ];
//                
//                NSString *Field4 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 4) ];
//                
//				NSString *Field5 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 5) ];
//                NSString *Field6 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 6) ];
//                NSString *Field7 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 7) ];
//                
//                
//                NSString *Field8 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 8) ];
                
                //				NSString *Field9 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 9) ];
                //                NSString *Field10 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 10) ];
                //                NSString *Field11 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 11) ];
                //
                //
                //
                //                NSString *Field12=[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 12) ];
                //
                //				NSString *Field13 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 13) ];
                //                NSString *Field14 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 14) ];
                //                NSString *Field15 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 15) ];
                //
                //
                //
                //
                //                NSString *Field16 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 16) ];
                //
                //				NSString *Field17=[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 17) ];
                
//                vendoridDB[i] = [NSString stringWithFormat:@"%@",Field0];
//                
//                vendornameDB[i] = [NSString stringWithFormat:@"%@",Field1];
//                vendordescDB[i] = [NSString stringWithFormat:@"%@",Field2];
//                vendorWebsitesDB[i] = [NSString stringWithFormat:@"%@",Field3];
//                vendorTagsDB[i] = [NSString stringWithFormat:@"%@",Field4];
//                vendorEmailIdDB[i] = [NSString stringWithFormat:@"%@",Field5];
//                vendorAddressDB[i] = [NSString stringWithFormat:@"%@",Field6];
//                vendorContactnoDB[i] = [NSString stringWithFormat:@"%@",Field7];
                //                vendorContactnoDB[i] = [NSString stringWithFormat:@"%@",Field3];
                //                vendorContactnoDB[i] = [NSString stringWithFormat:@"%@",Field3];
                //                vendorContactnoDB[i] = [NSString stringWithFormat:@"%@",Field3];
                
                //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
                
                
                //                NSLog(@"vendorname=%@",dataid[i]);
                //
                //                NSLog(@"vendordesc=%@",datapath[i]);
                
//                NSLog(@"vendorContactno=%@",vendorContactnoDB[i]);
                
                i++;
			}
            
            TotalData=i;
            NSLog(@"TotalData=%d",TotalData);
            
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)displayBlockeduser:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	
    int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                //  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                
                Blockedusers[i] = [NSString stringWithFormat:@"%@",Field1];
                //  ProfilePic = [[NSString stringWithFormat:@"%@",Field2] retain];
                
                i++;
			}
            totalblockedusers=i;
			NSLog(@"MOB=%d",totalblockedusers);
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)getMusicLib:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	 int i = 0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK) 
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
           
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];

                //  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                WebViewLinks[i] = [NSString stringWithFormat:@"%@",Field1];

                MusicLinks[i] = [NSString stringWithFormat:@"%@",Field2];
                
                IsDownloaded[i] = [NSString stringWithFormat:@"%@",Field3];
                
            
                NSLog(@"d=%@",IsDownloaded[i]);
                i++;
                
			}
            NumOfRows = i;
            NSLog(@"NumOfRows=%d",NumOfRows);

			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)getRingtoneLib:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
    int i = 0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK) 
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
            
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
                
                //  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                WebViewRingtoneLinks[i] = [NSString stringWithFormat:@"%@",Field1];
                
                MusicLinks[i] = [NSString stringWithFormat:@"%@",Field2];
                
                IsDownloaded[i] = [NSString stringWithFormat:@"%@",Field3];
                
                
                NSLog(@"d=%@",IsDownloaded[i]);
                i++;
                
			}
            NumOfRows = i;
            NSLog(@"NumOfRows=%d",NumOfRows);
            
			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)getPhotoGallery:(NSString*)qSQL
{
	NSLog(@"getPhotoGallery");
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
    int i = 0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK) 
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			NSLog(@"getPhotoGallery");

            
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSLog(@"getPhotoGallery");

				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
				NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
				NSString *Field4 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3) ];
				NSString *Field5 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 4) ];

                
                //  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                smallwallpaper[i] = [NSString stringWithFormat:@"%@",Field1];
                
                
                Bigwallpaper[i] = [NSString stringWithFormat:@"%@",Field2];
				
				wallpapertype[i] = [NSString stringWithFormat:@"%@",Field3];
				IsImageDownloaded[i] = [NSString stringWithFormat:@"%@",Field4];


				wallpaperID = [NSString stringWithFormat:@"%@",Field5];
                
                NSLog(@"isimage=%@",IsImageDownloaded[i]);
			NSLog(@"wallpaperID=%@",wallpaperID);

                i++;
                
			}
            	NSLog(@"getPhotoGallery");

            
            NumOfRows = i;
            
            NSLog(@"NumOfRows=%d",NumOfRows);
			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)getChat:(NSString*)qSQL
{
	NSLog(@"getchat=%@",qSQL);
	const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i = 0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			NSLog(@"getPhotoGallery");
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSLog(@"getPhotoGallery");
				
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
				NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
				NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
				NSString *Field4 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3) ];
				NSString *Field5 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 4) ];
				NSString *Field6 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 5) ];

				
				//  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
				USERNAME[i] = [NSString stringWithFormat:@"%@",Field1];
				
				
				MESSAGE[i] = [NSString stringWithFormat:@"%@",Field2];
				
				DATE[i] = [NSString stringWithFormat:@"%@",Field3];
				TIME[i] = [NSString stringWithFormat:@"%@",Field4];
				
				
				MESSAGEID[i] = [NSString stringWithFormat:@"%@",Field5];
				USERID[i] = [NSString stringWithFormat:@"%@",Field6];

				NSLog(@"USERNAME=%@",USERNAME[i]);
				
				i++;
				
			}
			
			
			NumOfRows = i;
			
			NSLog(@"NumOfRows=%d",NumOfRows);
			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)getMaxID:(NSString*)qSQL
{
	NSLog(@"getchat");
	const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			NSLog(@"getPhotoGallery");
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSLog(@"getPhotoGallery");
				
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSLog(@"MAKID=%@",Field1);

//				if([Field1 isEqualToString:@""])
//				{
//					MAXID=[NSString stringWithFormat:@"0"];
//
//				}
//				else{
				MAXID=[NSString stringWithFormat:@"%@",Field1];
							
			//	}
			}
			
			NSLog(@"MAKID=%@",MAXID);

			
			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)getProfileDetails:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt   *statement;
    if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
    {
        const char *q_stmt =[qSQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
            
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
				NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
				NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
                
                //  NSString Field2 =[[NSString alloc] initWithUTF8String:(const char)sqlite3_column_text(statement, 1) ];
                userName = [NSString stringWithFormat:@"%@",Field1];
                Email = [NSString stringWithFormat:@"%@",Field2];
                lastNameUser = [NSString stringWithFormat:@"%@",Field3];
                
                
                NSLog(@"userName=%@",userName);
                NSLog(@"Email=%@",Email);
                
            }
            
            
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}


-(void)SwitchDetails:(NSString*)qSQL
{
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK) 
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
            
			while (sqlite3_step(statement)==SQLITE_ROW) {
				NSString *Field1 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0) ];
                NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                NSString *Field3 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2) ];
                
                //  NSString *Field2 =[[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1) ];
                set[0] = [NSString stringWithFormat:@"%@",Field1];
                
                set[1] = [NSString stringWithFormat:@"%@",Field2];
                
                set[2] = [NSString stringWithFormat:@"%@",Field3];
                
           
                
			}
            
			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)displayCHATUSER:(NSString*)qSQL
{
    
}
////////  DISPLAY ALL DATA FROM TABLE ba_tbl_vendor_master ///////////////////////////////////////Akshay
#pragma mark get Data From ba_tbl_vendor_master


-(void)getDataFrom_ba_tbl_vendor_master:(NSString*)qSQL;
{
    NSLog(@"qSQL=%@",qSQL);
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
                
                const  char *tmp = (const char*)sqlite3_column_text(statement, 0);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data1[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 1);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data2[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 2);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data3[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 3);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data4[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 4);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data5[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 5);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data6[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 6);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data7[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 7);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data8[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 8);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data9[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 9);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data10[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 10);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data11[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 11);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data12[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
        
                
                tmp = (const char*)sqlite3_column_text(statement, 12);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data13[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 13);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data14[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 14);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data15[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                tmp = (const char*)sqlite3_column_text(statement, 15);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data16[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                tmp = (const char*)sqlite3_column_text(statement, 16);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data17[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 17);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data18[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 18);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data19[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
//                
//                tmp = (const char*)sqlite3_column_text(statement, 19);
//                if (tmp == NULL)
//                {
//                    
//                }
//                else
//                {
//                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
//                    data20[i] = [NSString stringWithFormat:@"%@",Field0];
//                    
//                }
//                
//
//                
//                
//                
//                tmp = (const char*)sqlite3_column_text(statement, 20);
//                if (tmp == NULL)
//                {
//                    
//                }
//                else
//                {
//                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
//                    data21[i] = [NSString stringWithFormat:@"%@",Field0];
//                    
//                }
//                
//
//                
//                tmp = (const char*)sqlite3_column_text(statement, 23);
//                if (tmp == NULL)
//                {
//                    
//                }
//                else
//                {
//                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
//                    data22[i] = [NSString stringWithFormat:@"%@",Field0];
//                    
//                }
//                

                
                            

                
                
                i++;
			}
            
            TotalData=i;
            NSLog(@"TotalData=%d",TotalData);
            
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
    
}


#pragma mark get Data From ba_tbl_content

-(void)getDataFrom_ba_tbl_content:(NSString*)qSQL;
{
    NSLog(@"qSQL=%@",qSQL);
    const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt   *statement;
	int i=0;
	if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
	{
		const char *q_stmt =[qSQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
			
			while (sqlite3_step(statement)==SQLITE_ROW) {
                
                const  char *tmp = (const char*)sqlite3_column_text(statement, 0);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data1[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 1);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data2[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 2);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data3[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 3);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data4[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 4);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data5[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 5);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data6[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 6);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data7[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 7);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data8[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 8);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data9[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 9);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data10[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 10);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data11[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 11);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data12[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
      
                
                
                tmp = (const char*)sqlite3_column_text(statement, 12);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data13[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                tmp = (const char*)sqlite3_column_text(statement, 13);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data14[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 14);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data15[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                tmp = (const char*)sqlite3_column_text(statement, 15);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data16[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }
                
                
                tmp = (const char*)sqlite3_column_text(statement, 16);
                if (tmp == NULL)
                {
                    
                }
                else
                {
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    data17[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                }

                
                
                i++;
			}
            
            TotalData=i;
            NSLog(@"TotalData=%d",TotalData);
            
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


#pragma mark get Data From ba_tbl_vendor



-(void)getDataFrom_ba_tbl_vendor:(NSString*)qSQL;

{
    
    NSLog(@"qSQL=%@",qSQL);
    
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt   *statement;
    
    int i=0;
    
    if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
        
    {
        
        const char *q_stmt =[qSQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
            
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                
                
                const  char *tmp = (const char*)sqlite3_column_text(statement, 0);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data1[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 1);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data2[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 2);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data3[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 3);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data4[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 4);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data5[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 5);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data6[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 6);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data7[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 7);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data8[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 8);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data9[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 9);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data10[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 10);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data11[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 11);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data12[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                i++;
                
            }
            
            
            
            TotalData=i;
            
            NSLog(@"TotalData=%d",TotalData);
            
            
            
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(contactDB);
        
    }
    
    
}










#pragma mark get Data From ba_tbl_industry_master



-(void)getDataFrom_ba_tbl_industry_master:(NSString*)qSQL;

{
    
    NSLog(@"qSQL=%@",qSQL);
    
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt   *statement;
    
    int i=0;
    
    if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
        
    {
        
        const char *q_stmt =[qSQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
            
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                
                
                const  char *tmp = (const char*)sqlite3_column_text(statement, 0);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data1[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 1);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data2[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 2);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data3[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 3);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data4[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 4);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data5[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                       
                
                i++;
                
            }
            
            
            
            TotalData=i;
            
            NSLog(@"TotalData=%d",TotalData);
            
            
            
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(contactDB);
        
    }
    
    
}






#pragma mark get Data From ba_tbl_attributes



-(void)getDataFrom_ba_tbl_attributes:(NSString*)qSQL;

{
    
    NSLog(@"qSQL=%@",qSQL);
    
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt   *statement;
    
    int i=0;
    
    if (sqlite3_open(dbpath, &contactDB)== SQLITE_OK)
        
    {
        
        const char *q_stmt =[qSQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, q_stmt, -1, &statement, NULL)==SQLITE_OK) {
            
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                
                
                const  char *tmp = (const char*)sqlite3_column_text(statement, 0);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data1[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 1);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data2[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 2);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data3[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 3);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data4[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 4);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data5[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 5);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data6[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 6);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data7[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                
                
                tmp = (const char*)sqlite3_column_text(statement, 7);
                
                if (tmp == NULL)
                    
                {
                    
                    
                    
                }
                
                else
                    
                {
                    
                    NSString *Field0 =[[NSString alloc] initWithUTF8String:tmp];
                    
                    data8[i] = [NSString stringWithFormat:@"%@",Field0];
                    
                    
                    
                }
                
                
                
                i++;
                
            }
            
            
            
            TotalData=i;
            
            NSLog(@"TotalData=%d",TotalData);
            
            
            
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(contactDB);
        
    }
    
    
}






@end
