/*
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *   Program name: outputTrimmer.cpp
 *
 *   Invocation: ./a.out
 *
 *   Variables:
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *      Integers
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *
 *
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *      FILEs
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *
 *
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *      Arrays
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *      Bools
 *      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *
 *
 *   Functions called: None
 *
 *   Writen by: Brendan Martel
 *   Date:       07/26/2024
 *
 *   Modifications: None
 *
 *   Special notes:
 *
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 */

// importing libraries
#include <iostream>
#include <fstream>
#include <cstring>

//  Defining namespace
using namespace std;

int main(int argNum, char **argArr)
{

    /****************************************************************
     * Variable Initialization /home/brendan/Documents/Scripts/gppCompile/outputTrimmer/
     ****************************************************************/

    // This both sets the type of outputTxt and sets the location of the file
    fstream outputTxt("output.txt");

    char arrOut[200][200] = {"\0"};

    int lineCount = 0,
        debug = 1,
        wordInc = 0,
        charInc = 0;

    /****************************************************************
     * Main Codeblock
     ****************************************************************/

    if (outputTxt.is_open())
    {
        // This while not only moves the output line by line into the arrOut it will also gold the debug
        while (outputTxt.getline(&arrOut[lineCount][0], 200, '\n'))
        {
            // Just debugging
            if (debug == 1)
            {
                charInc = 0;
                if (lineCount == 0)
                {
                    cout << "This is the contents of your file before editing" << endl
                         << endl;
                }

                while (arrOut[lineCount][charInc] != '\0')
                {

                    cout << arrOut[lineCount][charInc];
                    charInc++;
                }
                cout << endl;
            }
            lineCount++;
        };

        /****************************************************************
         * exporting of new file into the text document
         *  -needed to close and reopen the file to allow me to write to it for some reason
         *      the file openes in read/write but reopening will also clear the contents of the file.
         *
         *  -After this it is just a simple itterate over everythign and read it back to the file
         *      without the first and last lines.
         ****************************************************************/
        outputTxt.close();
        outputTxt.open("output.txt", ios_base::out);

        for (wordInc = 1; wordInc < lineCount - 1; wordInc++)
        {
            charInc = 0;

            while (arrOut[wordInc][charInc] != '\0')
            {

                outputTxt << arrOut[wordInc][charInc];

                charInc++;
            }
            outputTxt << endl;
        }
    }
    else
    {
        // used to catch if the file DNE or cant be opened
        cout << "The output.txt file does not exist or could not be opened";
        return 1;
    };

    outputTxt.close();
    return 0;
}