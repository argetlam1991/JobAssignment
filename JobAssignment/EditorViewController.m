//
//  EditorViewController.m
//  JobAssignment
//
//  Created by Gu Han on 6/10/17.
//  Copyright © 2017 Gu Han. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@property (strong, nonatomic) NSPersistentContainer *container;
@property (strong, nonatomic) JobEntity *localJobEntitiy;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UITextField *estimatedTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *assigneeTextField;

@property (nonatomic) BOOL wasDeleted;

@end

@implementation EditorViewController

- (void)viewWillAppear:(BOOL)animated {
  self.wasDeleted = NO;
  self.titleTextField.text = self.localJobEntitiy.jobEntityTitle;
  self.descriptionTextView.text = self.localJobEntitiy.jobEntityDescription;
  NSString *estimatedTimeString = [NSString stringWithFormat:@"%.2f", self.localJobEntitiy.jobEntityEstimatedTime];
  self.estimatedTimeTextField.text = estimatedTimeString;
  self.assigneeTextField.text = self.localJobEntitiy.jobEntityAssignee;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidChangeNotification object:self];
}

- (void) textViewDidENdEditing: (NSNotification *) notification {
  if ([notification object] == self) {
    self.localJobEntitiy.jobEntityDescription = self.descriptionTextView.text;
    [self saveJobEntity];
  }
}

- (void) viewWillDisappear:(BOOL)animated {
  if (self.wasDeleted == NO) {
    self.localJobEntitiy.jobEntityTitle = self.titleTextField.text;
    self.localJobEntitiy.jobEntityDescription = self.descriptionTextView.text;
    double estimatedTime = [self.estimatedTimeTextField.text doubleValue];
    self.localJobEntitiy.jobEntityEstimatedTime = estimatedTime;
    self.localJobEntitiy.jobEntityAssignee = self.assigneeTextField.text;
    [self saveJobEntity];
  }
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];

}

- (IBAction)titleFieldEdited:(UITextField *)sender {
  self.localJobEntitiy.jobEntityTitle = self.titleTextField.text;
  [self saveJobEntity];
}

- (IBAction)estimatedTimeFieldEdited:(UITextField *)sender {
  double estimatedTime = [self.estimatedTimeTextField.text doubleValue];
  self.localJobEntitiy.jobEntityEstimatedTime = estimatedTime;
  [self saveJobEntity];
}

- (IBAction)assigneeFieldEdited:(id)sender {
  self.localJobEntitiy.jobEntityAssignee = self.assigneeTextField.text;
  [self saveJobEntity];
}

- (IBAction)trashTapped:(UIBarButtonItem *)sender {
  self.wasDeleted = YES;
  [self.container.viewContext deleteObject:self.localJobEntitiy];
  [self saveJobEntity];
  [self.navigationController popViewControllerAnimated:YES];
}


- (void) saveJobEntity {
  NSError *err;
  BOOL saveSuccess = [self.container.viewContext save:&err];
  if (!saveSuccess) {
    @throw [NSException exceptionWithName:NSGenericException reason:@"Couldn't save" userInfo:@{NSUnderlyingErrorKey:err}];
  }
}


- (void) receiveIncomingContainer:(NSPersistentContainer *)incomingContainer {
  self.container = incomingContainer;
}

- (void) receivceToDoEntity:(JobEntity *)incomingJobEntity {
  self.localJobEntitiy = incomingJobEntity;
}

@end
