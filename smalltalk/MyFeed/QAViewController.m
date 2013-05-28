    //
//  QAViewController.m
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "QAViewController.h"
#import "QA.h"
#import "Constants.h"
#import "AnswersParser.h"
#import "NewAnswerViewController.h"

@interface QAViewController ()

@property (nonatomic,retain) NSMutableArray *posts;

@end

@implementation QAViewController

@synthesize posts=_posts,postTable,loader;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _posts = [[NSMutableArray alloc] init];
        [[HttpManager alloc] initWithURL:[NSURL URLWithString:AnswersURl ] delegate:self];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [_posts count];
    return count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"postcell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.imageView.image = [UIImage imageNamed:@"search.png"];
        cell.textLabel.numberOfLines = 0;
    }
    QA *tag= [_posts objectAtIndex:indexPath.row];
    cell.textLabel.text = [tag postText];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize textSize = [[[_posts objectAtIndex:indexPath.row] postText]  sizeWithFont:[UIFont boldSystemFontOfSize:15]
                        constrainedToSize:CGSizeMake(300, 2000)
                        lineBreakMode:UILineBreakModeWordWrap];
    return textSize.height+20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Question Shall be here";
}


#pragma mark Answers delegate methods
-(void) answersList:(NSArray *)answers{
    _posts = [NSMutableArray arrayWithArray:answers];
    [self.postTable reloadData];
    
}

#pragma mark http manager delegate
- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
    NSArray *objs = [dict objectForKey:@"questions"];
    [_posts removeAllObjects];
    for (NSDictionary *posts in objs) {
        QA *qa = [[QA alloc] init];
        qa.count = [posts objectForKey:@"count"];
        qa.postText = [posts objectForKey:@"post_text"];
        qa.userinfo = [posts objectForKey:@"user_info"];
        qa.postid = [posts objectForKey:@"id"];
        [_posts addObject:qa];
    }
    [self.postTable setHidden:NO];
    [self.loader stopAnimating];
    [self.postTable reloadData];
}
-(void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"Error");
}

#pragma mark user actions

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)writeAnswer:(id)sender {
    NewAnswerViewController *controller = [[NewAnswerViewController alloc] init];
    controller.question_id = [[_posts objectAtIndex:0] postid];
    controller.question_text = [[_posts objectAtIndex:0] postText];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
