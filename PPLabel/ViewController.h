//
//  ViewController.h
//  PPLabel
//
//  Created by Petr Pavlik on 12/28/12.
//  Copyright (c) 2012 Petr Pavlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLabel.h"

@interface ViewController : UIViewController <PPLabelDelegate>

@property (weak, nonatomic) IBOutlet PPLabel *label;

@end
