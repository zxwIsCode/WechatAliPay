//
//  CMRequestDelegate.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMResponseDelegate.h"

typedef void(^CMResponseCallback)(id result, NSError *error);

@protocol CMRequestDelegate <NSObject>

@property (nonatomic, assign) NSUInteger flag;
@property (nonatomic, copy) CMResponseCallback callback;

@required
/**
 *  request param info
 *
 *  @return request param
 */
- (NSDictionary *)reqParamDic;
- (void)requestFinishedCallback:(id)result;
- (void)requestErrorCallback:(NSError *)error;
- (id<CMResponseDelegate>)getResponseWithInfo:(id)result
                                          err:(NSError *)err;
@optional

@end
