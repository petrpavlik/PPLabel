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

#pragma mark --

- (void)label:(PPLabel *)label didBeginTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex {
    
    [self highlightWordContainingCharacterAtIndex:charIndex];
}

- (void)label:(PPLabel *)label didMoveTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex {
    
    [self highlightWordContainingCharacterAtIndex:charIndex];
}

- (void)label:(PPLabel *)label didEndTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex {
    
    [self removeHighlight];
}

- (void)label:(PPLabel *)label didCancelTouch:(UITouch *)touch {
    
    [self removeHighlight];
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
    
    if (wordRange.location == self.highlightedRange.location && wordRange.length == self.highlightedRange.length) {
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
