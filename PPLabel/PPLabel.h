//
//  PPLabel.h
//  PPLabel
//
//  Created by Petr Pavlik on 12/26/12.
//  Copyright (c) 2012 Petr Pavlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPLabel;

/// The delegate of a PPLabel object
@protocol PPLabelDelegate <NSObject>

/**
 Tells the delegate that the label was touched and returns which character was touched.
 
 @param label The instance of PPLabel that called this method.
 @param touch The touch that triggered this event.
 @param cIndex of a character at given point or NSNotFound.
 
 @return Return YES if the delegate handled this touch and should not be propagated any further.
 */
- (BOOL)label:(PPLabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex;

/**
 Tells the delegate that the touch was moved.
 
 @param label The instance of PPLabel that called this method.
 @param touch The touch that triggered this event.
 @param cIndex of a character at given point or NSNotFound.
 
 @return Return YES if the delegate handled this touch and should not be propagated any further.
 */
- (BOOL)label:(PPLabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex;

/**
 Tells the delegate that the label that it's not being touched anymore.
 
 @param label The instance of PPLabel that called this method.
 @param touch The touch that triggered this event.
 @param cIndex of a character at given point or NSNotFound.
 
 @return Return YES if the delegate handled this touch and should not be propagated any further.
 */
- (BOOL)label:(PPLabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex;

/**
 Tells the delegate that the label that it's not being touched anymore.
 
 @param label The instance of PPLabel that called this method.
 @param touch The touch that triggered this event.
 
 @return Return YES if the delegate handled this touch and should not be propagated any further.
 */
- (BOOL)label:(PPLabel*)label didCancelTouch:(UITouch*)touch;

@end


/// Subclass of PPLabel which can detect touches and report which character was touched.
@interface PPLabel : UILabel

/**
 The object that acts as the delegate of the receiving label.
 
 @see PPLabelDelegate
 */
@property(nonatomic, weak) id <PPLabelDelegate> delegate;

/**
 Cancels current touch and calls didCancelTouch: on the delegate.
 
 This method does nothing if there is no touch session.
 */
- (void)cancelCurrentTouch;

/**
 Returns the index of character at provided point or NSNotFound.
 
 @param point The point indicating where to look for.
 
 @return Index of a character at given point or NSNotFound.
 */
- (CFIndex)characterIndexAtPoint:(CGPoint)point;

@end
