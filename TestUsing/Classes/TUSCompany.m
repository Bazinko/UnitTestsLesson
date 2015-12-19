//
//  TUSCompany.m
//  AFS
//
//  Created by azat on 12/12/15.
//  Copyright © 2015 azat. All rights reserved.
//

#import "TUSCompany.h"
#import "TUSEmployee.h"
#import "TUSTaxman.h"

@implementation TUSCompany

- (void)payToEmployee:(TUSEmployee *)employee {
    [employee takeMoney:employee.currentSalary ];
    NSDecimalNumber *tax = [self.taxesProvider retireInsuranceTaxes];
    [self.taxman receiveTaxes:tax sender:self];
    
    self.totalAmount = @(self.totalAmount.doubleValue - employee.currentSalary.doubleValue - tax.doubleValue);
}

@end

