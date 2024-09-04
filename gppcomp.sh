#!/usr/bin/bash

: <<'END_COMMENT'
    This script is used to compile a c++ file and run the output of the compilation. 
        The script will also capture the output into a text file depending on the second perameter (see below)
        ****THIS SCRIPT ONLY RUNS IN BASH SO IT WONT WORK ON WINDOWS***
    

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
        If you want to use the command all yThis is the line I want to matchou have to do it:
            1.Open a terminal and cd to the directory you have your .cpp file in
            2.Enter the command "gppcomp" followed by the nessicary perameters (see below)
            3.The script will compile and run the program for you and will create a a.out executable in your working directory. 

        This command is best used in the integrated terminal of a IDE like vscode. Whatever IDE you use there are probably options to use this script to run your files.  

    PERAMETERS:
        First: name of file to be compiled and run
        Second(optional): Passing a "1" here will send all terminal output to a output.txt in the working dir

        EXAMPLE: gppcomp First Second
    
END_COMMENT



############################################################################
############################################################################
# Variable intialization
############################################################################
############################################################################

COMPILER="g++"
BASHRCDIR='NULL'
TEMP='NULL'
SCRIPTTEMP='NULL'
WORKINGDIR="$(pwd)"
RANDVAR='null'
#getting the location of the helper OutputTrimmer 
HELPERLOCAL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" 2> /dev/null && pwd )"
cd $WORKINGDIR

############################################################################
############################################################################
# peram scrubbing and help handling
############################################################################
############################################################################


if [ "$1" == "--help" ]; then
    cat << 'END_BLOCK'
    This script is used to compile a c++ file and run the output of the compilation. 
        The script will also capture the output into a text file depending on the second perameter (see below)
        ****THIS SCRIPT ONLY RUNS IN BASH SO IT WONT WORK ON WINDOWS***
        
        USING THIS COMMAND:
        If you want to use the command all you have to do it:
            1.Open a terminal and cd to the directory you have your .cpp file in
            2.Enter the command "gppcomp" followed by the nessicary perameters (see below)
            3.The script will compile and run the program for you and will create a a.out executable in your working directory. 

        This command is best used in the integrated terminal of a IDE like vs code 

        Perams:
            First: name of file to be compiled and run
            Second(optional): Passing a "1" here will send all terminal output to a output.txt in the working dir

        EXAMPLE: gppcomp First Second
END_BLOCK
    exit 1

elif [ "$1" == "-i" ]; then
    echo '----------------Begining installation----------------'

    cd ~/
    BASHRCDIR="$(pwd)" 
    
    #this if statment checks to see if you have the 

    if ls -a | grep .bash_aliases &> /dev/null
    then
        if grep -Fxq "alias gppcomp='$HELPERLOCAL/gppcomp.sh'" .bash_aliases
        then
            echo 'It seems that you already have the tool installed'
        else
            echo "copying in alias to $BASHRCDIR/.bash_aliases"
            echo "alias gppcomp='$HELPERLOCAL/gppcomp.sh'" >> "$BASHRCDIR/.bash_aliases"
            source ~/.bashrc
        fi  
    else
        echo "creating file .bash_aliases in $BASHRCDIR and copying in alias"
        touch .bash_aliases
        echo "alias gppcomp='$HELPERLOCAL/gppcomp.sh'" >> "$BASHRCDIR/.bash_aliases"
        source ~/.bashrc
    fi

    exit 1

elif [ -e $1 ]; then
    echo '----------------Begining file compilation----------------'
    

else 
    echo 'the file given does not exist'
    exit 1
fi



############################################################################
############################################################################
# compiling file and handling output
############################################################################
############################################################################



#creates a temp file and outputs any errors to the tmp file
TEMP="$(mktemp)"
eval $COMPILER $1 2> $TEMP

#if the file is empty then it does nothing if errors and warnings it prints them
echo ' '
if [[ -s $TEMP ]]; then
    echo '****************************************************'
    echo '***********Below are your errors/warnings***********'
    echo '****************************************************'
    echo ' '
    cat $TEMP
else
    echo '*******************No errors/warnings********************'
fi
echo ' '

#cosmetic conditionals
if [[ $2 == "1" ]]; then
    echo '----------------Program output w/ logging----------------'
else    
    echo '---------------Program output w/o logging----------------' 
fi



#running the script and pipeing the output if logging is enabled
if [[ $2 == "1" ]]; then
    SCRIPTTEMP="$(mktemp)"
    script -B output.txt -T $SCRIPTTEMP -m advanced -c ./a.out -q -E never
else 
    ./a.out
fi


cd "${WORKINGDIR}"
eval "${HELPERLOCAL}/outTrimHelper"


exit 0