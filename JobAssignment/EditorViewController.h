//
//  EditorViewController.h
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesContainer.h"
#import "DPHandlesJobEntity.h"
#import "JobEntity+CoreDataClass.h"

@interface EditorViewController : UIViewController <DPHandlesContainer, DPHandlesJobEntity>
- (void) receiveIncomingContainer:(NSPersistentContainer *)incomingContainer;
- (void) receivceToDoEntity:(JobEntity *)incomingJobEntity;

@end
