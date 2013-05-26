//
//  MyFeedViewController.m
//  smalltalk
//
//  Created by App Jam on 5/10/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "MyFeedViewController.h"
#import "NewPostViewController.h"
#import "QuestionCell.h"
#import "QAViewController.h"
#import "AnswersParser.h"
#import "Constants.h"

@interface MyFeedViewController ()

@end

@implementation MyFeedViewController

@synthesize postsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"message.png"];
        self.tabBarItem.title=@"Browse Q's";
        self.postsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 10.0f)] ;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    QuestionCell *cell = (QuestionCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.postme setText:@"Post text"];
    [cell.postme setNumberOfLines:0];
    [cell.postme sizeToFit];
    [cell.titleLabel setText:@"Title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

#pragma mark Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QAViewController *qavc = [[QAViewController alloc] init];
    [self.navigationController pushViewController:qavc animated:YES];
//    AnswersParser *p = [[AnswersParser alloc] init];
//    [p getAllAnswersForQuestion:1];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)WriteQuestion:(id)sender {
    NewPostViewController *qa = [[NewPostViewController alloc] init];
    [self.navigationController pushViewController:qa animated:YES];
}
@end
