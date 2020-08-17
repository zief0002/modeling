# Understanding Statistical Control {#statcontrol}




Remember that in a [previous chapter](#coefinf) we had found that time spent on homework was positively related to student GPA. Because the data are observational (we did not assign students to different levels of time on homework), it is difficult to make a causal inference about this relationship; there may be an alternative explanation. One possible explanation is that parent level of education explains the positive relationship between time spent on homework and student GPA.

In this chapter, you will learn about how including multiple predictors into the regression model helps us evaluate these alternative explanations by providing a measure of *statistical control*. To do so, we will return to the [keith-gpa.csv](https://raw.githubusercontent.com/zief0002/modeling/master/data/keith-gpa.csv) data to examine whether time spent on homework is related to GPA (see the [data codebook](http://zief0002.github.io/epsy-8251/codebooks/keith-gpa.html)). However this time, we will control for parent education level. To begin, we will load several libraries and import the data into an object called `keith`.



```r
# Load libraries
library(broom)
library(corrr)
library(dplyr)
library(ggplot2)
library(readr)

# Read in data
keith = read_csv(file = "https://raw.githubusercontent.com/zief0002/modeling/master/data/keith-gpa.csv")
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


## Data Exploration of Parent Education Level

Figure 1 (syntax not shown) suggests that the distribution of parent education level is slightly right-skewed. The mean level of education is approximately 14 years (SD = 2 years). Parent-level of education is positively correlated with GPA and with time spent on homework. 

<img src="10-understanding-statistical-control_files/figure-html/unnamed-chunk-3-1.png" width="50%" style="display: block; margin: auto;" />

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-4)Correlations between three student attributes. Means (standard deviations) are displayed on the main diagonal.</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Attribute </th>
   <th style="text-align:center;text-align: center;"> 1 </th>
   <th style="text-align:center;text-align: center;"> 2 </th>
   <th style="text-align:center;text-align: center;"> 3 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1. GPA </td>
   <td style="text-align:center;"> 80.47 (7.62) </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;"> — </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2. Time spent on homework </td>
   <td style="text-align:center;"> .33 </td>
   <td style="text-align:center;"> 5.09 (2.06) </td>
   <td style="text-align:center;"> — </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3. Parent education level </td>
   <td style="text-align:center;"> .29 </td>
   <td style="text-align:center;"> .28 </td>
   <td style="text-align:center;"> 14.03 (1.93) </td>
  </tr>
</tbody>
</table>

Parent education level is moderately and positively correlated with student GPA (in the sample). Moreover, time spent on homework is also moderately and positively correlated with parent education level. This set of relationships is in line with our alternative explanation of the relationship between time spent on homework and students' GPAs. Namely that students who have parent with more education tend to spend more time on homework and thus have higher GPAs.

<br />


## Regression Analysis

Table 2 shows the results from fitting a series of models to examine the effect of time spent on homework on student GPA.


```r
# Simple regression model to examine effect of time spent on homework
lm.a = lm(gpa ~ 1 + homework, data = keith)
#glance(lm.a)
#tidy(lm.a)

# Control for parent education level
lm.b = lm(gpa ~ 1 + homework + parent_ed, data = keith)
#glance(lm.b)
#tidy(lm.b)
```





<table class="table" style="width:70%; margin-left: auto; margin-right: auto;">
<caption>Unstandardized coefficients (standard errors) for a taxonomy of OLS regression models fitted to explore the effect of time spent on homework on GPA. All models were fitted with *n*=100 observations.</caption>
<thead>
  <tr><th>Predictor</th><th>Model 1</th><th>Model 2</th></tr>
</thead>
<tbody>
<tr><td style="text-align:left">Time spent on homework</td><td style="text-align:center">2.65<br />(0.37)</td><td style="text-align:center">0.99<br />(0.36)</td></tr>
<tr><td style="text-align:left">Parent education level</td><td></td><td style="text-align:center">0.87<br />(0.38)</td></tr>
<tr><td style="text-align:left">Constant</td><td style="text-align:center">11.32<br />(6.12)</td><td style="text-align:center">63.2<br />(5.24)</td></tr>

<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">R<sup>2</sup></td><td style="text-align:center">0.107</td><td style="text-align:center">0.152</td></tr>
<tr><td style="text-align:left">RMSE</td><td style="text-align:center">7.24</td><td style="text-align:center">7.09</td></tr>
</tbody>
</table>

The results from Model 1 are consistent with time spent on homework having a positive association with GPA ($p<.001$). Each one hour difference in time spent on homework is associated with a 1.21-point difference in GPA, on average. This positive association is seen, even after controlling for parent education level (see Model 2; $p=.026$), although the effect is somewhat smaller, with each one hour difference in time spent on homework is associated with a 0.98-point difference in GPA, on average.

These results argue against the alternative explanation that it is really parent education level that is explaining both time spent on homework and students' GPAs. The results from the multiple regression model argue that after we account for the fact that parent education is related to both those variables, there is still a positive, albeit smaller, relationship between time spent on homework and students' GPAs. To understand why we can rule out this alternative explanation of the relationship, we need to understand the idea of statistical control.

<br />


## Understanding Statistical Control via Predicted Values

The fitted equation for Model 2 is,

$$
\hat{\mathrm{GPA}_i} = 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{Parent~Education}_i)
$$

Let's predict the average GPA for students who spend differing amounts of time on homework,

- Time spent on homework = 1 hour
- Time spent on homework = 2 hours
- Time spent on homework = 3 hours

Let's also assume that these student all have parent education level of 12 years.

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-7)Predicted average GPA for students who spend 1, 2, and 3 hours a week on homework with parent education level of 12 years.</caption>
 <thead>
  <tr>
   <th style="text-align:center;text-align: center;"> Homework </th>
   <th style="text-align:center;text-align: center;"> Parent Education </th>
   <th style="text-align:center;text-align: center;"> Model Predicted GPA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 63.22 + 0.99(1) + 0.87(12) = 74.65 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 63.22 + 0.99(2) + 0.87(12) = 75.64 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 63.22 + 0.99(3) + 0.87(12) = 76.63 </td>
  </tr>
</tbody>
</table>

In this example, the value of `parent_ed` is "constant" across the three types of students. Time spent on homework differs by one-hour between each subsequent type of student. The difference in model predicted average GPA between these students is 0.99. When we hold level of parent education constant, the predicted difference in average GPA between students who spend an additional hour on homework is 0.99.

What if we had chosen a parent education level of 13 years instead?

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-8)Predicted average GPA for students who spend 1, 2, and 3 hours a week on homework with parent education level of 13 years.</caption>
 <thead>
  <tr>
   <th style="text-align:center;text-align: center;"> Homework </th>
   <th style="text-align:center;text-align: center;"> Parent Education </th>
   <th style="text-align:center;text-align: center;"> Model Predicted GPA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 63.22 + 0.99(1) + 0.87(13) = 75.52 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 63.22 + 0.99(2) + 0.87(13) = 76.51 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 63.22 + 0.99(3) + 0.87(13) = 77.50 </td>
  </tr>
</tbody>
</table>

The model predicted average GPAS are higher for these students because they have a higher parent education level. But, again, when we hold parent education level constant, the predicted difference in average GPA between students who spend an additional hour on homework is 0.99. Moreover, this difference in average GPAs for any one hour difference in time spent on homework will be 0.99, regardless of the value we pick for parent level of education.

By fixing the value of parent level of education to a particular value (holding it constant) we can "fairly" compare the average predicted GPA for different values of time spent on homework. This allows us to evaluate the association between time spent on homework and GPA without worrying that the GPAs we are comparing have different values for parent level of education. By holding parent level of education constant, we remove it as a potential confounding explanation of the relationship between time spent on homework and students' GPAs.

<br />


## Understanding Statistical Control via the Fitted Model

Let us return to the fitted equation for Model 2,

$$
\hat{\mathrm{GPA}_i} = 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{Parent~Education}_i)
$$

But this time, instead of computing predicted values, let's focus on the fitted equation for students with a specified parent education level, say 12 years. We can substitute this value into the fitted equation and reduce the result.

$$
\begin{split}
\hat{\mathrm{GPA}_i} &= 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{12}) \\[2ex]
&= 63.22 + 0.99(\mathrm{Homework}_i) + 10.44 \\[2ex]
&= 73.66 + 0.99(\mathrm{Homework}_i) 
\end{split}
$$

By substituting in a constant value for parent education level, we can write the model so that GPA is a function of time spent on homework. Interpreting the coefficients,

- Students with a parent education level of 12 years and who spend 0 hours a week on homework are predicted to have a mean GPA of 73.66.
- For students with a parent education level of 12 years, each additional hour spent on homework is associated with a 0.99-pt difference in GPA, on average.

What about the students whose parent education level is 13? Substituting this value into the fitted equation and reducing the result, we get,

$$
\begin{split}
\hat{\mathrm{GPA}_i} &= 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{13}) \\[2ex]
&= 63.22 + 0.99(\mathrm{Homework}_i) + 11.31 \\[2ex]
&= 74.53 + 0.99(\mathrm{Homework}_i)
\end{split}
$$

Interpreting these coefficients,

- Students with a parent education level of 13 years and who spend 0 hours a week on homework are predicted to have a mean GPA of 74.53.
- For students with a parent education level of 13 years, each additional hour spent on homework is associated with a 0.99-pt difference in GPA, on average.

The key here is that the slope for these two sets of students is the same. The relationship between time spent on homework and GPA is exactly the same regardless of parent education level.

<br />


## Understanding Statistical Control via the Plot of the Fitted Model

To create a plot that helps us interpret the results of a multiple regression analysis, we pick fixed values for all but one of the predictors and substitute those into the fitted equation. We can then rewrite the equation and use `geom_abline()` to draw the fitted line. Below I illustrate this by choosing three fixed values for parent level of education (namely 8, 12, and 16) and rewriting the three equations.

**Parent education level = 8**

$$
\begin{split}
\hat{\mathrm{GPA}_i} &= 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{8}) \\[2ex]
&= 70.18 + 0.99(\mathrm{Homework}_i)
\end{split}
$$

**Parent education level = 12**

$$
\begin{split}
\hat{\mathrm{GPA}_i} &= 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{12}) \\[2ex]
&= 73.66 + 0.99(\mathrm{Homework}_i)
\end{split}
$$

**Parent education level = 16**

$$
\begin{split}
\hat{\mathrm{GPA}_i} &= 63.22 + 0.99(\mathrm{Homework}_i) + 0.87(\mathrm{16}) \\[2ex]
&= 77.14 + 0.99(\mathrm{Homework}_i)
\end{split}
$$

Now I will create a plot of the outcome versus the predictor we left as a variable in the three equations (time spent on homework) and use `geom_abline()` to include the line for each of the three rewritten equations. Note that since I have three different equations (one for each of the three parent education levels), I will need to include three layers of `geom_abline()` in the plot syntax.


```r
ggplot(data = keith, aes(x = homework, y = gpa)) +
  geom_point(alpha = 0) +
  theme_bw() +
  xlab("Time spent on homework") +
  ylab("Model predicted GPA") +
  geom_abline(intercept = 70.18, slope = 0.99, color = "#003f5c", linetype = "dotdash") +
  geom_abline(intercept = 73.66, slope = 0.99, color = "#f26419", linetype = "solid") +
  geom_abline(intercept = 77.14, slope = 0.99, color = "#b40f20", linetype = "dashed") 
```

<div class="figure" style="text-align: center">
<img src="10-understanding-statistical-control_files/figure-html/unnamed-chunk-9-1.png" alt="Model predicted GPA as a function of time spent on homework for students with a parent education level of 8 years (blue, dot-dashed line), 12 years (orange, solid line), and 16 years (red, dashed line)." width="60%" />
<p class="caption">(\#fig:unnamed-chunk-9)Model predicted GPA as a function of time spent on homework for students with a parent education level of 8 years (blue, dot-dashed line), 12 years (orange, solid line), and 16 years (red, dashed line).</p>
</div>

From the plot we can see the effect of time spent on homework in the slopes of the fitted lines. Regardless of the level of parent education (8, 12, or 16), the slope of the line is 0.99, which means the three lines are parallel. The intercepts of these three lines vary reflecting the different level of parent education. 

We can interpret the effect of parent level of education by fixing time spent on homework to a particular value on the same plot. For example, fixing time spent on homework to 6, we see that the average GPA varies for the three levels of parent education displayed in the plot.


```r
ggplot(data = keith, aes(x = homework, y = gpa)) +
  geom_point(alpha = 0) +
  theme_bw() +
  xlab("Time spent on homework") +
  ylab("Model predicted GPA") +
  geom_abline(intercept = 70.18, slope = 0.99, color = "#003f5c", linetype = "dotdash") +
  geom_abline(intercept = 73.66, slope = 0.99, color = "#f26419", linetype = "solid") +
  geom_abline(intercept = 77.14, slope = 0.99, color = "#b40f20", linetype = "dashed") +
  geom_point(x = 6, y = 76.11908, color = "#003f5c", size = 2) +
  geom_point(x = 6, y = 79.60157, color = "#f26419", size = 2) +
  geom_point(x = 6, y = 83.08407, color = "#b40f20", size = 2)
```

<div class="figure" style="text-align: center">
<img src="10-understanding-statistical-control_files/figure-html/unnamed-chunk-10-1.png" alt="Model predicted GPA as a function of time spent on homework for students with a parent education level of 8 years (blue, dot-dashed line), 12 years (orange, solid line), and 16 years (red, dashed line). The model predicted GPAs for students who spend six hours a week on homework are also displayed." width="60%" />
<p class="caption">(\#fig:unnamed-chunk-10)Model predicted GPA as a function of time spent on homework for students with a parent education level of 8 years (blue, dot-dashed line), 12 years (orange, solid line), and 16 years (red, dashed line). The model predicted GPAs for students who spend six hours a week on homework are also displayed.</p>
</div>

How much do the model predicted GPAs vary for these three parent education levels?

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-11)Predicted GPA for students who spend six hours a week on homework with 8, 12, and 16 years of parent education.</caption>
 <thead>
  <tr>
   <th style="text-align:center;text-align: center;"> Homework </th>
   <th style="text-align:center;text-align: center;"> Parent Education </th>
   <th style="text-align:center;text-align: center;"> Model Predicted GPA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 76.12 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 79.60 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 83.08 </td>
  </tr>
</tbody>
</table>

The difference between each of these subsequent model predicted GPA values is 3.48. This is constant because we chose parent education levels that differ by the same amount, in this case each value of parent education differs by four years.

<br />


### Effect of Parent Education Level

What if we would have chosen parent education levels that differed by one year rather than by four years? 

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-12)Predicted GPA for students who spend six hours a week on homework with with parent education of 8, 9, and 10 years</caption>
 <thead>
  <tr>
   <th style="text-align:center;text-align: center;"> Homework </th>
   <th style="text-align:center;text-align: center;"> Parent Education </th>
   <th style="text-align:center;text-align: center;"> Model Predicted GPA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 76.12 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 76.99 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 77.86 </td>
  </tr>
</tbody>
</table>

Now a one-year difference in parent education level is associated with a 0.87-point difference in predicted GPA, *holding time spent on homework constant*. We could also have calculated this directly from the earlier result. Since a four-year difference in parent education is associated with a 3.48-point difference in predicted GPA, a one-year difference in parent education is associated with a $3.48 / 4=0.87$-point difference in predicted GPA. This algebra works since the relationship is constant (i.e., linear).

<br />


## Triptych Plots: Displaying the Results from a Multiple Regression Model

Remember, to create a plot that helps us interpret the results of a multiple regression analysis, we pick fixed values for all but one of the predictors and substitute those into the fitted equation. We can then rewrite the equation and use `geom_abline()` to draw the fitted lines. We illustrated this earlier by choosing three fixed values for parent level of education (namely 8, 12, and 16) and rewriting the three equations:

$$
\begin{split}
\mathbf{Parent~Education=8:} \quad\hat{\mathrm{GPA}_i} &= 70.18 + 0.99(\mathrm{Homework}_i) \\[2ex]
\mathbf{Parent~Education=12:} \quad\hat{\mathrm{GPA}_i} &= 73.66 + 0.99(\mathrm{Homework}_i) \\[2ex]
\mathbf{Parent~Education=16:} \quad\hat{\mathrm{GPA}_i} &= 77.14 + 0.99(\mathrm{Homework}_i)
\end{split}
$$

The plot we created earlier put all three fitted lines on the same plot. An alternative plot is to show each line in a different plot, and to place this plots side-by-side in a "triptych". (I borrow this terminology from @McElreath:2016 who coined this in his *Statistical Rethinking* book.) To do this we save each plot into an object and then use functionality from the [patchwork package](https://patchwork.data-imaginist.com/) to put the plots side-by-side.


```r
# Load package
library(patchwork)

# Create plot 1
p1 = ggplot(data = keith, aes(x = homework, y = gpa)) +
      geom_point(alpha = 0) +
      geom_abline(intercept = 70.18, slope = 0.99) +
      theme_bw() +
      xlab("Time spent on homework") +
      ylab("Model predicted GPA") +
      ggtitle("Parent Education = 8 Years")

# Create plot 2
p2 = ggplot(data = keith, aes(x = homework, y = gpa)) +
      geom_point(alpha = 0) +
      geom_abline(intercept = 73.66, slope = 0.99) +
      theme_bw() +
      xlab("Time spent on homework") +
      ylab("Model predicted GPA") +
      ggtitle("Parent Education = 12 Years")

# Create plot 3
p3 = ggplot(data = keith, aes(x = homework, y = gpa)) +
      geom_point(alpha = 0) +
      geom_abline(intercept = 77.14, slope = 0.99) +
      theme_bw() +
      xlab("Time spent on homework") +
      ylab("Model predicted GPA") +
      ggtitle("Parent Education = 16 Years")

# Put plots side-by-side
p1 | p2 | p3
```

<div class="figure" style="text-align: center">
<img src="10-understanding-statistical-control_files/figure-html/unnamed-chunk-13-1.png" alt="Model predicted GPA as a function of time spent on homework for students with a parent education level of 8, 12, and 16 years." width="90%" />
<p class="caption">(\#fig:unnamed-chunk-13)Model predicted GPA as a function of time spent on homework for students with a parent education level of 8, 12, and 16 years.</p>
</div>

<br />


### Emphasis on the Effect of Parent Level of Education

With two (or more) effects in the model we have more than one potential way to display the fitted results. In general, we will display one predictor through the slope of the line plotted (same as we did with only one predictor), and EVERY OTHER predictor will be shown through one or more lines. In the previous plots, below, we have displayed the effect of time spent on homework (on the *x*-axis) through the slope of the lines, and the effect of parent level of education through the vertical distance between the three different lines.

In general, the partial effect seen via the slope of the line is more cognitively apparent than the vertical distance between different lines. Thus whichever effect you want to emphasize should be placed on the *x*-axis; or left as a variable when you algebraically simplify the fitted regression equation.

For example, what if we wanted to emphasize parent level of education? In that case, we would choose fixed values for time spent on homework, substitute these into the fitted equation, and simplify. Here we choose fixed values for time spent on homework of 2, 5, and 10 hours. Rewriting the three equations:

$$
\begin{split}
\mathbf{Homework=2:}  \quad\hat{\mathrm{GPA}_i} &= 65.18 + 0.87(\mathrm{Parent~Education}_i) \\[2ex]
\mathbf{Homework=5:} \quad\hat{\mathrm{GPA}_i} &= 68.14 + 0.87(\mathrm{Parent~Education}_i) \\[2ex]
\mathbf{Homework=10:} \quad\hat{\mathrm{GPA}_i} &= 73.08 + 0.87(\mathrm{Parent~Education}_i)
\end{split}
$$

Then we create the triptych plot showing the resulting equations:


```r
# Create plot 1
p4 = ggplot(data = keith, aes(x = parent_ed, y = gpa)) +
      geom_point(alpha = 0) +
      geom_abline(intercept = 65.18, slope = 0.87) +
      theme_bw() +
      xlab("Parent education (in years)") +
      ylab("Model predicted GPA") +
      ggtitle("Time Spent on Homework = 2 Hours")

# Create plot 2
p5 = ggplot(data = keith, aes(x = parent_ed, y = gpa)) +
      geom_point(alpha = 0) +
      geom_abline(intercept = 68.14, slope = 0.87) +
      theme_bw() +
      xlab("Parent education (in years)") +
      ylab("Model predicted GPA") +
      ggtitle("Time Spent on Homework = 5 Hours")

# Create plot 3
p6 = ggplot(data = keith, aes(x = parent_ed, y = gpa)) +
      geom_point(alpha = 0) +
      geom_abline(intercept = 73.08, slope = 0.87) +
      theme_bw() +
      xlab("Parent education (in years)") +
      ylab("Model predicted GPA") +
      ggtitle("Time Spent on Homework = 10 Hours")

# Put plots side-by-side
p4 | p5 |p6
```

<div class="figure" style="text-align: center">
<img src="10-understanding-statistical-control_files/figure-html/unnamed-chunk-14-1.png" alt="Model predicted GPA as a function of parent education level for students who spend 2 hours, 5 hours, and 10 hours a week on homework." width="90%" />
<p class="caption">(\#fig:unnamed-chunk-14)Model predicted GPA as a function of parent education level for students who spend 2 hours, 5 hours, and 10 hours a week on homework.</p>
</div>

<br />

## Only Displaying a Single Effect

Sometimes you only want to show the effect of a single predictor from the model. For example, in educational studies we often control for SES and mother's level of education when we fit the model, but we don't want to display those effects in our plot. There is no rule that just because you included an effect in the fitted model that you are obligated to display it. 

Any effect that you do not want to display graphically can be fixed to a single value, typically the mean value. Fixing the effect to a single value will produce only one line. For example, here we set the parent education value to the its mean value of 14.03 years. After substituting this value into the fitted equation, this results in,

$$
\hat{\mathrm{GPA}_i} = 75.43 + 0.99(\mathrm{Homework}_i)
$$

Plotting this we get a single line which displays the effect of time spent on homework on GPA. Even though the effect of parent education is not displayed, it is still included as the intercept value of the plotted line is based on fixing this effect to its mean. 


```r
ggplot(data = keith, aes(x = homework, y = gpa)) +
 geom_point(alpha = 0) +
 geom_abline(intercept = 75.43, slope = 0.99) +
 theme_bw() +
 xlab("Time spent on homework") +
 ylab("Model predicted GPA")
```

<div class="figure" style="text-align: center">
<img src="10-understanding-statistical-control_files/figure-html/unnamed-chunk-15-1.png" alt="Model predicted GPA as a function of time spent on homework for students with an average parent education level (14.03 years)." width="50%" />
<p class="caption">(\#fig:unnamed-chunk-15)Model predicted GPA as a function of time spent on homework for students with an average parent education level (14.03 years).</p>
</div>

