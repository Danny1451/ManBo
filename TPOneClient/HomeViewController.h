//
//  HomeViewController.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/9.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGUAsynImageView.h"

@interface HomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet EGUAsynImageView *imageView;
- (IBAction)refreshCode:(id)sender;

@end
