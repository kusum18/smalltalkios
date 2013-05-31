//
//  QACell.h
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QAViewController.h"

@interface QACell : UITableViewCell{
    QAViewController *_delegate;
}

@property (strong,nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet UIButton *acceptAnswer;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;

- (IBAction)acceptAnswer:(id)sender;
@end
