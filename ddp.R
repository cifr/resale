library(plyr)
library(stats)

if (!exists("ddp")) {
    furl <- 'https://data.gov.sg/dataset/7a339d20-3c57-4b11-a695-9348addpd7614/download'
    fzip <- 'resale-flat-prices.zip'
    fdat <- 'resale-flat-prices-based-on-registration-date-from-march-2012-onwards.csv'
    if (!file.exists(fzip)) download.file(furl, destfile=fzip, mode='wb', quiet=TRUE)
    if (!file.exists(fdat)) unzip(fzip, files=c(fdat))
    
    ddp <- read.csv(fdat, as.is=TRUE)
    ddp$month <- as.Date(paste0(ddp$month, "-01"), "%Y-%m-%d")
    ddp$town <- factor(ddp$town)
    ddp$flat_type <- factor(ddp$flat_type)
    ddp$flat_model <- factor(ddp$flat_model)
    ddp$storey_range <- factor(ddp$storey_range)

    ddp <- mutate(ddp, age_year=as.numeric(format(Sys.Date(), "%Y"))-lease_commence_date)
    ddp <- ddp[, c("month", "town", "flat_type", "floor_area_sqm", "flat_model", 
                "age_year", "storey_range", "resale_price")]

    ddp.lm0 <- lm(resale_price ~ flat_type + town + floor_area_sqm + age_year, data=ddp)
    
    ddp.min_floor_area <- round(min(ddp$floor_area_sqm))
    ddp.max_floor_area <- round(max(ddp$floor_area_sqm))
    ddp.towns <- levels(ddp$town)
    ddp.flat_types <- levels(ddp$flat_type)
}

ddp.default <- ddp[sample(nrow(ddp), 1),]