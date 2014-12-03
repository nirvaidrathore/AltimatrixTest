//
//  MainViewController.m
//  TestAltimatrix
//
//  Created by Nirvaid on 3/12/14.
//
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "UserDetails.h"

#define UID @"username"
#define PWD @"password"

@interface MainViewController ()
@property(nonatomic,weak) IBOutlet UITextField *nameField,*passwordField;
@property(nonatomic,weak) IBOutlet UIButton *goButton;
@property(nonatomic,weak) IBOutlet UILabel *nameLabel,*passwordLabel;
@property(nonatomic,weak) DetailViewController *detailVC;
@property(nonatomic,strong) UserDetails *userDetail;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nameField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldValueChanged) name:UITextFieldTextDidChangeNotification object:nil];
    _userDetail = [[UserDetails alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    // check if enterd value is in range and length is
    
    [self clearErrorLabels];
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    char check = [string characterAtIndex:0];
    
    if ([self checkIfAlphaNumeric:(int)check])
        return YES;
    
    [self setErrorText:textField error:string];
    
    return NO;
}

-(void)clearErrorLabels{

    [_nameLabel setText:@""];
    [_passwordLabel setText:@""];

}

-(void)setErrorText:(UITextField *)textField error:(NSString *)errorString{

    
    if (textField == _nameField) {
        
        [_nameLabel setText:[NSString stringWithFormat:@"%@ is not allowed",errorString]];
        
    }else{
        
        [_passwordLabel setText:[NSString stringWithFormat:@"%@ is not allowed",errorString]];
        
    }


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (_nameField){

        [_nameField resignFirstResponder];
        [_passwordField becomeFirstResponder];
    
    }else{
    
        [_nameField becomeFirstResponder];
        [_passwordField resignFirstResponder];
        
    }

    return YES;
}

-(BOOL)checkIfAlphaNumeric:(int)text{
    
    //48-57 && 65-90 && 97-122
    if ((text >= 48 && text <= 57) || (text >= 65 && text <= 90) || (text >= 97 && text <= 122)) {
        return YES;
    }
    
    return NO;
}

-(void)enableGO{
    _goButton.enabled = YES;
}

-(IBAction)goclicked{

    if ([_nameField.text isEqualToString:UID] && [_passwordField.text isEqualToString:PWD]) {
    
        //DetailViewController *detail = [[DetailViewController alloc] initWithNibName: bundle:nil];
        [_passwordField resignFirstResponder];
        [_nameField resignFirstResponder];
        
        _userDetail.userName = UID;
        _userDetail.password = PWD;
        
        [self performSegueWithIdentifier:@"detailPushSegue" sender:self];
    
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Wrong Username or Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([[segue identifier] isEqualToString:@"detailPushSegue"]) {
        _detailVC = segue.destinationViewController;
        _detailVC.userDetails = _userDetail;
    }

}


-(void)TextFieldValueChanged{

    if (_nameField.text.length >= 6 && _passwordField.text.length >= 6)
    {
        [self enableGO];
    }
}

@end
