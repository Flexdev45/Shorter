#!/bin/bash
function main(){
    # Script settings.
    scriptversion='0.2'; # the version of the script.
    author='Ek-dev';
    name="Bash Shorter v$scriptversion by $author"; #this will be the name.
    hypens="======================================================================="; # this will be the hyppens to print.

    # Get the distro
    DISTRO=$(cat /etc/*-release | grep -w NAME | cut -d= -f2 | tr -d '"');

    # Colour Settings.
    WHITE='\033[1;37m';   # Bright white text.
    BLACK_BG='\033[40m';   # Black background.
    NC='\033[0m';         # No colour (reset).
    # Clear the screen and set colours.
    clear; echo -e "${BLACK_BG}${WHITE}";

    # Funtion to reset the terminal colours.
    function resetcolours(){
        # Reset colors before exiting in any way.
        echo -e "${NC}";
    }

    function swipemenu(){
        echo -e "${WHITE}${hypens}"
        echo -e "          $name | Running on: $DISTRO                   "
        echo -e "${hypens}"
    }

    # It's our code.
    function loadmodule(){


        function continue2(){ # This will be the function that will short our url.
            read -p "Enter the URL you want to shorten with (www. or https://): " ur  # We make a prompt and save the input into a variable called $ur.
            # Check if the URL is not empty
            if [[ -z "$ur" ]]; then
                echo -e "Error: The URL is empty. Please provide a valid URL."
                resetcolours
                exit 1
            fi

            # Check if the URL is reachable
            if ! curl --output /dev/null --silent --head --fail "$ur"; then
                echo -e "Error: The URL is invalid or not reachable."
                resetcolours
                exit 1
            fi

            # Shorten the URL using is.gd
            isgdr=$(curl -s "https://is.gd/create.php?format=simple&url=$ur")

            # Check if the response is empty
            if [[ -z "$isgdr" ]]; then
                echo -e "Error: The URL shortening service returned an empty response."
                resetcolours
                exit 1
            fi

            # Output the shortened URL if no errors occurred
            clear; # we clear the console if all went well
            swipemenu; #we print the swipe menu

            # we let the user know if he wants to save the url into a or not.
            echo -ne "All went well ✅\nHere you have your shortened URL: ${isgdr}\nDo you want to save it into a file? [Y/N] >> ";
            read -r choice


            if [[ "$choice" == 'Y' || "$choice" == 'y' ]]; then
                clear
                swipemenu  # We print the swipe menu
                echo -ne 'Write a name for your text output file (without .txt)\nName >> '
                read -r out
                # We check if the filename is empty or not
                if [[ -z "$out" || "$out" =~ ^[Nn]$ ]]; then
                    clear;
                    swipemenu  # We print the swipe menu
                    echo -e "You didn't put a valid filename, closing script"
                    resetcolours
                    exit 1
                fi
                # If it's not, we create it proper filename.
                filename="${out}.txt"
                echo "$isgdr" > "$filename"  # We save the shortened URL into a text file
                clear  # We clear the console if all went well
                swipemenu  # We print the swipe menu
                echo -e "Done, your URL was saved into '${filename}'\nThanks for using my script."
                resetcolours
            elif [[ "$choice" == 'N' || "$choice" == 'n' ]]; then
                resetcolours
            else
                echo 'Exiting...'
                resetcolours
            fi  # Here ends the else block
        }


        # Check and install curl if it does not exist.
        curldirectory="/usr/bin/curl";
        if [ -f "$curldirectory" ]; then
            echo -e "Curl exists✅";
            continue2 # If you have installed curl, it will load the next function.
        else
            echo -e "You don't have curl in your system...\nInstalling curl for $DISTRO.";
            sudo apt install curl -y > /dev/null 2>&1; # install curl in a silent way.
            echo -e "Curl have been installed sucessfully✅";
            continue2 # If you don't have curl It'll donwload it and then load the next function.
        fi
    }

    # Function to display the menu
    function show_menu() {
        clear; #we clear the screen.
        swipemenu; # we print the swipe menu
        echo -e "1) Short an url."
        echo -e "99) Quit/Exit."
        echo -ne "Select an option: "
    }
        show_menu
        read -r choice

    case $choice in
        1)
            loadmodule # we load our code.
            ;;
        99)
            echo -e "Thanks for using my script."
            resetcolours
            exit 0
            ;;
        *)
            echo -e "Invalid option, closing script..."
            resetcolours
            ;;
        esac
};


function isroot(){
    # Check if you're running this as a root user.
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this with superuser privileges (sudo).";
        exit 1;
    else
            main # if only it is root, we run the main.
        fi
}

isroot # first, we need to check if it's root.