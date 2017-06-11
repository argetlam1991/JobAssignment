//
//  JobAssignmentNavigationController.h
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesContainer.h"
@interface JobAssignmentNavigationController : UINavigationController <DPHandlesContainer>

- (void) receiveIncomingContainer:(NSPersistentContainer *)incomingContainer;

@end
