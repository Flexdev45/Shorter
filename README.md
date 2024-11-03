# Bash Shortener V0.2
***Description: It's a simple bash script to short urls using the public api "is.gd".***

***Reason Why: I've made this script only to be executed on linux because sometimes we need a such a quick tool to short our urls and don't want to spend a lot of time creating an account on a "url shortener service".***

***What does it use:***
* *Curl 8.0>higher*
* *Bash 5.2>Higher*

***Where does it should work?***
* ***It should work on any linux system.***
* ***It had been tested in ubuntu 24.04 and ran perfectly.***

***What's new in the version 0.2 #***
* ***You can set a customised filename to save your shorten url.***
* ***Consequently, you now can choose whether to save or not your url.***
* ***There are more conditionals and logical structure, making the script slightly more stable.***

***Notes for the version 0.1 #***
* ***It must be executed with superuser privileges; otherwise, it will not open.***
* ***If you don't have curl in your system, it will download it automatically.***
* ***It saves your shortening URL in a text file.***

***How to install it?***
1. Run this in your bash.
```
# Run this in your terminal
git clone 'https://github.com/Flexdev45/Shorter.git';
cd 'Shorter';
sudo bash shorter.sh;
```
