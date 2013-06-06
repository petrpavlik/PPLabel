# PPLabel
## UIlabel subclass with ability to detect touches on individual letters
---
The advantage os this implementation is that it uses the ability of UILabel to display 
NSAttributedString on iOS 6.0+. There is no hacking of the drawRect: or drawText: 
method of UILabel. CoreText is used only to detect touched letters.

### Why to use PPLabel
- Draws text **exactly** the same way as UILabel
- Dead simple implementation, look at the source code.

**PPLabel requires iOS 6+**

## Getting Started

### Cocoapods

CocoaPods is the recommended way to add PPLabel to your project.

* Add a pod entry for PPLabel to your Podfile pod 'PPLabel', '~> 0.5'
* Install the pod(s) by running pod install.
* Include PPLabel wherever you need it with #import <PPLabel.h>.

### Source Files / Git Submodule

- Obtain the last version of PPLabel from the master branch.
- Add PPLabel.h and PPLabel.m into your project
- Import CoreText framework into your project.
- Have a look at the example project and enjoy PPLabel.

## Examples

![Screenshot from the example project](https://dl.dropbox.com/u/4175299/PPLabel.png)
![Screenshot from the example project](https://dl.dropbox.com/u/4175299/PPlabel2.png)

## Usage

The example project highlights touched words in a label. This behaviour can be modified to highlight touched links, hashtags or whatever you want.

``` objective-c
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
```

``` objective-c
//
//  ViewController.m
//  PPLabel
//
//  Created by Petr Pavlik on 12/28/12.
//  Copyright (c) 2012 Petr Pavlik. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic) NSRange highlightedRange;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.label.delegate = self;
}

#pragma mark PPLabelDelegate

- (BOOL)label:(PPLabel *)label didBeginTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex {
    
    [self highlightWordContainingCharacterAtIndex:charIndex];
    return NO;
}

- (BOOL)label:(PPLabel *)label didMoveTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex {
    
    [self highlightWordContainingCharacterAtIndex:charIndex];
    return NO;
}

- (BOOL)label:(PPLabel *)label didEndTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex {
    
    [self removeHighlight];
    return NO;
}

- (BOOL)label:(PPLabel *)label didCancelTouch:(UITouch *)touch {
    
    [self removeHighlight];
    return NO; 
}

#pragma mark --

- (void)highlightWordContainingCharacterAtIndex:(CFIndex)charIndex {
    
    if (charIndex==NSNotFound) {
        
        //user did nat click on any word
        [self removeHighlight];
        return;
    }
    
    NSString* string = self.label.text;
    
    //compute the positions of space characters next to the charIndex
    NSRange end = [string rangeOfString:@" " options:0 range:NSMakeRange(charIndex, string.length - charIndex)];
    NSRange front = [string rangeOfString:@" " options:NSBackwardsSearch range:NSMakeRange(0, charIndex)];
    
    if (front.location == NSNotFound) {
        front.location = 0; //first word was selected
    }
    
    if (end.location == NSNotFound) {
        end.location = string.length-1; //last word was selected
    }
    
    NSRange wordRange = NSMakeRange(front.location, end.location-front.location);
    
    if (front.location!=0) { //fix trimming
        wordRange.location += 1;
        wordRange.length -= 1;
    }
    
    if (wordRange.location == self.highlightedRange.location) {
        return; //this word is already highlighted
    }
    else {
        [self removeHighlight]; //remove highlight on previously selected word
    }
    
    self.highlightedRange = wordRange;
    
    //highlight selected word
    NSMutableAttributedString* attributedString = [self.label.attributedText mutableCopy];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:wordRange];
    self.label.attributedText = attributedString;
}

- (void)removeHighlight {
    
    if (self.highlightedRange.location != NSNotFound) {
        
        //remove highlight from previously selected word
        NSMutableAttributedString* attributedString = [self.label.attributedText mutableCopy];
        [attributedString removeAttribute:NSBackgroundColorAttributeName range:self.highlightedRange];
        self.label.attributedText = attributedString;
        
        self.highlightedRange = NSMakeRange(NSNotFound, 0);
    }
}

@end
```

## Credits
Many thanks to [Mattt Thomson](http://github.com/mattt) and his TTTAttributedLabel. It was a big inspiration.

## Contact
[@ptrpavlik](https://twitter.com/ptrpavlik)

[petrpavlik](https://alpha.app.net/petrpavlik) on App.net

petrpavlik@me.com

## License
PPLabel is available under the MIT license.

