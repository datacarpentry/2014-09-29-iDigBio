

# Data Carpentry R materials - Starting with data

--------------------------------------------------

# Objectives

We want to:
* load external data (CSV files) in memory using the survey table (`surveys.csv`) as an example
* understand its structure
  - understand the concept of a `data.frame`
  - understand the concept of `NA`
  - know how to access any element of a `data.frame`
* being able to subset for a level
* being able to extract particular values from a `data.frame`
* being able to add/remove columns and rows
* being able to generate summary statistics from the data
* calculate basic statistics across a levels of a factor (here species)
* generate plot from the data using the average weights of the animals as an example

----------------------------------------------------

# Presentation of the Survey Data



We are studying the species and weight of animals caught in plots in our study
area.  The dataset is stored as a `.csv` file: each row holds information for a
single animal, and the columns represent `survey_id` (represented as global
unique identifier, GUID), `month`, `day`, `year`, `plot` (represented as a
GUID), `species` (a 2 letter code, see the `species.csv` file for
correspondance), `sex` ("M" for males and "F" for females), `wgt` (the weight in
grams).

The first few rows of the survey dataset look like this:

    "3a15270e-09c7-47a3-ab2e-0ffcbda1f162","8","19","1977","b564c1fc-bd87-4525-92ee-8bb36928fc10","DM","M","40"
    "72ab0a58-4e6d-4aa7-b5c7-abb10d49c141","8","19","1977","a7498949-7b94-4f8e-b253-3e26bbf80710","DM","M","48"
    "a174df84-6bf3-42bb-8dae-be3fd45566a7","8","19","1977","7dcaddf5-d272-4b69-a49c-d4f3cf000084","DM","F","29"
    "3658f574-1f07-4601-b053-f8656cb731cf","8","19","1977","7dcaddf5-d272-4b69-a49c-d4f3cf000084","DM","F","46"
    "0d17daf5-df94-475a-b57f-8aea2477cee3","8","19","1977","a7498949-7b94-4f8e-b253-3e26bbf80710","DM","M","36"


To load our survey data, we need to locate the `surveys.csv` file. We will use
`read.csv()` to load into memory (as a `data.frame`) the content of the CSV
file.

* [download the data file](https://github.com/datacarpentry/2014-09-29-iDigBio/raw/master/data/biology/surveys.csv)
* put it in directory "data" within your working directory for these exercises



```r
surveys <- read.csv('data/surveys.csv')
```

<!--- this chunk if for internal use so code in this lesson can be evaluated --->


This statement doesn't produce any output because assignment doesn't display anything. If we want to check that our data has been loaded, we can print the variable's value:

```r
surveys
```

Wow... that was a lot of output. At least it means the data loaded properly. Let's check the top (the first 6 lines) of this `data.frame` using the function `head()`:


```r
head(surveys)
```

```
##                              survey_id month day year
## 1 8f58c260-4b8d-4efb-893c-84f0e4ce9e9a     7  16 1977
## 2 1445e762-ace8-4f00-b01d-d6f75a7ba753     7  16 1977
## 3 8c5fe0a9-1f7d-46d2-8e9d-237b310d3fde     7  16 1977
## 4 38ef8288-7db5-45df-9435-2f7ffe8a90ef     7  16 1977
## 5 4d9f6537-7aac-4713-a390-80877ef21f6f     7  16 1977
## 6 fae16612-97dc-4c09-bb74-ce0f3e2d3919     7  16 1977
##                                plot_id species sex wgt
## 1 aeece3f0-4acf-4aaa-87cd-e04ac6c8ad2c    <NA>   M  NA
## 2 b564c1fc-bd87-4525-92ee-8bb36928fc10    <NA>   M  NA
## 3 aeece3f0-4acf-4aaa-87cd-e04ac6c8ad2c      DM   F  NA
## 4 a7498949-7b94-4f8e-b253-3e26bbf80710      DM   M  NA
## 5 b564c1fc-bd87-4525-92ee-8bb36928fc10      DM   M  NA
## 6 b7eb122e-a7c4-4982-97a0-fa67e45e6faf      PF   M  NA
```

__At this point, make sure all participants have the data loaded__

Let's now check the __str__ucture of this `data.frame` in more details with the function `str()`:


```r
str(surveys)
```

_Show how to get this information from the "Environment" tab in RStudio._

### Exercise

Based on the output of `str(surveys)`, can you answer the following questions?

* What is the class of the object `surveys`?
* How many rows and how many columns are in this object?
* How many species have been recorded during these surveys?



# About the `data.frame` class



`data.frame` is the _de facto_ data structure for most tabular data and what we
use for statistics and plotting.

A `data.frame` is a collection of vectors of identical lengths. Each vector
represents a column, and each vector can be of a different data type (e.g.,
characters, integers, factors). The `str()` function is useful to inspect the
data types of the columns.

<!---
Data frames can have additional attributes such as `rownames()`, which can be
useful for annotating data, like subject_id or sample_id. But most of the time
they are not used.
--->

`data.frame` can be created by the functions `read.csv()` or `read.table()`, in
other words, when importing spreadsheets from your hard drive (or the web).

By default, `data.frame` convert (= coerce) columns that contain characters
(i.e., text) into the `factor` data type. Depending on what you want to do with
the data, you may want to keep these columns as `character`. To do so,
`read.csv()` and `read.table()` have an argument called `stringsAsFactors` which
can be set to `FALSE`:


```r
some_data <- read.csv("data/some_file.csv", stringsAsFactors=FALSE)
```

<!--- talk about colClasses argument?  --->

You can also create `data.frame` manually with the function `data.frame()`. This
function can also take the argument `stringsAsFactors`. Compare the output of
these examples:


```r
example_data <- data.frame(animal=c("dog", "cat", "sea cucumber", "sea urchin"),
                           feel=c("furry", "furry", "squishy", "spiny"),
                           weight=c(45, 8, 1.1, 0.8))
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: Factor w/ 4 levels "cat","dog","sea cucumber",..: 2 1 3 4
##  $ feel  : Factor w/ 3 levels "furry","spiny",..: 1 1 3 2
##  $ weight: num  45 8 1.1 0.8
```

```r
example_data <- data.frame(animal=c("dog", "cat", "sea cucumber", "sea urchin"),
                           feel=c("furry", "furry", "squishy", "spiny"),
                           weight=c(45, 8, 1.1, 0.8), stringsAsFactors=FALSE)
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: chr  "dog" "cat" "sea cucumber" "sea urchin"
##  $ feel  : chr  "furry" "furry" "squishy" "spiny"
##  $ weight: num  45 8 1.1 0.8
```

__Point to the differences between character and factor output with str()__


### Exercises

1. There are a few mistakes in this hand crafted `data.frame`, can you spot and
fix them? Don't hesitate to experiment!

   
   ```r
   ##  There are a few mistakes in this hand crafted `data.frame`,
   ##  can you spot and fix them? Don't hesitate to experiment!
   author_book <- data.frame(author_first=c("Charles", "Ernst", "Theodosius"),
                                author_last=c(Darwin, Mayr, Dobzhansky),
                                year=c(1942, 1970))
   ```

1. Can you predict the class for each of the columns in the following example?

   
   ```r
   ## Can you predict the class for each of the columns in the following example?
   ## Check your guesses using `str(country_climate)`. Are they what you expected?
   ##  Why? why not?
   country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                                  climate=c("cold", "hot", "temperate", "hot/temperate"),
                                  temperature=c(10, 30, 18, "15"),
                                  north_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                                  has_kangaroo=c(FALSE, FALSE, FALSE, 1))
   ```

   Check your guesses using `str(country_climate)`. Are they what you expected?
   Why? why not?Check your gueses using `str(country_climate)`. Are they what you expected?
   Why? why not?

   R coerces (when possible) to the data type that is the least common
   denominator and the easiest to coerce to.


## Inspecting `data.frame` objects

We already saw how the functions `head()` and `str()` can be useful to check the
content and the structure of a `data.frame`. Here is a non-exhaustive list of
functions to get a sense of the content/structure of the data.

* Size:
	* `dim()` - returns a vector with the number of rows in the first element, and
	  the number of columns as the second element (the __dim__ensions of the object)
	* `nrow()` - returns the number of rows
	* `ncol()` - returns the number of columns
* Content:
	* `head()` - shows the first 6 rows
	* `tail()` - shows the last 6 rows
* Names:
	* `names()` - returns the column names (synonym of `colnames()` for `data.frame`
	objects)
	* `rownames()` - returns the row names
* Summary:
	* `str()` - structure of the object and information about the class, length and
	content of  each column
	* `summary()` - summary statistics for each column

Note: most of these functions are "generic", they can be used on other types of
objects besides `data.frame`.

## Indexing and sequences



If we want to extract one or several values from a vector, we must provide one
or several indices in square brackets, just as we do in math. For instance:


```r
animals <- c("mouse", "rat", "dog", "cat")
animals[2]
```

```
## [1] "rat"
```

```r
animals[c(3, 2)]
```

```
## [1] "dog" "rat"
```

```r
animals[2:4]
```

```
## [1] "rat" "dog" "cat"
```

```r
more_animals <- animals[c(1:3, 2:4)]
more_animals
```

```
## [1] "mouse" "rat"   "dog"   "rat"   "dog"   "cat"
```

R indexes start at 1. Programming languages like Fortran, MATLAB, and R start
counting at 1, because that's what human beings have done for thousands of
years.  Languages in the C family (including C++, Java, Perl, and Python) count
from 0 because that's simpler for computers to do.

`:` is a special function that creates numeric vectors of integer in increasing
or decreasing order, test `1:10` and `10:1` for instance. The function `seq()`
(for __seq__uence) can be used to create more complex patterns:


```r
seq(1, 10, by=2)
```

```
## [1] 1 3 5 7 9
```

```r
seq(5, 10, length.out=3)
```

```
## [1]  5.0  7.5 10.0
```

```r
seq(50, by=5, length.out=10)
```

```
##  [1] 50 55 60 65 70 75 80 85 90 95
```

```r
seq(1, 8, by=3) # sequence stops to stay below upper limit
```

```
## [1] 1 4 7
```

Our survey data frame has rows and columns (it has 2 dimensions), if we want to
extract some specific data from it, we need to specify the "coordinates" we want
from it. Row numbers come first, followed by column numbers.


```r
surveys[1, 1]   # first element in the first column of the data frame
surveys[1, 6]   # first element in the 6th column
surveys[1:3, 7] # first three elements in the 7th column
surveys[3, ]    # the 3rd element for all columns
surveys[, 8]    # the entire 8th column
head_surveys <- surveys[1:6, ] # surveys[1:6, ] is equivalent to head(surveys)
```

### Exercices

1. The function `nrow()` on a `data.frame` returns the number of rows. Use it,
   in conjuction with `seq()` to create a new `data.frame` called
   `surveys_by_10` that includes every 10th row of the survey data frame
   starting at row 10 (10, 20, 30, ...)



<!---

```r
surveys_by_10 <- surveys[seq(10, nrow(surveys), by=10), ]
```
--->

# Manipulating data

## Subsetting data



In particular for larger datasets, it can be tricky to remember the column
number that corresponds to a particular variable. (Are species names in column 5
or 7? oh, right... they are in column 6). In some cases, in which column the
variable will be can change if the script you are using adds or removes
columns. It's therefore often better to use column names to refer to a
particular variable, and it makes your code easier to read and your intentions
clearer.

You can do operations on a particular column, by selecting it using the `$`
sign. In this case, the entire column is a vector. For instance, to extract all
the weights from our datasets, we can use: `surveys$wgt`. You can use
`names(surveys)` or `colnames(surveys)` to remind yourself of the column names.

In some cases, you may way to select more than one column. You can do this using
the square brackets: `surveys[, c("wgt", "sex")]`.

When analyzing data, though, we often want to look at partial statistics, such
as the maximum value of a variable per species or the average value per plot.

One way to do this is to select the data we want, and create a new temporary
array, using the `subset()` function. For instance, if we just want to look at
the animals of the species "DO":


```r
surveys_DO <- subset(surveys, species == "DO")
```

### Exercises

1. What does the following do?



1. Use the function `subset` twice to create a `data.frame` that contains all
individuals of the species "DM" that were collected in 2002.
  * How many individuals of the species "DM" were collected in 2002?



## Adding a column to our dataset



Sometimes, you may have to add a new column to your dataset that represents a
new variable. You can add columns to a `data.frame` using the function `cbind()`
(__c__olumn __bind__). Beware, the additional column must have the same number
of elements as there are rows in the `data.frame`. As an example, let's generate
a vector of random numbers (using the function `runif()`) that will represent
the variable `random_index` that we want to add to our `data.frame` survey. The
function `runif()` takes as an argument the number of random numbers to
generate, in our case, we want the number of rows in the surveys dataset.


```r
r_ind <- runif(nrow(surveys))
surveys_index <- cbind(surveys, random_index=r_ind)
```

### Exercise

How many columns are now in (1) the `data.frame` `surveys`, (2) the `data.frame`
`surveys_index`?



<!--- should we cover merge()? --->

## Adding rows

<!--- even if this is not optimal, using this approach requires to cover less   -->
<!--- material such as logical operations on vectors. Depending on how fast the -->
<!--- group moves, it might be better to show the correct way.                  -->



Let's create a `data.frame` that contains the information only for the species
"DO" and "DM". We know how to create the data set for each species with the
function `subset()`:


```r
surveys_DO <- subset(surveys, species == "DO")
surveys_DM <- subset(surveys, species == "DM")
```

Similarly to `cbind()` for columns, there is a function `rbind()` (__r__ow
__bind__) to put together two `data.frame`. With `rbind()` the number of columns
and their names must be identical between the two objects:


```r
surveys_DO_DM <- rbind(surveys_DO, surveys_DM)
```

### Exercise

Using a similar approach, construct a new `data.frame` that only includes data
for the years 2000 and 2001.



## Removing columns



Just like you can select columns by their positions in the `data.frame` or by
their names, you can remove them similarly.

To remove it by column number:


```r
surveys_noDate <- surveys[, -c(2:4)]
colnames(surveys)
```

```
## [1] "survey_id" "month"     "day"       "year"      "plot_id"   "species"  
## [7] "sex"       "wgt"
```

```r
colnames(surveys_noDate)
```

```
## [1] "survey_id" "plot_id"   "species"   "sex"       "wgt"
```

The easiest way to remove by name is to use the `subset()` function. This time
we need to specify explicitly the argument `select` as the default is to subset
on rows (as above). The minus sign indicates the names of the columns to remove
(note that the column names should not be quoted):


```r
surveys_noDate2 <- subset(surveys, select=-c(month, day, year))
colnames(surveys_noDate2)
```

```
## [1] "survey_id" "plot_id"   "species"   "sex"       "wgt"
```

## Removing rows



Typically rows are not associated with names, so to remove them from the
`data.frame`, you can do:


```r
surveys_missingRows <- surveys[-c(10, 50:70), ] # removing rows 10, and 50 to 70
```

# Analyzing data

## Calculating statistics



Let's get a closer look at our data. For instance, we might want to know how
many animals we trapped in each plot, or how many of each species were caught.

So, let's get a `vector` of all the species. The `unique()` function tells us
all the unique names in that column.


```r
unique(surveys$species)
```

Now, let's see how many of each species we have:


```r
table(surveys$species)
```

R has a lot of built in statistical functions, like `mean()`, `median()`,
`max()`, `min()`. Let's start by calculating the average weight of all the
animals using the function `mean()`:


```r
mean(surveys$wgt)
```

```
## [1] NA
```

Hmm, we just get `NA`. That's because we don't have the weight for every animal
and missing data is recorded as `NA`. By default, all R functions operating on a
vector that contains missing data will return NA. It's a way to make sure that
users know they have missing data, and make a conscious decision on how to deal
with it.

When dealing with simple statistics like the mean, the easiest way to ignore
`NA` (the missing data) is to use `na.rm=TRUE` (`rm` stands for remove):


```r
mean(surveys$wgt, na.rm=TRUE)
```

```
## [1] 42.67
```

In some cases, it might be useful to remove the missing data from the
vector. For this purpose, R comes with the function `na.omit`:


```r
wgt_noNA <- na.omit(surveys$wgt)
```

For some applications, it's useful to keep all observations, for others, it
might be best to remove all observations that contain missing data. The function
`complete.cases()` removes all rows that contain some missing data:


```r
surveys_complete <- surveys[complete.cases(surveys), ]
```

<!--- need to cover negation, and vector operations for this...
If you want to remove only the observations that are missing data for one
variable, you can use the function `is.na()`. For instance, to create a new
dataset that only contains individuals that have been weighted:


```r
surveys_with_weights <- surveys[!is.na(surveys$weight), ]
```

```
## Warning: is.na() applied to non-(list or vector) of type 'NULL'
```
--->

### Exercise

1. To determine the number of elements found in a vector, we can use
use the function `length()` (e.g., `length(surveys$wgt)`). Using `length()`, how
many animals have not had their weights recorded?

1. What is the median weight for the males?

1. What is the range (minimum and maximum) weight?

1. Bonus question: what is the standard error for the weight? (hints: there is
   no built-in function to compute standard errors, and the function for the
   square root is `sqrt()`).



## Statistics across factor levels



What if we want the maximum weight for all animals, or the average for each
plot?

R comes with convenient functions to do this kind of operations, functions in
the `apply` family.

For instance, `tapply()` allows us to repeat a function across each level of a
factor. The format is:


```r
tapply(columns_to_do_the_calculations_on, factor_to_sort_on, function)
```

If we want to calculate the mean for each species (using the complete dataset):


```r
tapply(surveys_complete$wgt, surveys_complete$species, mean)
```

This produces some `NA` because R "remembers" all species that were found in the
original dataset, even if they didn't have any weight data associated with them
in the current dataset. To remove the `NA` and make things clearer, we can
redefine the levels for the factor "species" before calculating the means. Let's
also create an object to store these values:


```r
surveys_complete$species <- factor(surveys_complete$species)
species_mean <- tapply(surveys_complete$wgt, surveys_complete$species, mean)
```

### Exercise

1. Create new objects to store: the standard deviation, the maximum and minimum
   values for the weight of each species
1. How many species do you have these statistics for?
1. Create a new data frame (called `surveys_summary`) that contains as columns:
   * `species` the 2 letter code for the species names
   * `mean_wgt` the mean weight for each species
   * `sd_wgt` the standard deviation for each species
   * `min_wgt`  the minimum weight for each species
   * `max_wgt`  the maximum weight for each species



**Answers**


```r
species_max <- tapply(surveys_complete$wgt, surveys_complete$species, max)
species_min <- tapply(surveys_complete$wgt, surveys_complete$species, min)
species_sd <- tapply(surveys_complete$wgt, surveys_complete$species, sd)
nlevels(surveys_complete$species) # or length(species_mean)
surveys_summary <- data.frame(species=levels(surveys_complete$species),
                              mean_wgt=species_mean,
                              sd_wgt=species_sd,
                              min_wgt=species_min,
                              max_wgt=species_max)
```


# Plotting



The mathematician Richard Hamming once said, "The purpose of computing is
insight, not numbers", and the best way to develop insight is often to visualize
data. Visualization deserves an entire lecture (or course) of its own, but we
can explore a few features of R's base plotting package.

Let's use the `surveys_summary` data that we generated and plot it.

R has built in plotting functions.


```r
barplot(surveys_summary$mean_wgt)
```

![plot of chunk unnamed-chunk-52](figure/unnamed-chunk-52.png) 

The axis labels are too big though, so you can't see them all. Let's change that.


```r
barplot(surveys_summary$mean_wgt, cex.names=0.4)
```

![plot of chunk unnamed-chunk-53](figure/unnamed-chunk-53.png) 

Alternatively, we may want to flip the axes to have more room for the species names:


```r
barplot(surveys_summary$mean_wgt, horiz=TRUE, las=1)
```

![plot of chunk unnamed-chunk-54](figure/unnamed-chunk-54.png) 

Let's also add some colors, and add a main title, label the axis:


```r
barplot(surveys_summary$mean_wgt, horiz=TRUE, las=1,
        col=c("lavender", "lightblue"), xlab="Weight (g)",
        main="Mean weight per species")
```

![plot of chunk unnamed-chunk-55](figure/unnamed-chunk-55.png) 

### Exercises

1. Create a new plot showing the standard deviation for each species. Choose
   one or more colors from
   [here](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf). (If you
   prefer, you can also specify colors using their hexadecimal values
   `#RRGGBB`.)



## More about plotting

There's lots of different ways to plot things. You can do `plot(object)` for
most classes included in R base. To explore some of the possibilities:


```r
?barplot
?boxplot
?plot.default
example(barplot)
```

There's also a plotting package called [`ggplot2`](http://docs.ggplot2.org/)
that adds a lot of functionality. The syntax takes some getting used to but it's
extremely powerful and flexible.

If you wanted to output this plot to a pdf file rather than to the screen, you
can specify where you want the plot to go with the `pdf()` function. If you
wanted it to be a JPG, you would use the function `jpeg()` (other formats
available: svg, png, ps).

Be sure to add `dev.off()` at the end to finalize the file. For `pdf()`, you can
create multiple pages to your file, by generating multiple plots before calling
`dev.off()`.



```r
pdf("mean_per_species.pdf")
barplot(surveys_summary$mean_wgt, horiz=TRUE, las=1,
        col=c("lavender", "lightblue"), xlab="Weight (g)",
        main="Mean weight per species")
dev.off()
```
