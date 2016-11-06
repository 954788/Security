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
string workOnSecretMessage(string secretMessage)
{
    for(int i = 0; i < secretMessage.length(); i++)
    {
        if(secretMessage[i] == 'J')
        {
            secretMessage[i] = 'I';
        }
    }
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
    if(word.length() % 2 != 0)
    {
        word+='X';
    }
    return word;
}

int main()
{
    string keyWord = "MONARCHY"; // just to check repeeting letters
    string secretMessage = "WE ARE DISCOVERED SAVE YOURSELF";
    cout << "word to encript = "<<secretMessage<<endl;
    //work on keyword
    keyWord = workOnKeyWord(keyWord);
    //Create table with letters
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
    // print table
    for(int i = 0; i < 5; i++)
    {
        for(int j = 0; j < 5; j++)
        {
            cout<<letterArray[i][j]<<" ";
        }
        cout<<endl;
    }
    // work on secret message
    secretMessage = workOnSecretMessage(secretMessage);
    // encription
    string twoLetters = "";
    string encriptedWord = "";
    int firstLetterRowIndex, firstLetterColIndex, secondLetterRowIndex, secondLetterColIndex;
    for(int i = 0; i < secretMessage.length()-1; i+=2)
    {
        
        firstLetterRowIndex = 0, firstLetterColIndex = 0, secondLetterRowIndex = 0, secondLetterColIndex = 0;
        twoLetters = secretMessage[i];
        twoLetters += secretMessage[i+1];
        //find first word
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
        // find second word
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
        if(firstLetterColIndex == secondLetterColIndex)
        {
            
            if( firstLetterRowIndex < 4 && secondLetterRowIndex < 4)
            {
                firstLetterRowIndex++;
                secondLetterRowIndex++;
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
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
        else if(firstLetterRowIndex == secondLetterRowIndex)
        {
            if(firstLetterColIndex < 4 && secondLetterColIndex < 4)
            {
                firstLetterColIndex++;
                secondLetterColIndex++;
                encriptedWord+=letterArray[firstLetterRowIndex][firstLetterColIndex];
                encriptedWord+=letterArray[secondLetterRowIndex][secondLetterColIndex];
            }
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
        else
        {
            encriptedWord+=letterArray[firstLetterRowIndex][secondLetterColIndex];
            encriptedWord+=letterArray[secondLetterRowIndex][firstLetterColIndex];
        }
    }
    cout << "\nencriprionWord = " << encriptedWord << endl;
    system("pause");
    
    return 0;

}

