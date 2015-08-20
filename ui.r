library(RColorBrewer)
library(UsingR)
library(maps)
library(ggplot2)
library(shiny)
shinyUI(pageWithSidebar(
  headerPanel(h3("Tornado App: Death or Injury Probability by Tornado in the US")),
  sidebarPanel(
    br(),br(),br(),
    h4("Map probabilities"),
    sliderInput('month', 'Month of the year',value = 1, min = 1, max = 12, step = 1)
    ,p("Slide the switch to change months and see how the probabilties change in the map"),br(),br(),
    br(),br(),br(),h5("Probability and Relative Risk"),
    selectInput("stat_input", 
                label = "STATE 1",
                choices = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"
                                  ),
                selected = "NY"),
    selectInput("stat_input2", 
                label = "STATE 2",
                choices = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"
                ),
                selected = "NY"),
    
    numericInput('MonthChosen','Month',1,min=1,max=12,step=1)
    ),
  
  
  
  mainPanel(
        plotOutput('Mat_plot'),
        p("The probability of dying or injury for STATE 1 is:"),
        verbatimTextOutput("ostat_input"),
        p("And the relative risk between STATE 1 and STATE 2 is:"),
        verbatimTextOutput("ostat_input2")
        )
))