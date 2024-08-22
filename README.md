This script is used to compile a c++ file and run the output of the compilation. 
        The script will also capture the output into a text file depending on the second perameter (see below)
        ****THIS SCRIPT ONLY RUNS IN BASH SO IT WONT WORK ON WINDOWS***
    
    IMPORTANT COMPATIBILITY ISSUES:
        This script will only work with cpp cin and cout. If you use C input methods like fscan it will hang and not work. 
            Its also important that you use "" when inclosing text and not '' if you use them it will output random stuff to the console. 
            As long as you stick to standard cpp in and out this script should log it correctly. 

        It is also important you cout any inputes taken from the user as it doesnt capture the user inputs only stdout. 

    COMPILER COMPATIBILITY:
        By Default this script uses the g++ compiler.That means you will need to have it installed. 
            -You can check this by runing "g++ -v" in the command line.
            -If you dont have it you can install it with "sudo apt install g++" in the commmand line.
            -If you want to edit the copiler by replacing the $COMPILER variable with the desired compiler cli invocation. 

    CONFIGURING THIS SCRIPT WITH CLI:
        In order to configure this scipt you first need to download it and then put it somewhere where you wont delete it. 
            For example ~/Documents/Scripts is where I have mine. 

        After this you will need to make the script executable.
            1.Open the directory you stored the script in with the terminal
            2.use the command "chmod -x gppcomp.sh" to make the file executable

        If you are using a bash based system you will first need to add the script as an alias for your cli to do this you:
            1. open a command prompt
            2. Input this command "sudo nano ~/.bash_aliases"
            3. Find a empty line and paste in "alias gppcomp='Path/to/Script/gppcomp.sh'"
                -if you are having trouble with finding the path to the script you can open the directory you are storing the script in using the terminal
                -then use the "pwd" command use the line of text it output and add /gppcomp.sh to it 
            4. restart the terminal and you should be able to use the gppcomp command

    USING THIS COMMAND:
        If you want to use the command all you have to do it:
            1.Open a terminal and cd to the directory you have your .cpp file in
            2.Enter the command "gppcomp" followed by the nessicary perameters (see below)
            3.The script will compile and run the program for you and will create a a.out executable in your working directory. 

        This command is best used in the integrated terminal of a IDE like vscode. Whatever IDE you use there are probably options to use this script to run your files.  

    PERAMETERS:
        First: name of file to be compiled and run
        Second(optional): if you want output sent to a output.txt in the working dir enter "1" if not dont enter anything

        EXAMPLE: gppcomp First Second
