#Q3 
#a)
Q3 <- readLines("C:/Users/Jeeyoon/Desktop/state_of_the_union.txt")
#b) 
grep("\\*{3}$", Q3)

#c)
c <- grep("^\\*{3}$", Q3)
index<-rep(F,171073)
index[c] <-T
which(index == "TRUE")
Date <- Q3[grep("^\\*{3}$", Q3)+4]
Date <- Date[grep("[[:digit:]]{4}", Date)]

#d)
require(stringr)
Year <- str_sub(Date2,-4,-1)
Year 

#e)
e <- unlist(strsplit(Date2, " "))
Month <- e[seq(from=1, to=length(e), by=3)]

#f)
President <- Q3[grep("^\\*{3}$", Q3)+3]
President <- President[grep("[[:alpha:]]$", President)]

#g)
Q3[grep("^\\*{3}$", Q3)+5]
Speech.st <- grep("^\\*{3}$", Q3) +5 
Speech.st <- Speech.st[1:214]
Q3[Speech.st]

Speech.end <- grep("^\\*{3}$", Q3) -1
Q3[grep("^\\*{3}$", Q3)-1]
Q3[grep("^\\*{3}$", Q3)-2]

Speech.end <- Speech.end[-1]
Speech.end <- Speech.end[-215]

Speech.index <- data.frame(Speech.st, Speech.end)

Speech = matrix(nrow=214, ncol=1)
for (i in 1:214){
      Speech[i] <- paste(Q3[Speech.index$Speech.st[i]:Speech.index$Speech.end[i]], sep=" ", collapse=" " )
}

Speech.g <- as.data.frame(Speech)

#h)
Speech.h <- apply(Speech, 1, function(x) str_split(Speech,"\\.|\\?"))

#i)
Speech.i <- gsub("\\'", "", Speech)
Speech.i <- gsub("[[:digit:]]{1,}", "", Speech.i)
Speech.i <- gsub("\\(Applause\\.\\)", "", Speech.i)

#j)
Speech.j <- tolower(Speech.i)

#k)
require(stringr)
Speech.k <- str_split(Speech.j, "[[:blank:]]|[[:punct:]]")

#l)
Speech.l=list()
for(i in 1:length(Speech.k)){
  Speech.l[[i]]=Speech.k[[i]][nchar(Speech.k[[i]])>0]
}

#m)
require(SnowballC)
Speech.m <- wordStem(Speech.l)

#n)
Speech.n <- sort(unique(unlist(Speech.m)))

#o)
require(stringr)
Speech.o <- unlist(str_split(Speech, " "))



