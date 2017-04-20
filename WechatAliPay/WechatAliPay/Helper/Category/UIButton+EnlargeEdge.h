//
//  UIButton+EnlargeEdge.h
//  Rent_OC
//
//  Created by yangye on 14-11-24.
//  Copyright (c) 2014年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UIButton(EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
