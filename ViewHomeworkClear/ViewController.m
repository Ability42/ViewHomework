//
//  ViewController.m
//  ViewHomeworkClear
//
//  Created by Stepan Paholyk on 7/20/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIView* boardView;
@property (strong ,nonatomic) UIView* cellView; // needed Mutable Array for save cells view in heap
@end

@implementation ViewController

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
    
    self.boardView = [self createViewWithRect:boardRect withColor:[UIColor brownColor] withParentView:self.view andMask:stableMask];
    
    // cells create
    
    CGFloat cellEdge = boardEdge / 8;
    CGSize cellSize;
    cellSize.height = cellSize.width = cellEdge;
    
    CGRect cellRect;
    cellRect.size = cellSize;
    
    for (int rows = 0; rows < 8; rows++) {
        for (int columns = 0; columns < 8; columns++) {
            if ((rows + columns) % 2 != 0) {
                cellRect.origin.x = rows*cellEdge;
                cellRect.origin.y = columns*cellEdge;
                [self createViewWithRect:cellRect withColor:[UIColor cyanColor] withParentView:self.boardView andMask:stableMask];
            }
        }
    }
    
}

- (UIView*) createViewWithRect:(CGRect)rect withColor:(UIColor*)color withParentView:(UIView*)parentView andMask:(UIViewAutoresizing)mask
{
    UIView* view = [[UIView alloc] initWithFrame:rect];
    [parentView addSubview:view];
    view.backgroundColor = color;
    [view setAutoresizingMask:mask];
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
