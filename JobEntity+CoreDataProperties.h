//
//  JobEntity+CoreDataProperties.h
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import "JobEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface JobEntity (CoreDataProperties)

+ (NSFetchRequest<JobEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *jobEntityTitle;
@property (nonatomic) double jobEntityEstimatedTime;
@property (nullable, nonatomic, copy) NSString *jobEntityAssignee;

@end

NS_ASSUME_NONNULL_END
