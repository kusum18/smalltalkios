//
//  GeoPostItViewController.m
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "GeoPostItViewController.h"
#import "PostItViewController.h"
#import "Location.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>
#import "GeoPost.h"

@interface GeoPostItViewController ()
{
    CLLocationCoordinate2D _location;
    NSMutableArray *_geoposts;
    CLLocationManager *locationManager;
    NSMutableArray *_posts;

}

-(void) locateLatitudeLongitude;

-(void) fetchAllNotes;

- (CLLocationCoordinate2D ) getCurrentLocation;

@end

@implementation GeoPostItViewController

@synthesize notesTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"map-pin.png"];
        self.tabBarItem.title=@"Geo Info";
        _geoposts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self locateLatitudeLongitude];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
//    [locationManager startUpdatingLocation];
    [self fetchAllNotes];
}

-(void)viewWillDisappear:(BOOL)animated{
    [locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_geoposts count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
        return @"Notes posted at this location";
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.textLabel setText:[[_geoposts objectAtIndex:indexPath.row] postText]];
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [[_geoposts objectAtIndex:indexPath.row] postText];
    CGSize textSize = [str                       sizeWithFont:[UIFont boldSystemFontOfSize:18]
                       constrainedToSize:CGSizeMake(300, 2000)
                       lineBreakMode:UILineBreakModeWordWrap];
    return textSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

#pragma mark Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)write:(id)sender {
    NSLog(@"log me");
    [self.navigationController pushViewController:[[PostItViewController alloc] init] animated:YES];
}


#pragma mark http manager delegate


- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
    NSArray *objs = [dict objectForKey:@"notes"];
    [_geoposts removeAllObjects];
    for (NSDictionary *posts in objs) {
        GeoPost *post = [[GeoPost alloc] init];
        post.likes = [posts objectForKey:@"notes_likes"];
        post.latitude = [posts objectForKey:@"distance"];
        post.place = [posts objectForKey:@"place"];
        post.postId = [posts objectForKey:@"notes_id"];
        post.postText = [posts objectForKey:@"notes_text"];
        [_geoposts addObject:post];
    }
    [self.notesTable reloadData];

}

-(void) connectionDidFail:(HttpManager *)theConnection{

    
}


#pragma mark data loads

-(void) fetchAllNotes{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",fetchAllNotesURL,@"1",@"2"];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:url] delegate:self];
    
}

-(void) locateLatitudeLongitude{
    _location = [self getCurrentLocation];
}

- (CLLocationCoordinate2D ) getCurrentLocation{
    if (!locationManager) {
        //        [self initializeLocationManager];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        
    }else{
        //        [locationManager startUpdatingLocation];
    }
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
//    [locationManager stopUpdatingLocation];
    return coordinate;
    
}


@end
