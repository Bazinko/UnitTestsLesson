//
//  TUSTaxman.m
//  TestsUsing
//
//  Created by azat on 14/12/15.
//  Copyright © 2015 azat. All rights reserved.
//

#import "TUSTaxman.h"

@implementation TUSTaxman

- (void)receiveTaxes:(NSDecimalNumber *)taxes sender:(id)sender {
    NSMutableDictionary *arr = [self.records mutableCopy];
    self.records = [arr copy];
}

@end
