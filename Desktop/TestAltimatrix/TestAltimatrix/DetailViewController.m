//
//  DetailViewController.m
//  TestAltimatrix
//
//  Created by Nirvaid on 3/12/14.
//
//

#import "DetailViewController.h"
#import "TableViewCell.h"

static NSString *CellIdentifier = @"CustomCellReuse";

@interface DetailViewController ()
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic) UIImage *userImage;
@property(nonatomic,weak) IBOutlet UIImageView *enlargedImage;
@end

@implementation DetailViewController
@synthesize userDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        userDetails = [[UserDetails alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
     [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self addgestureToImage];
    [self fetchImage];
    // Do any additional setup after loading the view from its nib.
}

-(void)addgestureToImage{

    [_enlargedImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    recognizer.delegate = self;
    recognizer.numberOfTapsRequired = 1;
    [_enlargedImage addGestureRecognizer:recognizer];
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer {

    [_enlargedImage setHidden:YES];
     [_tableView setHidden:NO];
    [self.view bringSubviewToFront:_tableView];
}


-(void)fetchImage{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/4/45/Terra_globe_icon.png"]];
        _userImage = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TABLE VIEW METHODS

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    TableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.username.text = userDetails.userName;
    if (_userImage) {
        [cell.activity  stopAnimating];
        [cell.imageView setImage:_userImage];
    }else{
        [cell.activity  startAnimating];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200.0;
}

#pragma 


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_userImage) {
        [_enlargedImage setImage:_userImage];
        [_enlargedImage setHidden:NO];
        [_tableView setHidden:YES];
        [self.view bringSubviewToFront:_enlargedImage];
        [self.view sendSubviewToBack:_tableView];
    }

}

@end
