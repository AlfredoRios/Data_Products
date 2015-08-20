library(RColorBrewer)
library(shiny)
library(UsingR)
library(maps)
library(ggplot2)
STATE=c("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA",
        "MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR",
        "RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY")
INTERCEPT=c(-18.34,-17.11,-17.51,-18.75,-19.16,-19.12,-18.48,-18.33,-18.51,-18.47,-18.18,-18.60,-18.58,-18.91,
            -18.05,-17.66,-17.91,-18.14,-18.43,-17.02,-18.78,-18.55,-17.48,-18.13,-17.45,-17.46,-18.76,-18.31,
            -18.66,-18.76,-18.51,-18.64,-18.99,-18.62,-18.61,-17.77,-17.85,-18.77,-18.25,-18.40,-18.35,-18.77,
            -18.84,-17.32,-17.48,-18.72,-18.72,-18.48,-18.69,-18.25,-18.68,-18.89)
COEF=c(-3.222925,1.117664,-0.1310816,0.004847639)
STATE_index=rep(STATE,12)
montrange=rep(1:12,each=52)
M=as.matrix(cbind(rep(INTERCEPT,12),montrange,montrange^2,montrange^3,montrange^4))
STS_PROB=plogis(M%*%(c(1,COEF))) #### This are the values
cut_bal=cut(STS_PROB,9)
mypalette<-brewer.pal(9,"Reds")
m_index=rep(1:12,each=52)
cols=rep(NA,52*12)
for(n in 1:(52*12)){
  nn=which(levels(cut_bal)==(cut_bal[n]))
  cols[n]=mypalette[nn]
}

mapnames <- map("state", plot=FALSE)$names
region_list <- strsplit(mapnames, ":")
mapnames2 <- sapply(region_list, "[", 1)

shinyServer(
  function(input, output) {
    index1<-reactive(which(STATE_index==input$stat_input & montrange==input$MonthChosen))
    index2<-reactive(which(STATE_index==input$stat_input2 & montrange==input$MonthChosen))
    PROB=reactive(STS_PROB[{index1()}])
    PROB2=reactive(STS_PROB[{index2()}])
    RATIO=reactive({PROB()}/{PROB2()})
    x<-reactive(as.numeric({PROB()}))
    y<-reactive(as.numeric({RATIO()}))
    output$ostat_input2=renderText({RATIO()})
    output$ostat_input=renderText({x()})
    output$Mat_plot <- renderPlot({
        month=input$month
        col_sel=cols[which(m_index==month)]
        cols2=col_sel[match(mapnames2,tolower(state.name[match(STATE,state.abb)]))]
        map("state",col=cols2,fill=T)
    })
    
  }
)