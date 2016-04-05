//
//  UIPlaceHolderTextView.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 04/02/14.
//  Copyright (c) 2014 Speednet Sp. z o. o. All rights reserved.
//

#import "UIPlaceHolderTextView.h"
#import "UIColor+Hex.h"

#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.2
#endif

// Set this to YES if you only support iOS 7.
#define PSPDFRequiresTextViewWorkarounds() (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)


@interface UIPlaceHolderTextView () <UITextViewDelegate>
@property (weak, nonatomic) id<UITextViewDelegate> realDelegate;
@property (assign, nonatomic) BOOL initialized;
@property (strong, nonatomic) UILabel *placeHolderLabel;
@end

@implementation UIPlaceHolderTextView

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if (!_initialized) {
        _initialized = YES;
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor colorWith8BitRed:200 green:200 blue:206 alpha:1]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        if (PSPDFRequiresTextViewWorkarounds()) {
            [super setDelegate:self];
        }
    }
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    if (PSPDFRequiresTextViewWorkarounds()) {
        // UIScrollView delegate keeps some flags that mark whether the delegate implements some methods (like scrollViewDidScroll:)
        // setting *the same* delegate doesn't recheck the flags, so it's better to simply nil the previous delegate out
        // we have to setup the realDelegate at first, since the flag check happens in setter
        [super setDelegate:nil];
        self.realDelegate = delegate != self ? delegate : nil;
        [super setDelegate:delegate ? self : nil];
    }else {
        [super setDelegate:delegate];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)textChanged:(NSNotification *)notification {
    if([[self placeholder] length] == 0) {
        return;
    }
    
    if([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect {
    if( [[self placeholder] length] > 0 ) {
        if (!_placeHolderLabel) {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(6,8,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Caret Scrolling

- (void)scrollRectToVisibleConsideringInsets:(CGRect)rect animated:(BOOL)animated {
    if (PSPDFRequiresTextViewWorkarounds()) {
        // Don't scroll if rect is currently visible.
        CGRect visibleRect = UIEdgeInsetsInsetRect(self.bounds, self.contentInset);
        if (!CGRectContainsRect(visibleRect, rect)) {
            // Calculate new content offset.
            CGPoint contentOffset = self.contentOffset;
            if (CGRectGetMinY(rect) < CGRectGetMinY(visibleRect)) { // scroll up
                contentOffset.y = CGRectGetMinY(rect) - self.contentInset.top;
            }else { // scroll down
                contentOffset.y = CGRectGetMaxY(rect) + self.contentInset.bottom - CGRectGetHeight(self.bounds);
            }
            [self setContentOffset:contentOffset animated:animated];
        }
    }
    else {
        [self scrollRectToVisible:rect animated:animated];
    }
}

- (void)scrollRangeToVisibleConsideringInsets:(NSRange)range animated:(BOOL)animated {
    if (PSPDFRequiresTextViewWorkarounds()) {
        // Calculate text position and scroll, considering insets.
        UITextPosition *startPosition = [self positionFromPosition:self.beginningOfDocument offset:range.location];
        UITextPosition *endPosition = [self positionFromPosition:startPosition offset:range.length];
        UITextRange *textRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
        [self scrollRectToVisibleConsideringInsets:[self firstRectForRange:textRange] animated:animated];
    }
    else {
        [self scrollRangeToVisible:range];
    }
}

- (void)ensureCaretIsVisibleWithReplacementText:(NSString *)text {
    // No action is required on iOS 6, everything's working as intended there.
    if (PSPDFRequiresTextViewWorkarounds()) {
        // We need to give UITextView some time to fix it's calculation if this is a newline and we're at the end.
        if ([text isEqualToString:@"\n"] || [text isEqualToString:@""]) {
            // We schedule scrolling and don't animate, since UITextView doesn't animate these changes as well.
            [self scheduleScrollToVisibleCaretWithDelay:0.1f]; // Smaller delays are unreliable.
        }else {
            // Whenever the user enters text, see if we need to scroll to keep the caret on screen.
            // If it's not a newline, we don't need to add a delay to scroll.
            // We don't animate since this sometimes ends up on the wrong position then.
            [self scrollToVisibleCaret];
        }
    }
}

- (void)scheduleScrollToVisibleCaretWithDelay:(NSTimeInterval)delay {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToVisibleCaret) object:nil];
    [self performSelector:@selector(scrollToVisibleCaret) withObject:nil afterDelay:delay];
}

- (void)scrollToVisibleCaretAnimated:(BOOL)animated {
    [self scrollRectToVisibleConsideringInsets:[self caretRectForPosition:self.selectedTextRange.end] animated:animated];
}

- (void)scrollToVisibleCaret {
    [self scrollToVisibleCaretAnimated:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextViewDelegate

- (void)textViewDidChangeSelection:(UITextView *)textView {
    id<UITextViewDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate textViewDidChangeSelection:textView];
    }
    
    // Ensure caret stays visible when we change the caret position (e.g. via keyboard)
    [self scrollToVisibleCaretAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    id<UITextViewDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate textViewDidChange:textView];
    }
    
    // Ensure we scroll to the caret position when changing text (e.g. pasting)
    [self scrollToVisibleCaretAnimated:NO];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL returnVal = YES;
    id<UITextViewDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        returnVal = [delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    // Ensure caret stays visible while we type.
    [self ensureCaretIsVisibleWithReplacementText:text];
    return returnVal;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegate Forwarder

- (BOOL)respondsToSelector:(SEL)s {
    return [super respondsToSelector:s] || [self.realDelegate respondsToSelector:s];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)s {
    return [super methodSignatureForSelector:s] ?: [(id)self.realDelegate methodSignatureForSelector:s];
}

- (id)forwardingTargetForSelector:(SEL)s {
    id delegate = self.realDelegate;
    return [delegate respondsToSelector:s] ? delegate : [super forwardingTargetForSelector:s];
}


@end
