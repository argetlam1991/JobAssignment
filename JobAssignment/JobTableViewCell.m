//
//  JobTableViewCell.m
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import "JobTableViewCell.h"
@interface JobTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobAssigneeLabel;


@end

@implementation JobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setInernalFields:(JobEntity *)incomingToDoEntity {
  self.localToDoEntity = incomingToDoEntity;
  self.jobTitleLabel.text = self.localToDoEntity.jobEntityTitle;
  self.jobAssigneeLabel.text = self.localToDoEntity.jobEntityAssignee;
}
@end
