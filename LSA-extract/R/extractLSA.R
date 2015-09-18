
startLSA <- function(){


  print("starting extractLSA!")


    #run the selenuim server and deal with any errors
    serverResult <<- tryCatch({


      if(!require(RSelenium)) {require(RSelenium)}
      if(!require(XML)) {require(XML)}

      RSelenium::checkForServer()
      RSelenium::startServer()
      remDrv <<- remoteDriver$new()
      #open browser
      remDrv$open()
      print('Sucessfully started the Selenium Server!')

      }, warning = function(war) {

      print(war)

      }, error = function(err) {
        print(err)
        print("Make sure you have RSelenium installed, and have permissions to run selenium server (run it manually as a standalone)!")

      }, finally = {



        }) #end try-catch

    return(serverResult)
}

queryLSA <- function(wordlist){

  #check result of trying to start selenium server in case user stubbornly ignored earlier warning
  if(serverResult=='Sucessfully started the Selenium Server!'){


    #go to lsa site for matrix comparison
    url <- 'http://lsa.colorado.edu/cgi-bin/LSA-matrix.html'
    remDrv$navigate(url)

    #get text area object
    webElem <- remDrv$findElement(using = 'name', "txt1")


    #add each elem of wordlist, put into text area
    for (word in wordlist) {

      webElem$sendKeysToElement(list(paste(word,"\n\n",sep="")))

    }

    #submit
    remDrv$findElement(using = "xpath", "//input[@value ='Submit Texts']")$clickElement()

    #get answer
    results<-htmlParse(remDrv$getPageSource()[[1]])

    #to make sure numbers are stored as integers, explicitly define datatyping in table conversion
    numwords = length(wordlist)
    datatypes=list();
    datatypes[1] = 'character'
    for(n in 1:numwords){
      datatypes[n+1] <- 'numeric'
    }

    #extract table from html
    tables <- readHTMLTable(results,header=TRUE,colClasses=datatypes)


    #get the table we want from the output and turn first column as a set of rownames
    outputTable<-tables[[1]]
    rowNames<-outputTable[,1]
    outputTable <- outputTable[,-1]
    rownames(outputTable)<-rowNames




    return(outputTable)


    }else{
      stop()  #exit program
    }




}

finishLSA <- function(){
    remDrv$closeWindow()
    remDrv$quit()

}




