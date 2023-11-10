
# GroupMeanSummarization

The goal of ‘R’ Package Group Mean Summarization is to provides a
**function to calculate the arithmetic mean**. Further, the user can
choose to group the data at any single or multiple levels to calculate
the mean over those groupings. Moreover, for convenience, the user can
select data grouping via column index(es) or column name(s).

## Installation

You can install the development version of Group Mean Summarization like
so:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2023/GroupMeanSummarization")
#> Skipping install of 'GroupMeanSummarization' from a github remote, the SHA1 (bff34890) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
suppressPackageStartupMessages(library(GroupMeanSummarization))
suppressPackageStartupMessages(library(tidyverse))

## Creating sample data
(sampleData <- data.frame(Name = c("Vir", "Shreya", "Kabir", "Vir", "Kabir"),
                 TransactionCity = c("Vancouver", "Vancouver", "California", "Seattle", "California"),
                 TransactionCost = c(100, 50, 80, 100, 40),
                 ItemsPurchased = c(4,1,4,6,2)
                 ))
#>     Name TransactionCity TransactionCost ItemsPurchased
#> 1    Vir       Vancouver             100              4
#> 2 Shreya       Vancouver              50              1
#> 3  Kabir      California              80              4
#> 4    Vir         Seattle             100              6
#> 5  Kabir      California              40              2

## Summary of arithmetic mean on sample data by person
Group_mean_summarization(sampleData, "Name")
#> # A tibble: 3 × 3
#>   Name   TransactionCost ItemsPurchased
#>   <chr>            <dbl>          <dbl>
#> 1 Kabir               60              3
#> 2 Shreya              50              1
#> 3 Vir                100              5

## Summary of arithmetic mean on sample data by city and person
Group_mean_summarization(sampleData, c(2,1))
#> # A tibble: 4 × 4
#> # Groups:   TransactionCity [3]
#>   TransactionCity Name   TransactionCost ItemsPurchased
#>   <chr>           <chr>            <dbl>          <dbl>
#> 1 California      Kabir               60              3
#> 2 Seattle         Vir                100              6
#> 3 Vancouver       Shreya              50              1
#> 4 Vancouver       Vir                100              4
```
