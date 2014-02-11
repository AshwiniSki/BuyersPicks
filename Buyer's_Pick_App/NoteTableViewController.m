//
//  NoteTableViewController.m
//  Buyer's_Pick_App
//
//  Created by Anish on 1/9/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "NoteTableViewController.h"
#import "noteTableCell.h"

@interface NoteTableViewController ()

@end

@implementation NoteTableViewController
@synthesize tableView = _tableView;
@synthesize searchBar,isFiltered,addedTableView,addedTags,addingTagslable,names;

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
    // Do any additional setup after loading the view from its nib.
    dataFwdObj=[DataFwdClass getInstance];
    // Do any additional setup after loading the view from its nib.
    searchedNames = [[NSMutableArray alloc] init];
    names = [[NSMutableArray alloc] init];

    addedTags = [[NSMutableArray alloc] initWithArray:dataFwdObj.noteTagsArray];
    NSLog(@"dataFwdObj.noteTagsArray2 %@",dataFwdObj.noteTagsArray);
//    names = [[NSMutableArray alloc]initWithObjects:@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar",@"Akshay Jain",@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar",@"Akshay Jain", nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 48, 477, 609) style:UITableViewStylePlain];
    
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    _tableView.separatorColor = [UIColor grayColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.hidden = YES;
    [self.addingTagslable addSubview:_tableView];
    
    addedTableView.layer.cornerRadius = 10.0;
    addedTableView.clipsToBounds = YES;
    _tableView.layer.cornerRadius = 10.0;
    _tableView.clipsToBounds = YES;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,477,44)];
    searchBar.placeholder=@"Search by Customer Name";
    searchBar.backgroundColor = [UIColor darkGrayColor];
    searchBar.delegate = (id)self;
    [self.addingTagslable addSubview:searchBar];

    UIImage *doneImage = [UIImage imageNamed:@"done.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 3, 64, 37);
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    [self.navigationItem setLeftBarButtonItem:customBarItemDone];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select  tags  from ba_tbl_vendor_master"];
    
    [self displayAll:fetchdata];
    
    names = [ MobileNo componentsSeparatedByString:@","];
    
    
    NSLog(@"names aray ************** =%d , %@",names.count,names);
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}

//-(void)done
//{
//    dataFwdObj=[DataFwdClass getInstance];
//    [dataFwdObj.noteTagsArray removeAllObjects];
//    dataFwdObj.noteTagsArray = [[NSMutableArray alloc] initWithArray:addedTags];
//    NSLog(@"Back Btn dataFwdObj.noteTagsArray: %@", dataFwdObj.noteTagsArray);
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    //	if(self.isFiltered)
    if (tableView == addedTableView) {
        return @"Current Tags";
    }
    
    return @"Tag List";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (tableView==addedTableView)
    {
        return 1;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"total=%d",[names count]);
	int rowCount;
    if (tableView==addedTableView) {
        rowCount=[addedTags count];
    }
    else
    {
        if(self.isFiltered)
            rowCount = searchedNames.count;
        else
            rowCount = names.count;
    }
	
	return rowCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"sorting by date";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
	NSString    *name;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    if (tableView==addedTableView)
    {
        cell.textLabel.text=[addedTags objectAtIndex:indexPath.row];
    }
    else{
        if(isFiltered){
            name = [searchedNames objectAtIndex:indexPath.row];
        }
        else{
            name = [names objectAtIndex:indexPath.row];
            
        }
        
        cell.textLabel.text=name;
        
    }
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView)
    {
        searchBar.text=[names objectAtIndex:indexPath.row];
        [self.searchBar resignFirstResponder];
    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView==addedTableView)
        {
            [addedTags removeObjectAtIndex:indexPath.row];
            [addedTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [addedTableView reloadData];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==addedTableView)
    {
        return @"Remove";
    }
    
    return nil;
}

-(IBAction)AddTagPressed
{
    if (searchBar.text.length==0) {
        NSLog(@"Baba ji ka Thullu");
    }
    else
    {
        NSString *Tag= searchBar.text;
        [addedTags addObject:Tag];
        //[names addObject:Tag];
        addedTableView.hidden=NO;
        _tableView.hidden=YES;
        [self.searchBar resignFirstResponder];
        searchBar.text=nil;
        
        [addedTableView reloadData];
        // [_tableView reloadData];
    }
}


#pragma mark Search Functions
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	NSLog(@"hi");
    addedTableView.hidden=YES;
    _tableView.hidden=NO;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    addedTableView.hidden=NO;
    _tableView.hidden=YES;
    [self.searchBar resignFirstResponder];
}


-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
	if(text.length == 0)
	{
		isFiltered = FALSE;
	}
	else
	{
		isFiltered = true;
		searchedNames = [[NSMutableArray alloc] init];
		
		for (NSString* food in names)
		{
			NSRange nameRange = [food rangeOfString:text options:NSCaseInsensitiveSearch];
			NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
			if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
			{
				[searchedNames addObject:food];
			}
		}
	}
	
	[_tableView reloadData];
}

-(IBAction)BackBtnPressed
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray = addedTags;
    NSLog(@"Back Btn dataFwdObj.noteTagsArray: %@", dataFwdObj.noteTagsArray);
    // [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tagsUpdateNotifier" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end