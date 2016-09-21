library(shiny)
source("ddp.R")

shinyUI(fluidPage(
    titlePanel("Price of Resale Flats in Singapore"),
    sidebarPanel(
        selectInput("flat_type", "Flat Type", ddp.flat_types,
                    selected=ddp.default$flat_type),
        selectInput("town", "Town", ddp.towns,
                    selected=ddp.default$town),
        sliderInput("floor_area_sqm", "Floor Area (SQM)", ddp.default$floor_area_sqm,
                     min=ddp.min_floor_area, max=ddp.max_floor_area, step=1),
        sliderInput("age_year", "Flat Age (Y)", ddp.default$age_year,
                     min=5, max=99, step=1),
        br(),
        p("Prediction model based on historical data from ",
          a("Resale Flat Prices",
            href="https://data.gov.sg/dataset/resale-flat-prices"),
          "(data.gov.sg)"),
        br()
    ),
    mainPanel(
        h3(textOutput("resale_price")),
        textOutput("message"),
        plotOutput("resale_chart")
    )
))