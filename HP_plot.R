library(plotly)
library(googledrive)
library(ggplot2)
library(dplyr)

##download file
temp <- tempfile(fileext = ".zip")
dl <- drive_download(
  as_id("https://drive.google.com/open?id=1dyKTsCDegBCDDBDVJRJAf_JIUxd8YcET"), path = temp, overwrite = TRUE)
out <- unzip(temp, exdir = tempdir())
expenditure <- read.csv(out, header = TRUE, stringsAsFactors = FALSE)
expenditure$TRANSDATE <- as.Date(expenditure$TRANSDATE, format = "%Y-%m-%d")

expenditure <- expenditure %>% mutate(month = month(TRANSDATE))

Sumpayment <- 
  expenditure %>% 
  group_by(month,District,SOE_description)%>%
  summarise(Total = sum(NETPAYMENT, na.rm = TRUE))

trace1 <- list(
  line = list(
    color = "#FFD700", 
    width = 3
  ), 
  name = "All", 
  type = "bar", 
  x = Sumpayment$month, 
  y = Sumpayment$Total
)
trace2 <- list(
  line = list(
    color = "#C0C0C0", 
    width = 3
  ), 
  name = "AMB", 
  type = "bar", 
  x = subset(Sumpayment, District =="AMB")$month, 
  y = subset(Sumpayment, District =="AMB")$Total
)
trace3 <- list(
  line = list(
    color = "#BA8651", 
    width = 3
  ), 
  name = "ANI", 
  type = "bar", 
  x = subset(Sumpayment, District =="ANI")$month, 
  y = subset(Sumpayment, District =="ANI")$Total
)
trace4 <- list(
  line = list(
    color = "#000000", 
    width = 3
  ), 
  name = "ARKI", 
  type = "bar", 
  x = subset(Sumpayment, District =="ARKI")$month, 
  y = subset(Sumpayment, District =="ARKI")$Total
)








data <- list(trace1)
layout <- list(
  title = "2016 Summer Olympic Medal Count", 
  updatemenus = list(
    list(
      x = -0.05, 
      y = 1, 
      buttons = list(
        list(
          args = c("visible", c(TRUE, TRUE, TRUE, TRUE)), 
          label = "All", 
          method = "restyle"
        ), 
        list(
          args = c("visible", c(TRUE, FALSE, FALSE, FALSE)), 
          label = "AMB", 
          method = "restyle"
        ), 
        list(
          args = c("visible", c(FALSE, TRUE, FALSE, FALSE)), 
          label = "Silver", 
          method = "restyle"
        ), 
        list(
          args = c("visible", c(FALSE, FALSE, TRUE, FALSE)), 
          label = "Bronze", 
          method = "restyle"
        ), 
        list(
          args = c("visible", c(FALSE, FALSE, FALSE, TRUE)), 
          label = "Total", 
          method = "restyle"
        )
      ), 
      yanchor = "top"
    )
  )
)
p <- plot_ly()
p <- add_trace(p, line=trace1$line, name=trace1$name, type=trace1$type, x=trace1$x, y=trace1$y)
p <- add_trace(p, line=trace2$line, name=trace2$name, type=trace2$type, x=trace2$x, y=trace2$y)
p <- layout(p, title=layout$title, updatemenus=layout$updatemenus)

