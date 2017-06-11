//
//  JobTableViewCell.h
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesJobEntity.h"
#import "JobEntity+CoreDataClass.h"

@interface JobTableViewCell : UITableViewCell
@property (strong, nonatomic) JobEntity *localToDoEntity;
- (void) setInernalFields: (JobEntity *)incomingToDoEntity;

@end
