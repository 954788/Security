//
//  ViewController.m
//  Encryption
//
//  Created by 粱展焯 on 16/10/21.
//  Copyright © 2016年 梁展焯. All rights reserved.
//

#include<iostream>
#include<string>


using namespace std;

string workOnKeyWord(string keyWord)// takes a string
{
    string word;
    word+=keyWord[0]; // create a string with the first letter of the keyword
    for(int i = 1; i < keyWord.length(); i++)
    {
        int index = word.length();
        bool addLetter = false;
        while(index > 0)
        {
            if(word[index] == keyWord[i])
            {
                addLetter = false;
                break;
            }
            else
            {
                addLetter = true;
            }
            index--;
        }
        if(addLetter)
        {
            word+=keyWord[i];
        }
    }
    return word;
}

// 处理字符串
string workOnSecretMessage(string secretMessage)
{
    
    // 把J换成I
    for(int i = 0; i < secretMessage.length(); i++)
    {
        if(secretMessage[i] == 'J')
        {
            secretMessage[i] = 'I';
        }
    }
    
    // 如果分组的两个字母相同 ，插入一个填充字母X
    string word;
    for(int i = 0; i < secretMessage.length()-1; i++)
    {
        if(secretMessage[i] == secretMessage[i+1])
        {
            if(secretMessage[i]!= ' ' )
                word+=secretMessage[i];
            word+='X';
        }
        else
        {
            if(secretMessage[i]!= ' ')
                word+= secretMessage[i];
        }
    }
    word+=secretMessage[secretMessage.length()-1];
    
    // 如果字符串长度是单数 ，在最后填充一个字母X
    if(word.length() % 2 != 0)
    {
        word+='X';
    }
    return word;
}

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *array2;
@property (strong, nonatomic) NSMutableArray *endMutArray;

@property (weak, nonatomic) IBOutlet UITextField *playkeytextfield;

@property (weak, nonatomic) IBOutlet UITextField *playtextfield;

@property (weak, nonatomic) IBOutlet UITextField *numberkey;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self caesar];
}

-(void)caesar{
    _array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    _array2 = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
//    NSString *string = @"aa aazzz";
    
    
    
   
}



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
            [_array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *string2 = obj;
                if ([string isEqualToString:string2]) {
                    [_endMutArray addObject:[_array objectAtIndex:idx+[_numberkey.text intValue]]];
                }
            }];
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
                    [clearArray addObject:[_array2 objectAtIndex:idx-[_numberkey.text intValue]]];
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

string jiami;

- (IBAction)playjiami:(id)sender {
//    id str = _playkeytextfield.text;
    string keyWord = [_playkeytextfield.text UTF8String]; // 关键词
    string secretMessage = [_playtextfield.text UTF8String];// 明文
    cout << "word to encript = "<<secretMessage<<endl;
    // 处理关键字
    keyWord = workOnKeyWord(keyWord);
    
    // 制作字母矩阵
    char letterArray[5][5];
    int keyWordIndex = 0;
    int alphabetLetter = 65;
    
    for(int i = 0; i < 5; i++)
    {
        for(int j = 0; j < 5; j++)
        {
            if(keyWordIndex < keyWord.length())
            {
                letterArray[i][j] = keyWord[keyWordIndex];
                keyWordIndex++;
            }
            else
            {
                keyWordIndex = 0;
                bool sameLetter = true;
                while(keyWordIndex < keyWord.length())
                {
                    if(keyWord[keyWordIndex] == (char)alphabetLetter || (char)alphabetLetter == 'J')
                    {
                        keyWordIndex = keyWord.length();
                        alphabetLetter++;
                        sameLetter = true;
                        j--;
                        break;
                    }
                    else
                    {
                        sameLetter = false;
                    }
                    keyWordIndex++;
                }
                if(!sameLetter)
                {
                    letterArray[i][j] = (char)alphabetLetter;
                    alphabetLetter++;
                }
            }
        }
    }
    
    // 打印字母矩阵
    for(int i = 0; i < 5; i++)
    {
        for(int j = 0; j < 5; j++)
        {
            cout<<letterArray[i][j]<<" ";
        }
        cout<<endl;
    }
    
    // 处理明文字符串
    secretMessage = workOnSecretMessage(secretMessage);
    
    // 加密
    string twoLetters = "";
    string encriptedWord = "";
    int firstLetterRowIndex, firstLetterColIndex, secondLetterRowIndex, secondLetterColIndex;
    for(int i = 0; i < secretMessage.length()-1; i+=2)
    {
        
        firstLetterRowIndex = 0, firstLetterColIndex = 0,
        secondLetterRowIndex = 0, secondLetterColIndex = 0;
        
        twoLetters = secretMessage[i];
        twoLetters += secretMessage[i+1];
        
        //在字母矩阵中找到字符串的第一个字母
        for(int p = 0; p < 5; p++)
        {
            bool breakeIf = false;
            for(int q = 0; q < 5; q++)
            {
                if(letterArray[p][q] == twoLetters[0])
                {
                    breakeIf = true;
                    firstLetterRowIndex = p;
                    firstLetterColIndex = q;
                    break;
                }
            }
            if(breakeIf)
            {
                break;
            }
        }
        
        // 找到第二个字母
        for(int p = 0; p < 5; p++)
        {
            bool breakeIf = false;
            for(int q = 0; q < 5; q++)
            {
                if(letterArray[p][q] == twoLetters[1])
                {
                    breakeIf = true;
                    secondLetterRowIndex = p;
                    secondLetterColIndex = q;
                    break;
                }
            }
            if(breakeIf)
            {
                break;
            }
        }
        
        // 判断是否同列
        if(firstLetterColIndex == secondLetterColIndex)
        {
            // 不在最后一行
            if( firstLetterRowIndex < 4 && secondLetterRowIndex < 4)
            {
                firstLetterRowIndex++;
                secondLetterRowIndex++;
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
            
            // 在最后一行
            else
            {
                if(firstLetterRowIndex == 4)
                {
                    firstLetterRowIndex = 0;
                    secondLetterRowIndex++;
                }
                else if(secondLetterRowIndex == 4)
                {
                    secondLetterRowIndex = 0;
                    firstLetterRowIndex++;
                }
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
        }
        
        // 判断是否同行
        else if(firstLetterRowIndex == secondLetterRowIndex)
        {
            // 不在最后一列
            if(firstLetterColIndex < 4 && secondLetterColIndex < 4)
            {
                firstLetterColIndex++;
                secondLetterColIndex++;
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
            
            // 在最后一列
            else
            {
                if(firstLetterColIndex == 4)
                {
                    firstLetterColIndex = 0;
                    secondLetterColIndex++;
                }
                else if(secondLetterColIndex == 4)
                {
                    secondLetterColIndex = 0;
                    firstLetterColIndex++;
                }
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
        }
        
        // 不同行不同列
        else
        {
            encriptedWord+=letterArray[firstLetterRowIndex][secondLetterColIndex];
            encriptedWord+=letterArray[secondLetterRowIndex][firstLetterColIndex];
        }
    }
    cout << "\nencriprionWord = " << encriptedWord << endl;
    
    jiami = encriptedWord;
    
    _label.text = [NSString stringWithFormat:@"%s",jiami.c_str()];
}

- (IBAction)playjiemi:(id)sender {
    
    string keyWord = [_playkeytextfield.text UTF8String]; // 关键词
    string secretMessage = jiami;// 密文
    cout << "word to encript = "<<secretMessage<<endl;
    // 处理关键字
    keyWord = workOnKeyWord(keyWord);
    
    // 制作字母矩阵
    char letterArray[5][5];
    int keyWordIndex = 0;
    int alphabetLetter = 65;
    
    for(int i = 0; i < 5; i++)
    {
        for(int j = 0; j < 5; j++)
        {
            if(keyWordIndex < keyWord.length())
            {
                letterArray[i][j] = keyWord[keyWordIndex];
                keyWordIndex++;
            }
            else
            {
                keyWordIndex = 0;
                bool sameLetter = true;
                while(keyWordIndex < keyWord.length())
                {
                    if(keyWord[keyWordIndex] == (char)alphabetLetter || (char)alphabetLetter == 'J')
                    {
                        keyWordIndex = keyWord.length();
                        alphabetLetter++;
                        sameLetter = true;
                        j--;
                        break;
                    }
                    else
                    {
                        sameLetter = false;
                    }
                    keyWordIndex++;
                }
                if(!sameLetter)
                {
                    letterArray[i][j] = (char)alphabetLetter;
                    alphabetLetter++;
                }
            }
        }
    }
    
    // 打印字母矩阵
    for(int i = 0; i < 5; i++)
    {
        for(int j = 0; j < 5; j++)
        {
            cout<<letterArray[i][j]<<" ";
        }
        cout<<endl;
    }
    
    // 处理明文字符串
    secretMessage = workOnSecretMessage(secretMessage);
    
    // 解密
    string twoLetters = "";
    string encriptedWord = "";
    int firstLetterRowIndex, firstLetterColIndex, secondLetterRowIndex, secondLetterColIndex;
    for(int i = 0; i < secretMessage.length()-1; i+=2)
    {
        
        firstLetterRowIndex = 0, firstLetterColIndex = 0,
        secondLetterRowIndex = 0, secondLetterColIndex = 0;
        
        twoLetters = secretMessage[i];
        twoLetters += secretMessage[i+1];
        
        //在字母矩阵中找到字符串的第一个字母
        for(int p = 0; p < 5; p++)
        {
            bool breakeIf = false;
            for(int q = 0; q < 5; q++)
            {
                if(letterArray[p][q] == twoLetters[0])
                {
                    breakeIf = true;
                    firstLetterRowIndex = p;
                    firstLetterColIndex = q;
                    break;
                }
            }
            if(breakeIf)
            {
                break;
            }
        }
        
        // 找到第二个字母
        for(int p = 0; p < 5; p++)
        {
            bool breakeIf = false;
            for(int q = 0; q < 5; q++)
            {
                if(letterArray[p][q] == twoLetters[1])
                {
                    breakeIf = true;
                    secondLetterRowIndex = p;
                    secondLetterColIndex = q;
                    break;
                }
            }
            if(breakeIf)
            {
                break;
            }
        }
        
        // 判断是否同列
        if(firstLetterColIndex == secondLetterColIndex)
        {
            // 不在第一行
            if( firstLetterRowIndex >0 && secondLetterRowIndex >0)
            {
                firstLetterRowIndex--;
                secondLetterRowIndex--;
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
            
            // 在第一行
            else
            {
                if(firstLetterRowIndex == 0)
                {
                    firstLetterRowIndex = 4;
                    secondLetterRowIndex--;
                }
                else if(secondLetterRowIndex == 0)
                {
                    secondLetterRowIndex = 4;
                    firstLetterRowIndex--;
                }
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
        }
        
        // 判断是否同行
        else if(firstLetterRowIndex == secondLetterRowIndex)
        {
            // 不在第一列
            if(firstLetterColIndex >0  && secondLetterColIndex >0)
            {
                firstLetterColIndex--;
                secondLetterColIndex--;
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
            
            // 在第一列
            else
            {
                if(firstLetterColIndex == 0)
                {
                    firstLetterColIndex = 4;
                    secondLetterColIndex--;
                }
                else if(secondLetterColIndex == 0)
                {
                    secondLetterColIndex = 4;
                    firstLetterColIndex--;
                }
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
        }
        
        // 不同行不同列
        else
        {
            encriptedWord+=letterArray[firstLetterRowIndex][secondLetterColIndex];
            encriptedWord+=letterArray[secondLetterRowIndex][firstLetterColIndex];
        }
    }
    cout << "\nencriprionWord = " << encriptedWord << endl;

       _label.text = [NSString stringWithFormat:@"%s",encriptedWord.c_str()];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
