library(rvest)
url<-"https://fbref.com/en/players/d70ce98e/matchlogs/2019-2020/summary/Lionel-Messi-Match-Logs"
my_html<-read_html(url)
my_tab<-html_nodes(my_html,"table")[[1]]
pop_tab<-html_table(my_tab)
head(pop_tab)
colnames(pop_tab)
cc<-c("date","day","comp","round","venue","result","squad","opponent","start","pos",
      "minutes","gls","ast","pk","pkatt","sh","sot","yellow","red","touches",
      "press","tkl","interceptions","blocks","xg","npxg","xa","sca","gca","passcomp",
      "passattemp","passcomppercent","progpass","carries","progcarries","successdrib",
      "attemptdrib","matchreport")
colnames(pop_tab)<-cc
pop_tab<-pop_tab[-1,]
head(pop_tab)
pop_tab<-pop_tab[!grepl("Argentina", pop_tab$squad),]
pop_tab$minutes<-as.numeric(pop_tab$minutes)
pop_tab<-pop_tab[!(is.na(pop_tab$minutes)), ]
head(pop_tab)

rownames(pop_tab)<-NULL
pop_tab<-cbind(pop_tab,substring(pop_tab$result, 1, 1),substring(pop_tab$result, 3, 3),substring(pop_tab$result, 5, 5))
colnames(pop_tab)[39:41]<-c("actresult","totgls","totglconceded")
head(pop_tab)

setwd("....")
write.csv(pop_tab,"messi.csv")





