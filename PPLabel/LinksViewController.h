//
//  LinksViewController.h
//  PPLabel
//
//  Created by Petr Pavlik on 1/4/13.
//  Copyright (c) 2013 Petr Pavlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLabel.h"

@interface LinksViewController : UIViewController <PPLabelDelegate>

@property (weak, nonatomic) IBOutlet PPLabel *label;

@end
