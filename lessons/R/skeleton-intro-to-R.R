


### Creating objects (assignments)



















### Vectors and data types















### Factors



sex <- factor(c("male", "female", "female", "male"))







f <- factor(c(1, 5, 10, 2))
as.numeric(f) ## wrong! and there is no warning...
as.numeric(as.character(f))



## Question: How can you recreate this plot but by having "control"
## being listed last instead of first?
exprmt <- factor(c("treat1", "treat2", "treat1", "treat3", "treat1", "control",
                   "control", "treat1", "treat2", "control", "treat3", "control"))
table(exprmt)
barplot(table(exprmt))




