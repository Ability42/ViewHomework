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
@property (weak ,nonatomic) UIView* cellView; // needed Mutable Array for save cells view in heap
@end

@implementation ViewController

#pragma mark - viewDidLoad

- (void)viewDidLoad {
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
    
    CGRect checkerRect = CGRectInset(cellRect, 12, 12);

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
                    [self createViewWithRect:checkerRect withColor:[UIColor yellowColor] withParentView:self.boardView andMask:stableMask];
                } else {
                    [self createViewWithRect:checkerRect withColor:[UIColor blueColor] withParentView:self.boardView andMask:stableMask];
                }
            }
        }
    }
    
    // make checkers (needed heap???)
    
    
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

#pragma mark Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
