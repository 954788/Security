//
//  ViewController.m
//  Encryption
//
//  Created by 粱展焯 on 16/10/21.
//  Copyright © 2016年 梁展焯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *array2;
@property (strong, nonatomic) NSMutableArray *endMutArray;
@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self caesar];
}

-(void)caesar{
    _array = @[@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"A",@"B",@"C"];
    
    _array2 = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
//    NSString *string = @"aa aazzz";
    
    
    
   
}

//-(void)playfair{
//    
//    // 明文
//    NSMutableString *firstString = [NSMutableString stringWithFormat:@"%@",@"we are discovered save yourself"];
//    
//    NSMutableString *secretkeyString = [@"crazy dog" mutableCopy];
//    
//    // 去除空格
//    firstString = [[firstString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
//    
//    NSLog(@"------firstString------:%@",firstString);
//    
//    // 变成大写
//    firstString = [[firstString uppercaseString] mutableCopy];
//    
//    NSLog(@"------firstString------:%@",firstString);
//    
//    // 如果存在相同的字符 中间插入k
//    for (int i=1; i<firstString.length;i= i+2) {
//        
//        NSLog(@"characterAtIndex:i   %hu",[firstString characterAtIndex:i]);
//        
//        NSLog(@"characterAtIndex:i-1   %hu",[firstString characterAtIndex:i-1]);
//        
//        if ([firstString characterAtIndex:i] == [firstString characterAtIndex:i-1]) {
//            [firstString insertString:@"K" atIndex:i];
//        }
//    }
//    
//    NSLog(@"------firstString------:%@",firstString);
//    
//    // 如果经过处理后的明文长度非偶数，则在后面加上字母k
//    if((firstString.length)%2!=0)
//    {
//        [firstString appendString:@"K"];
//    }
//    
//    NSLog(@"处理后的明文:%@",firstString);
//    
//    // 处理密钥
//    
//    // 大写
//    secretkeyString = [[secretkeyString uppercaseString] mutableCopy];
//    
//    // 把J换成I
//    secretkeyString = [[secretkeyString stringByReplacingOccurrencesOfString:@"J" withString:@"I"] mutableCopy];
//    
//    secretkeyString = [[secretkeyString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
//    
//    // 除去重复出现的字母
//    
//    NSMutableString *seckeyString = [NSMutableString string];
//    
//    for (int i=0; i<secretkeyString.length; i++) {
//        
//        NSString *string = [secretkeyString substringWithRange:NSMakeRange(i, 1)];
//        
//        if ([seckeyString rangeOfString:string].location == NSNotFound ) {
//            [seckeyString appendString:string];
//        }
//    }
//    
//    NSLog(@"------处理后的密钥------:%@",seckeyString);
//    
//    
//}


- (IBAction)jiamiAction:(id)sender {
    
    NSMutableArray *mutArray = [NSMutableArray array];
    
    // 分割字符串
    for (int i=0; i<_textfield.text.length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        
        [mutArray addObject:[_textfield.text substringWithRange:range]];
        
    }
    
    
    NSLog(@"firstArray------%@",mutArray);
    
    _endMutArray = [NSMutableArray array];
    
    // 加密
    for (NSString *string in mutArray) {
        if ([string isEqualToString:@" "]) {
            [_endMutArray addObject:@" "];
        }else{
            int i = ([string characterAtIndex:0]+3-100)%26;
            //            NSLog(@"i:%@------%d",string,[string characterAtIndex:0]);
            [_endMutArray addObject:_array[i]];
        }
    }
    
    NSLog(@"endArray------%@",_endMutArray);
    
    // 密文
    NSMutableString *endString = [NSMutableString string];
    
    for (NSString *string in _endMutArray) {
        
        endString = [NSMutableString stringWithFormat:@"%@%@",endString,string];
        
    }
    
    
    NSLog(@"endString------%@",endString);
    
    _textfield.text = endString;
    
}
- (IBAction)jiemiAction:(id)sender {
    
    // 解密
    NSMutableArray *clearArray = [NSMutableArray array];
    
    for (NSString *string in _endMutArray) {
        if ([string isEqualToString:@" "]) {
            [clearArray addObject:@" "];
        }else{
            [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *string2 = obj;
                if ([string isEqualToString:string2]) {
                    [clearArray addObject:[_array2 objectAtIndex:idx]];
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
    
    _textfield.text = clearString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
