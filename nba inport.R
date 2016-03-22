if (!require('SportsAnalytics')){
  install.packages("SportsAnalytics")
  library(SportsAnalytics)
}
NBA1415<-fetch_NBAPlayerStatistics("14-15")
NBA1415
apply(NBA1415,2,max)

MaxEFF<-aggregate(NBA1415$TotalPoints/TotalMinutesPlayed~Team,NBA1415,max)
EffectivePlayer<-tapply(NBA1415$Name,NBA1415$Team,max,NBA1415$TotalPoints/NBA1415$TotalMinutesPlayed)
                      
NBA1415MaxEFF<-merge(NBA1415,EffectivePlayer)
output<-NBA1415MaxEFF[order(NBA1415MaxEFF$TotalPoints/NBA1415MaxEFF$TotalMinutesPlayed,decreasing = T),c("Team","Name","TotalPoints")]
library(knitr)
kable(output, digits=2)
