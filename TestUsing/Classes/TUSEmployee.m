//
//  TUSEmployee.m
//  AFS
//
//  Created by azat on 12/12/15.
//  Copyright © 2015 azat. All rights reserved.
//

#import "TUSEmployee.h"
#import "TUSTaxman.h"

@implementation TUSEmployee

- (instancetype)init
{
    self = [super init];
    if (self) {
        _salaryHistory = @[];
    }
    return self;
}

- (NSNumber *)bestSalary {
    NSNumber *max = self.salaryHistory.firstObject;
    for (NSNumber *salary in self.salaryHistory) {
        if ([salary compare:max] == NSOrderedDescending) {
            max = salary;
        }
    }
    return max;
}

- (void)takeMoney:(NSNumber *)amount
{
    self.totalAmount = @(self.totalAmount.doubleValue + amount.doubleValue);
    [self payTaxes];
}

- (void)setCurrentSalary:(NSNumber *)currentSalary
{
    _currentSalary = currentSalary;
    NSMutableArray *arr = [self.salaryHistory mutableCopy];
    [arr addObject:currentSalary];
    self.salaryHistory = [arr copy];
}

- (void)payTaxes
{
    NSDecimalNumber *tax = [self.taxesProvider baseTaxes];
    [self.taxman receiveTaxes:tax sender:self];
    
    self.totalAmount = @(self.totalAmount.doubleValue - tax.doubleValue);
}

@end
