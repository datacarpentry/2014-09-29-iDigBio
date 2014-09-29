
allHol <- read.csv(file="original/occurrence.txt", stringsAsFactors=FALSE)


indices <- split(rownames(allHol), factor(allHol$dwc.scientificName))

xx <- mapply(function(x, y) {
    y <- gsub("\\s", "_", y)
    rNb <- runif(1)
    if (rNb < 0.33) {
        y <- gsub("^Holothuria", "holo", y)
    } else if (rNb > 0.33 && rNb < 0.66) {
        y <- gsub("^Holothuria", "H.", y)
    } else {
        y <- gsub("^Holothuria", "Hol", y)
    }
    tmpDt <- allHol[x, sample(1:ncol(allHol))]
    write.csv(tmpDt, file=file.path("split_files", paste0(y, ".csv")))
}, indices, levels(factor(allHol$dwc.scientificName)))
