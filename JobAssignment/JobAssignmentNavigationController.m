//
//  JobAssignmentNavigationController.m
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import "JobAssignmentNavigationController.h"

@interface JobAssignmentNavigationController ()

@property (strong, nonatomic) NSPersistentContainer *container;

@end

@implementation JobAssignmentNavigationController

- (void) receiveIncomingContainer:(NSPersistentContainer *)incomingContainer {
  self.container = incomingContainer;
  id<DPHandlesContainer> child = (id<DPHandlesContainer>) self.viewControllers[0];
  [child receiveIncomingContainer:self.container];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
