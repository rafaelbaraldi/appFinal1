//
//  appFinal1Tests.m
//  appFinal1Tests
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginConexao.h"
@interface appFinal1Tests : XCTestCase

@end

@implementation appFinal1Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void)testLogando{
    
    NSString *email = @"ricardo@gmail.com";
    NSString *senha = @"1";
    
    NSDictionary *json = [LoginConexao login:email senha:senha];
    
    XCTAssertNotNil(json, @"toDictionary returned nil");
}

@end
