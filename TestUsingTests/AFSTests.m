//
//  AFSTests.m
//  AFSTests
//
//  Created by azat on 12/12/15.
//  Copyright © 2015 azat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Specta.h>
#import "TUSEmployee.h"
#import <Expecta/Expecta.h>
#import "TUSCompany.h"
#import "TUSTaxman.h"

@interface TUSEmployee()

- (void)payTaxes;

@end


SpecBegin(AFTests)

__block TUSEmployee *employee;

describe(@"my tests", ^{
   
    beforeEach(^{
        employee = [TUSEmployee new];
    });

    it(@"returns best salary", ^{
        employee.salaryHistory = @[@42,@74,@6,@78];
        NSNumber *best = @78;
        expect(best).equal(@78);
    });
    
    it(@"pays", ^{
        TUSCompany *company = [TUSCompany new];
        
        employee.currentSalary = @10;
        employee.totalAmount = @0;

        [company payToEmployee:employee];
        expect(employee.totalAmount).beGreaterThan(@0);
    });
    
    it(@"pays taxes", ^{
        TUSCompany *company = [TUSCompany new];
        
        id mock = OCMPartialMock(employee);
        
        OCMExpect([mock payTaxes]);
        
        [company payToEmployee:mock];
        
        OCMVerifyAllWithDelay(mock, 0.5);
    });
    
    it(@"paying taxes", ^{
        id taxesProviderProtocol = OCMProtocolMock(@protocol(TUSTaxesProvider));
        [OCMStub([taxesProviderProtocol baseTaxes]) andReturn:@11];
        [OCMStub([taxesProviderProtocol retireInsuranceTaxes]) andReturn:@37];
        
        TUSCompany *company = [TUSCompany new];
        company.taxesProvider = taxesProviderProtocol;
        company.totalAmount = @1000;
        
        TUSTaxman *taxman = [TUSTaxman new];
        company.taxman = taxman;
        employee.taxman = taxman;
        
        employee.taxesProvider = taxesProviderProtocol;
        employee.currentSalary = @100;
        employee.totalAmount = @0;
        
        [company payToEmployee:employee];
        
        expect(company.totalAmount).equal(@863);
        expect(employee.totalAmount).equal(@89);
    });

    
});

SpecEnd
