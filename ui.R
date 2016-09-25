library(shiny)
source("resale.R")

shinyUI(fluidPage(
    titlePanel("Price of Resale Flats in Singapore"),
    sidebarLayout(
        sidebarPanel(
            selectInput("flat_type", "Flat Type", ddp.flat_types,
                        selected=ddp.default$flat_type),
            selectInput("town", "Town", ddp.towns,
                        selected=ddp.default$town),
            sliderInput("floor_area_sqm", "Floor Area (SQM)", ddp.default$floor_area_sqm,
                        min=ddp.default_floor_limits[1], max=ddp.default_floor_limits[2],
                        step=1),
            sliderInput("age_year", "Flat Age (Y)", ddp.default$age_year,
                         min=5, max=max(ddp$age_year), step=1),
            br(), br(), p(a("https://github.com/cifr/resale", href="https://github.com/cifr/resale"))
        ),
        mainPanel(
            h3(textOutput("resale_price")),
            textOutput("message"),
            plotOutput("resale_chart")
        )),
    hr(),
    p(class="small", "This prediction model built based on historical data from ",
      a("Resale Flat Prices", href="https://data.gov.sg/dataset/resale-flat-prices"),
      "(data.gov.sg) shall not be attributed to the Singapore Government or its Statutory Boards;",
      "The datasets provided by the Singapore Government and its Statutory Boards via Data.gov.sg",
      "are governed by the Terms of Use available at ", 
      a("https://data.gov.sg/terms", href="https://data.gov.sg/terms"), 
      ". To the fullest extent permitted by law, the Singapore Government and its Statutory Boards",
      "are not liable for any damage or loss of any kind caused directly or indirectly by the use",
      "of the datasets or any derived analyses or applications.")
))