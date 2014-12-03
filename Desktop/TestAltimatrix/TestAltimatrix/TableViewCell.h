//
//  TableViewCell.h
//  TestAltimatrix
//
//  Created by Nirvaid on 3/12/14.
//
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *username;
@property(nonatomic,weak) IBOutlet UIImageView *image;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activity;
@end
