//
//  MentionPullToReactView.m
//  ExampleCustomContent
//
//  Created by Guillaume Sempe on 28/05/2014.
//  Copyright (c) 2014 mention.com. All rights reserved.
//

#import "MentionPullToReactView.h"
#import "UIColor+Custom.h"

@interface FakeMention : NSObject
@property(nonatomic) NSNumber *favorite;
@property(nonatomic) NSNumber *archived;
@property(nonatomic) NSNumber *trashed;
@property(nonatomic) NSNumber *spam;
@end

@implementation FakeMention

@end

#define HEADER_HEIGHT               200.0f
#define LABEL_HEIGHT                30.0f

static UIImage *favorite = nil, *hledFavorite = nil;
static UIImage *archive = nil, *hledArchive = nil;
static UIImage *trash = nil, *hledTrash = nil;

static BOOL hasAttributedString = NO;

@interface MentionPullToReactView ()
{
    NSArray     *_actions;
    NSMutableArray  *_imageViews;
    UILabel     *_label;
}
@property(nonatomic) FakeMention *fakeMention; // To fake the mention data source
@end

@implementation MentionPullToReactView

+ (void)initialize
{
	if (self == [MentionPullToReactView class]) {
        favorite = [UIImage imageNamed:@"pulldown-favorite"];
        hledFavorite = [UIImage imageNamed:@"pulldown-favorite-hled"];
        archive = [UIImage imageNamed:@"pulldown-archive"];
        hledArchive = [UIImage imageNamed:@"pulldown-archive-hled"];
        trash = [UIImage imageNamed:@"pulldown-trash"];
        hledTrash = [UIImage imageNamed:@"pulldown-trash-hled"];
        
        if ([NSAttributedString instancesRespondToSelector:@selector(drawInRect:)]) {
            hasAttributedString = YES;
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect constrainedFrame = frame;
    frame.size.height = HEADER_HEIGHT;
    self = [super initWithFrame:constrainedFrame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor customColorDefault];
        
        _actions = @[@{@"icon": favorite, @"hledIcon": hledFavorite, @"textDo": @"未完成", @"textUndo": @"未完成"},
                     @{@"icon": archive, @"hledIcon": hledArchive, @"textDo": @"正在进行", @"textUndo": @"正在进行"},
                     @{@"icon": trash, @"hledIcon": hledTrash, @"textDo": @"已完成", @"textUndo": @"已完成"}];
        _indexOfSelectedAction = NSNotFound;
        _imageViews = [NSMutableArray array];
        _label = nil;
        
        _label = [self descriptionLabel];
        [_label setText:@"Pull to show menu"];
        [self addSubview:_label];
        _fakeMention = ({
            FakeMention *m = [[FakeMention alloc] init];
            m.favorite = @(false);
            m.archived = @(false);
            m.trashed = @(false);
            m.spam = @(false);
            m;
        });
    }
    return self;
}

- (void)willTriggerAction:(NSInteger)action
{
    if (0 == action) {
        [self hideActions];
    } else {
        [self showActions:action];
    }

}

- (void)didTriggerAction:(NSInteger)action
{
}

- (void)didDoAction:(NSInteger)action
{
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    {
        // Draw whatever you like
        CGColorRef bgColor = [UIColor customColorDefault].CGColor;
        CGContextSetFillColorWithColor(ctx, bgColor);
        CGContextFillRect(ctx, self.bounds);
        
        if (NSNotFound!=_indexOfSelectedAction) {
            CGFloat selectionWidth = rect.size.width / [_actions count];
            CGRect selectionRect = rect;
            selectionRect.origin.x = _indexOfSelectedAction*selectionWidth;
            selectionRect.size.width = selectionWidth;
            CGColorRef selectionColor = [UIColor colorWithRed:27/255. green:124/255. blue:174/255. alpha:1.0].CGColor;
            CGContextSetFillColorWithColor(ctx, selectionColor);
            CGContextFillRect(ctx, selectionRect);
        }
    }
    CGContextRestoreGState(ctx);
}

#pragma mark - Private
- (UILabel *)descriptionLabel
{
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - LABEL_HEIGHT, self.frame.size.width, LABEL_HEIGHT)];
    [descriptionLabel setTextColor:[UIColor whiteColor]];//[UIColor colorWithRed:84/255. green:107/255. blue:123/255. alpha:1.0]];
    [descriptionLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [descriptionLabel setMinimumScaleFactor:0.8];
    [descriptionLabel setNumberOfLines:1];
    [descriptionLabel setAdjustsFontSizeToFitWidth:YES];
    [descriptionLabel setBackgroundColor:[UIColor customColorDefault]];
    return descriptionLabel;
}

- (void)hideActions
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            for (UIView *subview in self.subviews) {
                if ([subview isKindOfClass:[UIImageView class]]) {
                    subview.alpha = 0.0;    // hide only images
                }
            }
        } completion:^(BOOL finished) {
            [_label setText:@"Pull to show menu"];
            _indexOfSelectedAction = NSNotFound;
        }];
    });
}

- (void)showActions:(NSInteger)action
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Init
        if (0==[_imageViews count]) {
            CGFloat side = ((UIImage *)[[_actions objectAtIndex:0] valueForKey:@"icon"]).size.width;
            CGFloat space = floorf((self.frame.size.width - ([_actions count]*side)) / ([_actions count]));
            CGFloat x = floorf(space/2.0);
            CGFloat y = 30.0f;//self.frame.size.height - side - LABEL_HEIGHT - floorf(space/2.0);
            NSArray *icons = [_actions valueForKeyPath:@"@unionOfObjects.icon"];
            for (UIImage *icon in icons) {
                UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, side, side)];
                [iv setImage:icon];
                iv.alpha = 0.0;
                [self addSubview:iv];
                [_imageViews addObject:iv];
                x+= space;
                x+= side;
            }
        }
        if (nil==_label) {
            _label = [self descriptionLabel];
            [self addSubview:_label];
        }
        
        if (0 == action) {
            _indexOfSelectedAction = NSNotFound;
        } else {
            _indexOfSelectedAction = action - 1;
        }
        
        // update icons
        NSArray *icons = [_actions valueForKeyPath:@"@unionOfObjects.icon"];
        NSArray *hledIcons = [_actions valueForKeyPath:@"@unionOfObjects.hledIcon"];
        for (NSInteger i =0; i < [_actions count]; i++) {
            UIImageView *iv = _imageViews[i];
            if (0 == action) {
                iv.image = icons[i];
                [_label setText:@"Pull to show menu"];
            } else {
                if (i==_indexOfSelectedAction) {
                    iv.image = hledIcons[i];
                    [_label setText:[self textOfAction:_indexOfSelectedAction forMention:self.fakeMention]];
                } else {
                    iv.image = icons[i];
                }
            }
        }
        // Animate icons
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            for (UIView *subview in self.subviews) {
                subview.alpha = 1.0;
            }
        } completion:^(BOOL finished) {
            //
        }];
    });
}

- (NSString *)textOfAction:(MNTMentionHeaderActions)action forMention:(FakeMention *)mention
{
    NSString *text = @"";
    NSArray *textsDo = [_actions valueForKeyPath:@"@unionOfObjects.textDo"];
    NSArray *textsUnDo = [_actions valueForKeyPath:@"@unionOfObjects.textUndo"];
    switch (action) {
        case mntMentionHeaderActionTodo:
            if (NO==mention.favorite.boolValue) {
                text = textsDo[action];
            } else {
                text = textsUnDo[action];
            }
            break;
        case mntMentionHeaderActionDoing:
            if (NO==mention.archived.boolValue) {
                text = textsDo[action];
            } else {
                text = textsUnDo[action];
            }
            break;
        case mntMentionHeaderActionDone:
            if (NO==mention.trashed.boolValue) {
                text = textsDo[action];
            } else {
                text = textsUnDo[action];
            }
            break;
        default:
            break;
    }
    return text;
}

@end
