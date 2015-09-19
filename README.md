# extractLSA
R code (BETA VERSION) for repeated querying of lsa.colorado.edu with a wordlist of the user's choice.

Instructions: 
> Download the files and put them into you R package library directory (e.g., /Users/me/Library/R)
> download Selenium standalone server -http://www.seleniumhq.org/download/- and double-click on the .jar file to run it
> call library('extractLSA') each time you want to use the package
> now you have three functions available to you:

1. startLSA()
  > Runs initialization of a selenium server and firefox browser. run once per session.

2. queryLSA(list)
   > Function that queries the LSA database matrix function for all of the words you supplied. 
   > argument: a list
   > returns a table with the values.
   > example: queryLSA(c("orange","banana"))  will return the pairwise similarity of the words orange and banana.
   > You can supply any length of list. 


3. finishLSA()
  > This just closes the web browser and stops the server.
