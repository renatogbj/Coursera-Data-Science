# Coursera Data Science
Material and assignments from the Coursera Data Science specialization from Johns Hopkins University.

**Table of Contents**

- [The Data Scientist’s Toolbox](#)
- [R Programming](#)
	- [Programming Assignment 1](#)
		- [Introduction](#)
		- [Data](#)
		- [Part 1](#)
		- [Part 2](#)
		- [Part 3](#)
	- [Programming Assignment 2](#)
		- [Introduction](#)
		- [Caching the Inverse of a Matrix](#)
	- [Programming Assignment 3](#)
		- [Detailed Instructions](#)
		- [Data](#)
- [Getting and Cleaning Data](#)
	- [Programming Assignment 1](#)
		- [Human Activity Recognition Using Smartphones Tidy Data Set](#)
		- [Why the data is tidy?](#)
		- [The script](#)
- [Exploratory Data Analysis](#)
	- [Programming Assignment 1](#)
	- [Programming Assignment 2](#)

## The Data Scientist’s Toolbox

## R Programming

### Programming Assignment 1

#### Introduction

For this first programming assignment you will write three functions that are meant to interact with dataset that accompanies this assignment. The dataset is contained in a zip file specdata.zip that you can download from the Coursera web site.

#### Data

The zip file containing the data can be downloaded here:

> [data](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip)

The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". Each file contains three variables:

* Date: the date of the observation in YYYY-MM-DD format (year-month-day)
* sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
* nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

For this programming assignment you will need to unzip this file and create the directory 'specdata'. Once you have unzipped the zip file, do not make any modifications to the files in the 'specdata' directory. In each file you'll notice that there are many days where either sulfate or nitrate (or both) are missing (coded as NA). This is common with air pollution monitoring data in the United States.

#### Part 1

Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.

#### Part 2

Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases.

#### Part 3

Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0.

### Programming Assignment 2

#### Introduction

This second programming assignment will require you to write an R
function that is able to cache potentially time-consuming computations.
For example, taking the mean of a numeric vector is typically a fast
operation. However, for a very long vector, it may take too long to
compute the mean, especially if it has to be computed repeatedly (e.g.
in a loop). If the contents of a vector are not changing, it may make
sense to cache the value of the mean so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment you will take advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

#### Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

- `makeCacheMatrix`: This function creates a special "matrix" object that can cache its inverse.
- `cacheSolve`: This function computes the inverse of the special "matrix" returned by `makeCacheMatrix` above. If the inverse has already been calculated (and the matrix has not changed), then `cacheSolve` should retrieve the inverse from the cache.

### Programming Assignment 3

#### Detailed Instructions

Please download this document for detailed instructions about the assignment:

> [Instructions](https://d3c33hcgiwev3.cloudfront.net/_c79abb16c67d30f2dc8785e5abcf70d4_ProgAssignment3.pdf?Expires=1490313600&Signature=dXM7ZP6iwIo6Vgf0qOFbdvCwWe3Vi9ewlo1G2acbtfuOlgre8CmkLzxEfLYAZDDz3fJ9eYBT9LAeHDnFBzL8YVTJ-W8wbL2UOliMfLmf5zT~XC5fQ7y3HoW2--o9DMy0p0J9y4Yzd5bHM9BMQiFR8Sk6quzvek21G-Lc55Dwpf4_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)

#### Data

The zip file containing the data for this assignment can be downloaded here:

> [data](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip)

## Getting and Cleaning Data

### Programming Assignment 1

#### Human Activity Recognition Using Smartphones Tidy Data Set
Coursera Getting and Cleaning Data course peer-graded assignment with scripts and
descriptions for cleaning the data from the Human Activity Recognition Using Smartphones
Data Set

A full description of the original data set, as well as the data itself, is available at:

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### Why the data is tidy?

Based on Hadley Wickham’s paper, data **tidying** consists of "structuring datasets to
facilitate analysis". That has been done to this dataset, as can be noted in the last few
lines of the *run_analysis.R* script, asked in the part 5 of the assignment.

For this assignment there is two kinds of tidy data: the narrow data or the wide data. To
facilitate analysis the data was put in the narrow form, this way summarization can be
done with just a *group_by()* and *summarize()* function call from the **dplyr** package.

#### The script

The *run_analysis.R* script contains the code to perform the data tidying. I tried to
separate each step asked in the assignment, however some tasks might have been completed
in later steps.

Also, you might have to change your working directory in the line 6 of the script to the
directory containing the 'UCI HAR Dataset' folder with all the data files.

## Exploratory Data Analysis

### Programming Assignment 1

#### Introduction

This assignment uses data from
the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/), a popular repository for machine learning datasets. In particular, we will be using the "Individual household electric power consumption Data Set" which I have made available on the course web site:

* Dataset: [Electric power consumption](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) [20Mb]

* Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

#### Making Plots

Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system. For each plot you should:

* Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

* Name each of the plot files as `plot1.png`, `plot2.png`, etc.

* Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that constructs the corresponding plot, i.e. code in `plot1.R` constructs the `plot1.png` plot. Your code file **should include code for reading the data** so that the plot can be fully reproduced. You should also include the code that creates the PNG file.

### Programming Assignment 2
