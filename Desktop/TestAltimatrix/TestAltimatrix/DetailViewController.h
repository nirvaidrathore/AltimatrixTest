//
//  DetailViewController.h
//  TestAltimatrix
//
//  Created by Nirvaid on 3/12/14.
//
//

#import <UIKit/UIKit.h>
#import "UserDetails.h"

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) UserDetails *userDetails;

@end
