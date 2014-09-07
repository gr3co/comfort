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
#import "CMCampaign.h"
#import "CMColors.h"
#import "CMMainViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraSegueViewController.h"
#import "CMPersonalCampaignInfoViewController.h"
#import "CMMenuNavigationController.h"

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface CMCreateCampaignViewController ()<DBCameraViewControllerDelegate> {
    UIButton *addImage;
    JVFloatLabeledTextField *titleField;
    JVFloatLabeledTextField *priceField;
    JVFloatLabeledTextView *descriptionField;
    BOOL imageSet;
}

@end

@implementation CMCreateCampaignViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageSet = NO;
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
    
    titleField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(kJVFieldHMargin, topOffset, 220.0f, kJVFieldHeight)];
    titleField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"I will...(30 char)", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    titleField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    titleField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:titleField];
    
    UIView *div2 = [UIView new];
    div2.frame = CGRectMake(kJVFieldHMargin + titleField.frame.size.width,
                            priceField.frame.origin.y + priceField.frame.size.height,
                            1.0f, kJVFieldHeight);
    div2.backgroundColor = UIColorFromRGB(0xE4E4E4);
    [self.view addSubview:div2];
    
    priceField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                              CGRectMake(kJVFieldHMargin + kJVFieldHMargin + titleField.frame.size.width + 1.0f,
                                                         topOffset,
                                                         self.view.frame.size.width - 3*kJVFieldHMargin - titleField.frame.size.width - 1.0f,
                                                         kJVFieldHeight)];
    priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Price ($)", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    priceField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    priceField.floatingLabelTextColor = floatingLabelColor;
    priceField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:priceField];
//
    UIView *div3 = [UIView new];
    div3.frame = CGRectMake(kJVFieldHMargin, priceField.frame.origin.y + priceField.frame.size.height,
                            self.view.frame.size.width - 2*kJVFieldHMargin, 1.0f);
    div3.backgroundColor = UIColorFromRGB(0xE4E4E4);
    [self.view addSubview:div3];
    
    descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(kJVFieldHMargin,
                                                                                                        div3.frame.origin.y + div3.frame.size.height,
                                                                                                        self.view.frame.size.width - 2*kJVFieldHMargin,
                                                                                                        kJVFieldHeight*3)];
    descriptionField.placeholder = NSLocalizedString(@"Description", @"");
    descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    descriptionField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:descriptionField];
    
    [titleField becomeFirstResponder];
    
}

- (CMCampaign *)saveCampaignWithDescription:(NSString *)desc withMoreInfo:(NSString *)info withPrice:(NSNumber *)price withHeaderImage:(UIImage *)headerImage
{
    return [CMCampaign createNewCampaignWithOwner:[PFUser currentUser] withPrice:price withHeaderImage:headerImage withDescription:desc withMoreInfo:info];
}

- (void)setupAddImage
{
    addImage = [[UIButton alloc] init];
    addImage = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImage = [UIImage imageNamed:@"AddImageButton"];
    [addImage setImage:btnImage forState:UIControlStateNormal];
    addImage.contentMode = UIViewContentModeScaleToFill;
    addImage.frame = CGRectMake(2, 205, 320.18, 187);
    
    [addImage addTarget:self action:@selector(addImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addImage];
}

- (void)addImageButtonPressed:(id)sender
{
    NSLog(@"Bring up camera or other stuff");
//    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
//    [cameraContainer setFullScreenMode];
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
//    [nav setNavigationBarHidden:YES];
//    [self presentViewController:nav animated:YES completion:nil];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setUseCameraSegue:YES];
    [container setCameraViewController:cameraController];
    [cameraController setCameraSegueConfigureBlock:^( DBCameraSegueViewController *segue ) {
        segue.cropMode = YES;
        segue.cropRect = (CGRect){ 0, 0, 320.18, 187 };
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [container setFullScreenMode];
    [self presentViewController:nav animated:YES completion:nil];
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
    
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(CMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
}

- (void)done:(id)sender
{
    if ([titleField.text  length] > 30) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error: Title is greater than 30 characters." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if (!imageSet) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error: Image not set." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if ([descriptionField.text length] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error: Please write a more meaningful description." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if ([titleField.text length] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error: Please write a more meaningful title." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];

    } else {
        NSString *orgDesc = [titleField.text copy];
        NSString *description = [NSString stringWithFormat:@"I will %@.", [orgDesc stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[orgDesc substringToIndex:1] lowercaseString]]];
        NSString *moreInfo = descriptionField.text;
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *price = [f numberFromString:priceField.text];
        CMCampaign *campaign = [self saveCampaignWithDescription:description withMoreInfo:moreInfo withPrice:price withHeaderImage:addImage.imageView.image];
        CMPersonalCampaignInfoViewController *campaignController = [[CMPersonalCampaignInfoViewController alloc] initWithCampaign:campaign];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController pushViewController:campaignController animated:YES];
    }
}

- (void)cancel:(id)sender
{
    NSLog(@"Cancel");
    CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

//Use your captured image
#pragma mark - DBCameraViewControllerDelegate

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
//    DetailViewController *detail = [[DetailViewController alloc] init];
//    [detail setDetailImage:image];
//    [self.navigationController pushViewController:self animated:NO];
//    [cameraViewController restoreFullScreenMode];
    [addImage setImage:image forState:UIControlStateNormal];
    imageSet = YES;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

@end
