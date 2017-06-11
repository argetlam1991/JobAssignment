//
//  DPHandlesContainer.h
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol DPHandlesContainer <NSObject>

- (void) receive: (NSPersistentContainer *) incomingContainer;

@end
