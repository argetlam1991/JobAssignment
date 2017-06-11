//
//  JobEntity+CoreDataProperties.m
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import "JobEntity+CoreDataProperties.h"

@implementation JobEntity (CoreDataProperties)

+ (NSFetchRequest<JobEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"JobEntity"];
}

@dynamic jobEntityTitle;
@dynamic jobEntityEstimatedTime;
@dynamic jobEntityAssignee;
@dynamic jobEntityDescription;

@end
