//
//  ViewController.m
//  Encryption
//
//  Created by 粱展焯 on 16/10/21.
//  Copyright © 2016年 梁展焯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
}

-(void)caesar{
    NSArray *array = @[@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"A",@"B",@"C"];
    
    NSArray *array2 = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    NSString *string = @"aa aazzz";
    
    NSMutableArray *mutArray = [NSMutableArray array];
    
    // 分割字符串
    for (int i=0; i<string.length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        
        [mutArray addObject:[string substringWithRange:range]];
        
    }
    
    
    NSLog(@"firstArray------%@",mutArray);
    
    NSMutableArray *endMutArray = [NSMutableArray array];
    
    // 加密
    for (NSString *string in mutArray) {
        if ([string isEqualToString:@" "]) {
            [endMutArray addObject:@" "];
        }else{
            int i = ([string characterAtIndex:0]+3-100)%26;
            NSLog(@"i:%@------%d",string,[string characterAtIndex:0]);
            [endMutArray addObject:array[i]];
        }
    }
    
    NSLog(@"endArray------%@",endMutArray);
    
    // 密文
    NSMutableString *endString = [NSMutableString string];
    
    for (NSString *string in endMutArray) {
        
        endString = [NSMutableString stringWithFormat:@"%@%@",endString,string];
        
    }
    
    
    NSLog(@"endString------%@",endString);
    
    // 解密
    NSMutableArray *clearArray = [NSMutableArray array];
    
    for (NSString *string in endMutArray) {
        if ([string isEqualToString:@" "]) {
            [clearArray addObject:@" "];
        }else{
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *string2 = obj;
                if ([string isEqualToString:string2]) {
                    [clearArray addObject:[array2 objectAtIndex:idx]];
                }
            }];
        }
    }
    
    NSLog(@"clearArray------%@",clearArray);
    
    // 明文
    NSMutableString *clearString = [NSMutableString string];
    
    for (NSString *string in clearArray) {
        
        clearString = [NSMutableString stringWithFormat:@"%@%@",clearString,string];
        
    }
    
    NSLog(@"clearString------%@",clearString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
