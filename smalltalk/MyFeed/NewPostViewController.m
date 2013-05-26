//
//  QAViewController.m
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "NewPostViewController.h"
#import "MentionViewController.h"


@interface NewPostViewController ()

-(void) rePopulateTable;

@end

@implementation NewPostViewController
NSMutableArray *friendsList;
@synthesize phoneBookLabel,taggedFriendsTable,nofriendsLabel,postDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        friendsList = [[NSMutableArray alloc] init];
        self.taggedFriendsTable.bounces=NO;
        self.taggedFriendsTable.scrollEnabled=YES;
        [self.postDetail setDelegate:self];
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

- (IBAction)moveBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushMentions:(id)sender {
    MentionViewController *mention = [[MentionViewController alloc] init];
    [self.navigationController pushViewController:mention animated:YES];
}
- (IBAction)tagFriends:(id)sender {
    MentionViewController *mention = [[MentionViewController alloc] init];
    mention.delegate = self;
    [self presentViewController:mention animated:YES completion:Nil];
}

-(void) rePopulateTable{
    [self.taggedFriendsTable reloadData];
}

-(void) addFriend:(FriendTag *)tag {
//    [self.nofriendsLabel setHidden:YES];
    [self.nofriendsLabel setText:@"Tagged users"];
    [self.taggedFriendsTable setHidden:NO];
    [friendsList addObject:tag];
    [self.taggedFriendsTable reloadData];
    [self.postDetail resignFirstResponder];

}

#pragma mark TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [friendsList count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    FriendTag *tag= [friendsList objectAtIndex:indexPath.row];
    cell.textLabel.text = [tag name];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];

    return view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}

#pragma mark Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
