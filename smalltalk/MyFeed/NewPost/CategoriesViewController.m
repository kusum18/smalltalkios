//
//  CategoriesViewController.m
//  smalltalk
//
//  Created by App Jam on 6/7/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

        

@end


@implementation CategoriesViewController

NSArray *arr=nil;
NSMutableArray *boolean;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arr =  [NSArray arrayWithObjects:@"Sports",@"Movies",@"Technology",@"Places",@"Music", nil];
        NSNumber *zero = [NSNumber numberWithInt:0];
        boolean = [NSMutableArray arrayWithObjects:zero,zero,zero,zero,zero, nil];
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

#pragma mark tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSString *tag= [arr objectAtIndex:indexPath.row];
    if([[boolean objectAtIndex:indexPath.row] intValue]==0){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = tag;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arr count];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([[boolean objectAtIndex:indexPath.row] intValue]==0){
        [boolean replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:1]];
    }else{
        [boolean replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:0]];
    }
    [tableView reloadData];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)doneCategories:(id)sender {
    
    [self.delegate setCategories:boolean];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
