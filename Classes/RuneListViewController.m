//
//  RuneListViewController.m
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneListViewController.h"
#import "Constants.h"
#import "RuneLibraryDataModel.h"
#import "RuneListCellViewController.h"
#import "Utility.h"
#import "RunemalAppDelegate.h"
#import "RuneListDetailsController.h"
#import "RuneDetailsPageController.h"

@implementation RuneListViewController

@synthesize runeData;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
	
	self.runeData = [Utility GetRuneList];
	
	NSLog(@"The rune count in controller is: %d", [self.runeData count]);
	self.navigationItem.title = @"The Runes";
	
    [super viewDidLoad];	


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.separatorColor = [UIColor blackColor];


    return [self.runeData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	NSUInteger row = [indexPath row]; 

    static NSString *CellIdentifier = @"runeCell";
    
    RuneListCellViewController *cell = (RuneListCellViewController*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) { 
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RuneListCellView" owner:self options:nil]; 
		cell = [nib objectAtIndex:0]; 
    } 
    
    // Set up the cell...
	
	NSDictionary *item = [self.runeData objectAtIndex:row];
	
	cell.runeName.text = [item objectForKey:kBaseDescription];
	cell.runeImage.image = [UIImage imageNamed:[item objectForKey:kIconImagePath]];
	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath 
{
	[Utility PlayAudioClick:click];
	NSUInteger row = [indexPath row]; 
	NSDictionary *item = [self.runeData objectAtIndex:row];
	/*
	
	RuneListDetailsController *controller = [[RuneListDetailsController alloc] initWithNibName:@"RuneListDetailsView" bundle:[NSBundle mainBundle]];
	
	NSLog([item objectForKey:kShortDescription]);
	controller.theRune = item;
	*/
	
	//RuneDetailsPageController *controller = [[RuneDetailsPageController alloc] initWithNibName:@"RuneDetailsPagesView" bundle:[NSBundle mainBundle]];
	RuneListDetailsController *controller = [[RuneListDetailsController alloc] initWithDetails:0 :@"RuneListDetailsView" :item];
	controller.title = @"Rune Details";
    RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
    [delegate.navController pushViewController:controller animated:YES]; 
	[controller release];	
	
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView  accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath 
{ 
    return UITableViewCellAccessoryDetailDisclosureButton; 
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (CGFloat) tableView:( UITableView *) tableView heightForRowAtIndexPath:(  NSIndexPath *) indexPath { 
    return 71; 
}

- (void)dealloc {
	[runeData release];
    [super dealloc];
}


@end

