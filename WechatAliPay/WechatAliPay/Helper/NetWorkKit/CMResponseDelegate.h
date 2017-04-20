//
//  CMResponseDelegate.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CMResponseDelegate <NSObject>


@required
- (id)initWithData:(id)responseData
               err:(NSError *)err;

@end
