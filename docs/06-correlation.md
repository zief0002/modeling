# Correlation and Standardized Regression {#cor}




In this chapter, you will learn about correlation and its role in regression. To do so, we will use the *keith-gpa.csv* data to examine whether time spent on homework is related to GPA. The data contain three attributes collected from a random sample of $n=100$ 8th-grade students (see the [data codebook](http://zief0002.github.io/epsy-8251/codebooks/keith-gpa.html)). To begin, we will load several libraries and import the data into an object called `keith`. 


```r
# Load libraries
library(corrr)
library(dplyr)
library(ggplot2)
library(readr)

# Read in data
keith = read_csv(file = "https://raw.githubusercontent.com/zief0002/epsy-8251/master/data/keith-gpa.csv")
head(keith)
```

```
# A tibble: 6 x 3
    gpa homework parent_ed
  <dbl>    <dbl>     <dbl>
1    78        2        13
2    79        6        14
3    79        1        13
4    89        5        13
5    82        3        16
6    77        4        13
```

<br />


## Data Exploration

We begin by looking at the marginal distributions of both time spent on homework and GPA. We will also examine summary statistics of these variables (output presented in table). Finally, we also examine a scatterplot of GPA versus time spent on homework.

<div class="figure" style="text-align: center">
<img src="06-correlation_files/figure-html/unnamed-chunk-3-1.png" alt="Density plots of the marginal distributions of GPA and time spent on homework. The scatterplot showing the relationship between GPA and time spent on homework is also shown." width="31%" /><img src="06-correlation_files/figure-html/unnamed-chunk-3-2.png" alt="Density plots of the marginal distributions of GPA and time spent on homework. The scatterplot showing the relationship between GPA and time spent on homework is also shown." width="31%" /><img src="06-correlation_files/figure-html/unnamed-chunk-3-3.png" alt="Density plots of the marginal distributions of GPA and time spent on homework. The scatterplot showing the relationship between GPA and time spent on homework is also shown." width="31%" />
<p class="caption">Density plots of the marginal distributions of GPA and time spent on homework. The scatterplot showing the relationship between GPA and time spent on homework is also shown.</p>
</div>


```r
# Summary statistics
keith %>%
  summarize(
    M_gpa  = mean(gpa),
    SD_gpa = sd(gpa),
    M_hw   = mean(homework),
    SD_hw  = sd(homework)
    )
```



<table style="width:40%; margin-left: auto; margin-right: auto;" class="table">
<caption>Summary measures for 8th-Grade students' GPA and time spent on homework</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Measure </th>
   <th style="text-align:center;text-align: center;"> M </th>
   <th style="text-align:center;text-align: center;"> SD </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> GPA </td>
   <td style="text-align:center;"> 80.47 </td>
   <td style="text-align:center;"> 7.62 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Time spent on homework </td>
   <td style="text-align:center;"> 5.09 </td>
   <td style="text-align:center;"> 2.06 </td>
  </tr>
</tbody>
</table>

We might describe the results of this analysis as follows:

> The marginal distributions of GPA and time spent on homework are both unimodal. The average amount of time these 8th-grade students spend on homework each week is 5.09 hours (*SD* = 2.06). These 8th-grade students have a mean GPA of 80.47 (*SD* = 7.62) on a 100-pt scale. There is a moderate, positive, linear relationship between time spent on homework and GPA for these students. This suggests that 8th-grade students who spend less time on homework tend to have lower GPAs, on average, than students who spend more time on homework.

<br />


## Correlation

To numerically summarize the *linear relationship* between variables, we typically compute correlation coefficients. The correlation coefficient is a quantification of the direction and strength of the relationship. (It is important to note that the correlation coefficient is only an appropriate summarization of the relationship if the functional form of the relationship is linear.) 

To compute the correlation coefficient, we use the `correlate()` function from the **corrr** package. We can use the dplyr-type syntax to select the variables we want correlations between, and then pipe that into the `correlate()` function. Typically the response (or outcome) variable is the first variable provided in the `select()` function, followed by the predictor.


```r
keith %>%
  select(gpa, homework) %>%
  correlate()
```

```
# A tibble: 2 x 3
  rowname     gpa homework
  <chr>     <dbl>    <dbl>
1 gpa      NA        0.327
2 homework  0.327   NA    
```

When reporting the correlation coefficient is is conventional to use a lower-case $r$ and report the value to two decimal places. Subscripts are also generally used to indicate the variables. For example,

$$
r_{\mathrm{GPA,~Homework}} = 0.33
$$

It is important to keep in mind this value is only useful as a measure of the strength of the relationship when the relationship between variables is linear. Here is an example where the correlation coefficient would be misleading about the strength of the relationship.

<div class="figure" style="text-align: center">
<img src="06-correlation_files/figure-html/unnamed-chunk-7-1.png" alt="Hours of daylight versus day of the year for $n=75$ days in Minneapolis." width="3in" />
<p class="caption">Hours of daylight versus day of the year for $n=75$ days in Minneapolis.</p>
</div>

Here there is a perfect relationship between day of the year and hours of daylight. If you fitted a nonlinear model here, your "line" would match the data exactly (no residual error!). But the correlation coefficient does not reflect that ($r=-0.34$).

:::note
You should always create a scatterplot to examine the relationship graphically before computing a correlation coefficient to numerically summarize it. 
:::


