

rename_holothuria <- function(input_path="data/split_files",
                              output_path="data_output/split_files",
                              pattern="(^H\\.|^Hol|^holo)",
                              family="Holothuriidae") {
    oldNm <- list.files(pattern=pattern, path=input_path)
    if (length(oldNm) < 1) {
        stop("No file found.")
    }
    newNm <- paste(family, gsub(pattern, "Holothuria", oldNm), sep="-")
    nm <- cbind(file.path(input_path, oldNm), file.path(output_path, newNm))
    testRnm <- apply(nm, 1, function(x) file.copy(x[1], x[2]))
    if(all(testRnm)) {
        message("All good!")
        TRUE
    } else {
        warning("Something went wrong.")
        FALSE
    }
}



collect_holothuria <- function(pattern="^Holothuriidae-", path="data_output/split_files") {

    holFiles <- list.files(path=path, pattern=pattern)

    ## create empty data.frame to store the results
    res <- data.frame()

    for (i in 1:length(holFiles)) {
        tmpFile <- read.csv(file.path(path, holFiles[i]), stringsAsFactors=FALSE)

        ## write a command that selects the following columns from tmpFile.
        ## dwc.family
        ## dwc.genus
        ## dwc.specificEpithet
        ## idigbio.uuid
        ## dwc.scientificName
        ## dwc.occurrenceID
        ## dwc.decimalLatitude
        ## dwc.decimalLongitude
        tmpFile <- ...

        ## write a command that adds these selected columns to our storage data.frame `res`
        res <- ...
    }
    res
}




