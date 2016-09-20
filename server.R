
source("ddp.R")

library(ggplot2)
library(scales)

pp <- function(df, ns=0) { 
    format(df, digits=1, nsmall=ns, big.mark=",", scientific=FALSE)
}

shinyServer(
    function(input, output) {
        lm.arg <- reactive({
            x <- data.frame(cbind(input$flat_type,
                                  input$town,
                                  input$floor_area_sqm,
                                  input$age_year),
                            stringsAsFactors=FALSE)
            names(x) <- c("flat_type", "town", "floor_area_sqm", "age_year")
            x$floor_area_sqm <- as.numeric(x$floor_area_sqm)
            x$age_year <- as.numeric(x$age_year)
            x
        })
        
        xdf <- reactive({
            ddp[ddp$flat_type==factor(input$flat_type, ddp.flat_types) & 
                ddp$town==factor(input$town, ddp.towns), ]
        })
        
        output$resale_price <- renderText({
            x <- as.data.frame(lm.arg())
            est <- paste0("S$ ", pp(predict(ddp.lm0, x)))
            paste0("Price Estimation: ", est)
        })
        
        output$message <- renderText({
            if (nrow(xdf()) == 0) {
                paste0("No historical data available for ", input$flat_type, 
                       " flat in ", input$town, ".")
            }
        })
                
        output$resale_chart <- renderPlot({
            x <- xdf()
            if (nrow(x) == 0) return(NULL)
            y <- predict(ddp.lm0, as.data.frame(lm.arg()))
            g <- ggplot(x, aes(x=month, y=resale_price, color=floor_area_sqm)) + geom_point()
            g <- g + scale_color_gradient(name="Floor Area (SQM)") 
            g <- g + geom_hline(yintercept=y, color="red", lab)
            g <- g + scale_y_continuous(labels=comma)
            g <- g + xlab("Transaction Date") + ylab("Resale Price (S$)")
            g
        })
    }
)