//
//  CategoriesViewController.h
//  smalltalk
//
//  Created by App Jam on 6/7/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPostViewController.h"

@interface CategoriesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *done;
- (IBAction)doneCategories:(id)sender;

@property (nonatomic,retain) NewPostViewController* delegate;
@end
