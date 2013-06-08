

//
//  QAViewController.m
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "NewPostViewController.h"
#import "MentionViewController.h"
#import "Constants.h"
#import "plist.h"
#import "CategoriesViewController.h"


@interface NewPostViewController ()

-(void) rePopulateTable;

@end

@implementation NewPostViewController
NSMutableArray *friendsList,*categoryList;
@synthesize phoneBookLabel,taggedFriendsTable,nofriendsLabel,postDetail;
@synthesize postTitleLabel;

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
    NSString *_friendsList = @"", *_catList = @"";
    NSString *_delimeter = @"";
    for (FriendTag *tag in friendsList) {
        _friendsList = [_friendsList stringByAppendingString:_delimeter];
        _friendsList = [_friendsList  stringByAppendingString:tag.userid];
        _delimeter = @",";
    }
    
    _delimeter = @"";
    for (NSNumber *tag in categoryList) {
        _catList = [_catList stringByAppendingString:_delimeter];
        _catList = [_catList  stringByAppendingString:[NSString stringWithFormat:@"%d",[tag intValue]]];
        _delimeter = @",";
    }
    NSString *userId = [plist getValueforKey:C_UserId];
    NSString *bodydata = [NSString stringWithFormat:@"UID=%@&title=%@&detail=%@&tagged_ppl=%@&categories=%@",
                                                    userId,
                                                    postTitleLabel.text,
                                                    postDetail.text,
                                                    _friendsList,
                                                    _catList];
    [[HttpManager alloc] initWithPOSTURL:[NSURL URLWithString:newQuestionURL] delegate:self forPostData:bodydata];
}

- (IBAction)addCategories:(id)sender {
    CategoriesViewController *viewvc = [[CategoriesViewController alloc] init];
    viewvc.delegate = self;
    [self.navigationController pushViewController:viewvc animated:YES];
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


#pragma mark http manger delegates

- (void) connectionDidFinish:(HttpManager *)theConnection{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"Error: Notifications");
}

-(void) setCategories:(NSMutableArray *)categories{
    categoryList  = categories;
    
}

@end
