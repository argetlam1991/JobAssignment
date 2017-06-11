//
//  JobAssignmentTableViewController.m
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import "JobAssignmentTableViewController.h"
#import <CoreData/CoreData.h>
#import "JobTableViewCell.h"
#import "JobEntity+CoreDataClass.h"

@interface JobAssignmentTableViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSPersistentContainer *container;
@property (strong, nonatomic) NSFetchedResultsController *resulltsController;

@end

@implementation JobAssignmentTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initializeNSFetchedResultsControllerDelegate];
  
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.resulltsController.sections[section].numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  JobEntity *item = self.resulltsController.sections[indexPath.section].objects[indexPath.row];
  // Configure the cell...
  JobTableViewCell *cell = (JobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobTableViewCellIdentifier" forIndexPath:indexPath];
  [cell setInernalFields:item];
  return cell;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - NSFetchedResultsCOntrollerDelegate

- (void) initializeNSFetchedResultsControllerDelegate {
  // Initialize FetchRequest
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  fetchRequest.entity = [NSEntityDescription entityForName:@"JobEntity" inManagedObjectContext:self.container.viewContext];
  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
  fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"jobEntityTitle" ascending:YES]];
  // Create NSFetchedResultsController
  self.resulltsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.container.viewContext sectionNameKeyPath:nil cacheName:nil];
  self.resulltsController.delegate = self;
  NSError *err;
  BOOL fetchSucceeded = [self.resulltsController performFetch:&err];
  if (!fetchSucceeded) {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:nil];
  }
}

- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView beginUpdates];
}

- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete:
      [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate: {
      JobTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
      JobEntity *item = [controller objectAtIndexPath:indexPath];
      [cell setInernalFields:item];
      break;
    }
    case NSFetchedResultsChangeMove: {
      [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    }
  }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  
  id<DPHandlesContainer, DPHandlesJobEntity> child = (id<DPHandlesContainer, DPHandlesJobEntity>)[segue destinationViewController];
  
  [child receiveIncomingContainer:self.container];
  
  JobEntity *item;
  if([sender isMemberOfClass:[UIBarButtonItem class]]) {
    item = [NSEntityDescription insertNewObjectForEntityForName:@"JobEntity" inManagedObjectContext:self.container.viewContext];
  } else {
    JobTableViewCell *source = (JobTableViewCell *)sender;
    item = source.localToDoEntity;
  }
  
  [child receivceToDoEntity:item];
  
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}

- (void) receiveIncomingContainer:(NSPersistentContainer *)incomingContainer {
  self.container = incomingContainer;
}

@end
