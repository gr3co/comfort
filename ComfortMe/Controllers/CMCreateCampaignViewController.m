//
//  CMCreateCampaignViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCreateCampaignViewController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "CMColors.h"
#import "CMMainViewController.h"

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface CMCreateCampaignViewController ()

@end

@implementation CMCreateCampaignViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupAddImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat topOffset = 0;
    
    topOffset = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 10;
    
    UIColor *floatingLabelColor = [CMColors mainColor];
    
    JVFloatLabeledTextField *titleField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(kJVFieldHMargin, topOffset, self.view.frame.size.width - 2 * kJVFieldHMargin, kJVFieldHeight)];
    titleField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Title", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    titleField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    titleField.floatingLabelTextColor = floatingLabelColor;
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    //    titleField.leftView = leftView;
    //    titleField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:titleField];
    
    UIView *div1 = [UIView new];
    div1.frame = CGRectMake(kJVFieldHMargin, titleField.frame.origin.y + titleField.frame.size.height,
                            self.view.frame.size.width - 2 * kJVFieldHMargin, 1.0f);
    [self.view addSubview:div1];
    
    JVFloatLabeledTextField *priceField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(kJVFieldHMargin, div1.frame.origin.y + div1.frame.size.height, 80.0f, kJVFieldHeight)];
    priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Price", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    priceField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    priceField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:priceField];
    
    UIView *div2 = [UIView new];
    div2.frame = CGRectMake(kJVFieldHMargin + priceField.frame.size.width,
                            titleField.frame.origin.y + titleField.frame.size.height,
                            1.0f, kJVFieldHeight);
    [self.view addSubview:div2];
    
    JVFloatLabeledTextField *locationField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                              CGRectMake(kJVFieldHMargin + kJVFieldHMargin + priceField.frame.size.width + 1.0f,
                                                         div1.frame.origin.y + div1.frame.size.height,
                                                         self.view.frame.size.width - 3*kJVFieldHMargin - priceField.frame.size.width - 1.0f,
                                                         kJVFieldHeight)];
    locationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Description (short)", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    locationField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    locationField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    locationField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:locationField];
    
    UIView *div3 = [UIView new];
    div3.frame = CGRectMake(kJVFieldHMargin, priceField.frame.origin.y + priceField.frame.size.height,
                            self.view.frame.size.width - 2*kJVFieldHMargin, 1.0f);
    [self.view addSubview:div3];
    
    JVFloatLabeledTextView *descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(kJVFieldHMargin,
                                                                                                        div3.frame.origin.y + div3.frame.size.height,
                                                                                                        self.view.frame.size.width - 2*kJVFieldHMargin,
                                                                                                        kJVFieldHeight*3)];
    descriptionField.placeholder = NSLocalizedString(@"Description (long)", @"");
    descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    descriptionField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:descriptionField];
    
    [titleField becomeFirstResponder];
    
}

- (void)setupAddImage
{
    UIButton *addImage = [[UIButton alloc] init];
    addImage = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImage = [UIImage imageNamed:@"AddImageButton"];
    [addImage setImage:btnImage forState:UIControlStateNormal];
    addImage.contentMode = UIViewContentModeScaleToFill;
    addImage.frame = CGRectMake(13, 250, 294.5, 172);
    
    [addImage addTarget:self action:@selector(addImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addImage];
}

- (void)addImageButtonPressed:(id)sender
{
    NSLog(@"Bring up camera or other stuff");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [CMColors mainColor]};
    self.title = @"Create Campaign";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)done:(id)sender
{
    NSLog(@"TODO : SAVE CAMPAIGN HERE");
    CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

- (void)cancel:(id)sender
{
    NSLog(@"Cancel");
    CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
