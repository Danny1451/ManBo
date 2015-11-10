//
//  HomeViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/9.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://open.play.cn/api/v1/user/captcha/get?client_id=730988&r=3733303938382D32313834303339343830363038363034352D313735363638313238393234313538383137"]]];
//    
//    CGSize sizeI = image.size;
//    
//    UIImage* newImage = [self scaleImage:image ToSize:CGSizeMake(100, 35)];
//    
//    CGSize newSize = newImage.size;
    //[self.imageView setImage:newImage];
//    [self.imageView setImageUrlWithOutCache:@"https://open.play.cn/api/v1/user/captcha/get?client_id=730988&r=3733303938382D35333635313037363332393337343338312D38363532353439313239303230323337353433"];
    
    [self.imageView setUserInteractionEnabled:YES];
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    
    UIImage *i;
    //    CGSize itemSize=CGSizeMake(30, 30);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    i=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refreshCode:(id)sender {
    
    [self.imageView setImageUrlWithOutCache:@"https://open.play.cn/api/v1/user/captcha/get?client_id=730988&r=3733303938382D35333635313037363332393337343338312D38363532353439313239303230323337353433"];
}

-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"click");
//    NSLog(@"%hhd",[gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]]);
    
    UIView *viewClicked=[gestureRecognizer view];
    if (viewClicked== self.imageView) {
        NSLog(@"click image");
        
        [self refreshCode:nil];
    }
    
}

@end
