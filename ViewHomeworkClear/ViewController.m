//
//  ViewController.m
//  ViewHomeworkClear
//
//  Created by Stepan Paholyk on 7/20/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UIView* boardView;
@property (weak ,nonatomic) UIView* cellView;
@property (strong, nonatomic) NSMutableArray *firstKindOfCheckers;
@property (strong, nonatomic) NSMutableArray *secondKindOfCheckers;
@end

@implementation ViewController

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIViewAutoresizing stableMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    // board create
    
    CGFloat boardEdge = CGRectGetWidth(self.view.frame);
    CGSize boardSize;
    boardSize.height = boardSize.width = boardEdge;

    CGRect boardRect;
    boardRect.origin.x = 0;
    boardRect.origin.y = (CGRectGetHeight(self.view.frame) - boardEdge)/2;
    boardRect.size = boardSize;
    
    self.boardView = [self createViewWithRect:boardRect withColor:[UIColor whiteColor] withParentView:self.view andMask:stableMask];
    
    // cells create
    
    CGFloat cellEdge = boardEdge / 8;
    CGSize cellSize;
    cellSize.height = cellSize.width = cellEdge;
    
    CGRect cellRect;
    cellRect.size = cellSize;
    
    CGRect checkerRect = CGRectInset(cellRect, 10, 10);

    // init Mutables
    self.firstKindOfCheckers = [NSMutableArray array];
    self.secondKindOfCheckers = [NSMutableArray array];
    
    for (int rows = 0; rows < 8; rows++) {
        for (int columns = 0; columns < 8; columns++) {
            if ((rows + columns) % 2 != 0) {
                cellRect.origin.x = rows*cellEdge;
                cellRect.origin.y = columns*cellEdge;
                [self createViewWithRect:cellRect withColor:[UIColor brownColor] withParentView:self.boardView andMask:stableMask];
            }
            
            if ((rows + columns)%2 != 0 && ((columns >= 0 && columns < 3) || (columns > 4 && columns < 8))) {
                
                checkerRect.origin.x = cellRect.origin.x + (CGRectGetWidth(cellRect) - CGRectGetWidth(checkerRect))/2;
                checkerRect.origin.y = cellRect.origin.y + (CGRectGetHeight(cellRect) - CGRectGetHeight(checkerRect))/2;
                
                if (columns >= 0 && columns < 3) {
                    
                    UIView *first = [self createViewWithRect:checkerRect withColor:[UIColor yellowColor] withParentView:self.boardView andMask:stableMask];
                    first.layer.cornerRadius = 5;
                    [self.firstKindOfCheckers addObject:first];
                    
                } else {
                    
                    UIView *second = [self createViewWithRect:checkerRect withColor:[UIColor blueColor] withParentView:self.boardView andMask:stableMask];
                    second.layer.cornerRadius = 5;
                    [self.secondKindOfCheckers addObject:second];
                }
            }
        }
    }
}

#pragma mark - createViewWithRect

- (UIView*) createViewWithRect:(CGRect)rect withColor:(UIColor*)color withParentView:(UIView*)parentView andMask:(UIViewAutoresizing)mask
{
    UIView* view = [[UIView alloc] initWithFrame:rect];
    [parentView addSubview:view];
    view.backgroundColor = color;
    [view setAutoresizingMask:mask];
    
    return view;
}

#pragma mark - Rotation

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self exchangeWithAnimation];
    
}

#pragma mark - setRandomColor

- (void) setRandomColorForView:(UIView*)view
{
    float randRed = (float)(arc4random()%256/255);
    float randGreen = (float)(arc4random()%256/255);
    float randBlue = (float)(arc4random()%256/255);
    
    UIColor *randColor = [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1];
    [view setBackgroundColor:randColor];
}
#pragma mark - Exchange checkers

- (void) exchangeWithAnimation
{
    for (int i  = 0; i < [self.firstKindOfCheckers count]; i++) {
        
        NSInteger firstRandomIndex = arc4random()%12;
        NSInteger secondRandomIndex = arc4random()%12;
        
        UIView* firstView = [self.firstKindOfCheckers objectAtIndex:firstRandomIndex];
        UIView* secondView = [self.secondKindOfCheckers objectAtIndex:secondRandomIndex];
        
        CGRect tempView = firstView.frame;
        
        [UIView animateWithDuration:2
                         animations:^{
                             [firstView setFrame:secondView.frame];
                             [secondView setFrame:tempView];
                             
                             [self.boardView bringSubviewToFront:firstView];
                             [self.boardView bringSubviewToFront:secondView];
                         }];
    }
}
/* Another method for Exchange checkers (Not finished) */
/*
- (void) exchangeWithoutAnimation {
    for (int i=0; i<[self.boardView.subviews count]; i++) {
        UIView* subView = [self.boardView.subviews objectAtIndex:i];
        if (subView.tag == 4) {
            while (YES) {
                NSUInteger randomIndex = arc4random()%[self.boardView.subviews count];
                UIView* subView2 = [self.boardView.subviews objectAtIndex:randomIndex];
                if (subView2.tag == 4 && ![subView isEqual:subView2]) {
                    CGRect frame = subView.frame;
                    subView.frame = CGRectMake(subView2.frame.origin.x, subView2.frame.origin.y, subView2.frame.size.width, subView2.frame.size.height);
                    subView2.frame = CGRectMake(frame.origin.x, frame.origin.y, subView2.frame.size.width, subView2.frame.size.height);
                    [self.boardView exchangeSubviewAtIndex:i withSubviewAtIndex:randomIndex];
                    break;
                }
            }
        }
    }
}
*/


#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
