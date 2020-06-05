# Model-Level Inference {#modinf}




In this chapter, you will learn about statistical inference at the model-level for regression models. To do so, we will use the [keith-gpa.csv](https://raw.githubusercontent.com/zief0002/modeling/master/data/keith-gpa.csv) data to examine whether time spent on homework is related to GPA. The data contain three attributes collected from a random sample of $n=100$ 8th-grade students (see the [data codebook](http://zief0002.github.io/epsy-8251/codebooks/keith-gpa.html)). To begin, we will load several libraries and import the data into an object called `keith`. 


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


## Model-Level Inference

In the [previous chapter](#coefinf), we looked at how to carry out statistical tests of hypotheses and quantify uncertainty associated with the coefficients in the simple regression model. Sometimes you are interested in the model as a whole, rather than the individual parameters. For example, you may be interested in whether a set of predictors *together* explains variation in the outcome. Model-level information is displayed using the `glance()` output from the **broom** package. Below we fit a model by regressing GPA on time spent on homework, store those results in an object called `lm.1`, and then print the model-level output.


```r
# Fit regression model
lm.1 = lm(gpa ~ 1 + homework, data = keith)

# Model-level output
glance(lm.1)
```


```
# A tibble: 1 x 12
  r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
      <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
1     0.107        0.0981  7.24      11.8 0.000885     1  -339.  684.  691.
  deviance df.residual  nobs
     <dbl>       <int> <int>
1    5136.          98   100
```

The `r.squared` column indicates the proportion of variation in the outcome explained by differences in the predictor *in the sample*. Here, differences in time spent on homework explains 10.7\% of the variation in students' GPAs for the 100 students in the sample. The inferential question at the model-level is: *Does the model explain variation in the outcome, in the population?* This can formally be expressed in a statistical hypothesis as,

$$
H_0: \rho^2 = 0
$$

To test this, we need to be able to obtain the sampling distribution of $R^2$ to estimate the uncertainty in the sample estimate. The thought experiment for this goes something like this: Imagine you have a population that is infinitely large. The observations in this population have two attributes, call them $X$ and $Y$. There is NO relationship between these two attributes; $\rho^2 = 0$. Randomly sample $n$ observations from the population. Fit the regression and compute the $R^2$ value. Repeat the process an infinite number of times.


<div class="figure" style="text-align: center">
<img src="figs/notes-07-thought-experiment-r2.png" alt="Thought experiment for sampling samples of size n from the population to obtain the sampling distribution of R-squared." width="80%" />
<p class="caption">(\#fig:unnamed-chunk-5)Thought experiment for sampling samples of size n from the population to obtain the sampling distribution of R-squared.</p>
</div>

Below is a density plot of the sampling distribution for $R^2$ based on 1,000 random samples of size 32 drawn from a population where $\rho^2=0$. (Not an infinite number of draws, but large enough that we should have an idea of what the distribution might look like.) 

<div class="figure" style="text-align: center">
<img src="08-model-level-inference_files/figure-html/unnamed-chunk-6-1.png" alt="Sampling distribution based on 1000 simple random samples of size 32 drawn from a population where $\rho^2=0$." width="60%" />
<p class="caption">(\#fig:unnamed-chunk-6)Sampling distribution based on 1000 simple random samples of size 32 drawn from a population where $\rho^2=0$.</p>
</div>

Most of the $R^2$ values are near 0, although there is some variability that is due to sampling error. This sampling distribution is right-skewed. (WHY???) This means that we cannot use a $t$-distribution to model this distribution---remember the $t$-distribution is symmetric around zero. It turns out that this sampling distribution is better modeled using an $F$-distribution.

<br />


### The *F*-Distribution

In theoretical statistics the *F*-distribution is the ratio of two chi-squared statistics,

$$
F = \frac{\chi^2_1 / \mathit{df}_1}{\chi^2_2 / \mathit{df}_2}
$$

where $\mathit{df}_1$ and $\mathit{df}_2$ are the degrees of freedom associated with each of the chi-squared statistics, respectively. For our purposes, we don't need to pay much attention to this other than to the fact that an *F*-distribution is defined using TWO parameters: $\mathit{df}_1$ and $\mathit{df}_2$. Knowing these two values completely parameterize the *F*-distribution (they give the shape, expected value, and variation).

In regression analysis, the *F*-distribution associated with model-level inference is based on the following degrees of freedom:

$$
\begin{split}
\mathit{df}_1 &= p \\
\mathit{df}_2 &= \mathit{df}_{\mathrm{Total}}-p
\end{split}
$$

where *p* is the number of predictors used in the model and $\mathrm{Total}$ is the total degrees of freedom in the data used in the regression model ($\mathrm{Total}=n-1$). In our example, $\mathit{df}_1=1$ and $\mathit{df}_2=99-1=98$. Using these values, we have defined the $F(1,98)$-distribution.

The *F*-distribution is the sampling distribution of *F*-values (not $R^2$-values). But, it turns out that we can easily convert an $R^2$-value to an *F*-value using,

$$
F = \frac{R^2}{1 - R^2} \times \frac{\mathit{df}_2}{\mathit{df}_1}
$$

In our example,

$$
\begin{split}
F &= \frac{0.107}{1 - 0.107} \times \frac{98}{1} \\[1em]
&= 0.1198 \times 98 \\[1em]
&= 11.74
\end{split}
$$

Thus, our observed *F*-value is: $F(1,98)=11.74$. To evaluate this under the null hypothesis, we find the area under the $F(1,98)$ density curve that corresponds to *F*-values *at least as extreme* as our observed *F*-value of 11.74.

<div class="figure" style="text-align: center">
<img src="08-model-level-inference_files/figure-html/unnamed-chunk-7-1.png" alt="Plot of the probability curve for the F(1,98) distribution. The shaded area under the curve represents the *p*-value for a test evaluating whether the population rho-squared is zero using an observed *F*-value of 11.74." width="50%" />
<p class="caption">(\#fig:unnamed-chunk-7)Plot of the probability curve for the F(1,98) distribution. The shaded area under the curve represents the *p*-value for a test evaluating whether the population rho-squared is zero using an observed *F*-value of 11.74.</p>
</div>

This area (which is one-sided in the $F$-distribution) corresponds to the $p$-value. In our case this $p$-value is 0.000885. The probability of observing an $F$-value at least as extreme as we the one we observed ($F=11.74$) under the assumption that the null hypothesis is true is 0.000885. This suggests that the empirical data are inconsistent with the hypothesis that $\rho^2=0$, and it is unlikely that the model explains no variation in students' GPAs. 

<br />


### Using the *F*-distribution in Practice

In practice, all of this information is provided in the output of the `glance()` function.


```r
glance(lm.1)
```


```
# A tibble: 1 x 12
  r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
      <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
1     0.107        0.0981  7.24      11.8 0.000885     1  -339.  684.  691.
  deviance df.residual  nobs
     <dbl>       <int> <int>
1    5136.          98   100
```

The observed *F*-value is given in the `statistic` column and the associated degrees of freedom are provided in the `df` and `df.residual` columns. Lastly, the *p*-value is given in the `p.value` column. When we report results from an *F*-test, we need to report the values for both degrees of freedom, the *F*-value, and the *p*-value. 

> The model-level test suggested that the empirical data are not consistent with the null hypothesis that the model explains no variation in GPAs; $F(1,98)=11.8$, $p<0.001$.

<br />


### ANOVA Decomposition

We can also get the model-level inferential information from the `anova()` output. This gives us the ANOVA decomposition for the model.


```r
anova(lm.1)
```

```
Analysis of Variance Table

Response: gpa
          Df Sum Sq Mean Sq F value    Pr(>F)    
homework   1  616.5  616.54  11.763 0.0008854 ***
Residuals 98 5136.4   52.41                      
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Note that the two *df* values for the model-level *F*-statistic correspond to the *df* in each row of the ANOVA table. The first *df* (in this case, 1) is the model degrees-of-freedom, and the second *df* (in this case, 98) is the residual degrees-of-freedom. Note the *p*-value is the same as that from the `glance()` function.

This ANOVA decomposition also breaks out the sum of squared values into the variation explained by the model (616.5) and that which is unexplained by the model (residual variation; 5136.4). Summing these two values will give the total amount of variation which can be used to compute $R^2$; $R^2 = \mathrm{SS}_{\mathrm{Model}}/\mathrm{SS}_{\mathrm{Total}}$.

This decomposition also gives us another way to consider the *F*-statistic. Recall that the *F*-statistic had a direct relationship to $R^2$

$$
F = \frac{R^2}{1 - R^2} \times \frac{\mathit{df}_2}{\mathit{df}_1}
$$

<!-- Using algebra, we could also express this as a ratio of two fractions: -->

<!-- $$ -->
<!-- F = \frac{\frac{R^2}{\mathit{df}_1}}{\frac{1 - R^2}{\mathit{df}_2}} -->
<!-- $$ -->


Since $R^2 = \mathrm{SS}_{\mathrm{Model}}/\mathrm{SS}_{\mathrm{Total}}$ we can rewrite this as:

$$
F = \frac{\frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}}}}{1 - \frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}}}} \times \frac{\mathit{df}_2}{\mathit{df}_1}
$$

Using algebra,

$$
\begin{split}
F &= \frac{\frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}}}}{\frac{\mathrm{SS}_{\mathrm{Total}}}{\mathrm{SS}_{\mathrm{Total}}} - \frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}}}} \times \frac{\mathit{df}_2}{\mathit{df}_1} \\[2ex]
&= \frac{\frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}}}}{\frac{\mathrm{SS}_{\mathrm{Total}} - \mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}}}} \times \frac{\mathit{df}_2}{\mathit{df}_1} \\[2ex]
&= \frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Total}} - \mathrm{SS}_{\mathrm{Model}}} \times \frac{\mathit{df}_2}{\mathit{df}_1} \\[2ex]
&= \frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Error}}} \times \frac{\mathit{df}_2}{\mathit{df}_1} \\[2ex]
\end{split}
$$

This expression of the *F*-statistic helps us see that the *F*-statistic is proportional to the ratio of the explained and unexplained variation. So long as the degrees of freedom remain the same, if the model explains more variation, the numerator of the *F*-statistic gets larger and the denominator will be smaller. Thus, larger *F*-values are associated with more explained variation by the model. We could also have seen this in the earlier expression of the *F*-statistic using $R^2$.

<br />


### The *F*-Statistic as the Ratio of Two Variance Estimates

In statistical theory, a sum of squares divided by a degrees of freedom is referred to as a *mean squared* value---the *average* amount of variation per degree of freedom. Since $\mathit{df}_1$ is the model degrees of freedom and $\mathit{df}_2$ is the residual (or error) degrees of freedom we could also express the *F*-statistic as:


$$
\begin{split}
F &= \frac{\mathrm{SS}_{\mathrm{Model}}}{\mathrm{SS}_{\mathrm{Error}}} \times \frac{\mathit{df}_{\mathrm{Error}}}{\mathit{df}_{\mathrm{Model}}} \\[2ex]
&= \frac{\frac{\mathrm{SS}_{\mathrm{Model}}}{\mathit{df}_{\mathrm{Model}}}}{\frac{\mathrm{SS}_{\mathrm{Error}}}{\mathit{df}_{\mathrm{Error}}}} \\[2ex]
&= \frac{\mathrm{MS}_{\mathrm{Model}}}{\mathrm{MS}_{\mathrm{Error}}}
\end{split}
$$

Thus the *F*-value is the ratio of the average variation explained by the model and the average variation that remains unexplained. In our example

$$
\begin{split}
\mathrm{MS}_{\mathrm{Model}} &= \frac{616.5}{1} = 616.5 \\[2ex]
\mathrm{MS}_{\mathrm{Error}} &= \frac{5136.4}{98} = 52.41 \\
\end{split}
$$

These values are also printed in the `anova()` output.


```r
anova(lm.1)
```

```
Analysis of Variance Table

Response: gpa
          Df Sum Sq Mean Sq F value    Pr(>F)    
homework   1  616.5  616.54  11.763 0.0008854 ***
Residuals 98 5136.4   52.41                      
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

$$
F = \frac{616.5}{52.41} = 11.76
$$


The observed *F*-value of 11.76 indicates that the average explained variation is 11.76 times that of the average unexplained variation. There is an awful lot more explained variation than unexplained variation, on average. Another name for a mean squared value is a *variance estimate*. A variance estimate is literally the average amount of variation (in the squared metric) per degree of freedom. For example, go back to the introductory statistics formula for using sample data to estimate a variance:

$$
\hat\sigma^2_Y = \frac{\sum(Y_i - \bar{Y})^2}{n-1}
$$

This numerator is a sum of squares; namely the $\mathrm{SS}_{\mathrm{Total}}$. The denominator is the total degrees of freedom. We could have also referred to this as a mean square

$$
\begin{split}
\hat\sigma^2_Y &= \frac{\mathrm{SS}_{\mathrm{Total}}}{\mathit{df}_{\mathrm{Total}}} \\[2ex]
&= \mathrm{MS}_{\mathrm{Total}}
\end{split}
$$

Note that the $\mathrm{MS}_{\mathrm{Total}}$ is not printed in the `anova()` output. However, it can be computed from the values that are printed. The $\mathrm{SS}_{\mathrm{Total}}$ is just the sum of the printed sum of squares, and likewise the $$\mathit{df}_{\mathrm{Total}}$$ is the sum of the *df* values.

$$
\begin{split}
\mathrm{SS}_{\mathrm{Total}} &= 616.5 + 5136.4 = 5752.9 \\[2ex]
\mathit{df}_{\mathrm{Total}} &= 1 + 98 = 99
\end{split}
$$

Then the $\mathrm{MS}_{\mathrm{Total}}$ is the ratio of these values,

$$
\mathrm{MS}_{\mathrm{Total}} = \frac{5752.9}{99} = 58.11
$$

Since this is a estimate of the outcome variable's variance, we could also have computes the sample variance of the outcome variable, `gpa`, using the `var()` function.


```r
keith %>%
  summarize(V_gpa = var(gpa))
```

```
# A tibble: 1 x 1
  V_gpa
  <dbl>
1  58.1
```

The total mean square, or variance estimate, is also the mean square estimate of the residuals from the intercept-only model.


```r
# Fit intercept-only model
lm.0 = lm(gpa ~ 1, data = keith)

# ANOVA decomposition
anova(lm.0)
```

```
Analysis of Variance Table

Response: gpa
          Df Sum Sq Mean Sq F value Pr(>F)
Residuals 99 5752.9   58.11               
```

Remember the sum of squared residuals is $(Y_i - \hat{Y_i})^2$, but in the intercept-only model $\hat{Y_i}$ is the marginal mean, i.e., $\hat{Y_i} = \bar{Y}$. This is the numerator of the sample variance estimate and is why the mean square error from the intercept-only model and the sample variance for GPA are equivalent!

<br />


<!-- ### The F-Distribution is the Ratio of Two Chi-Squared Distributions -->

<!-- Because mean square values are variance estimates, the *F*-statistic can also be expressed as: -->

<!-- $$ -->
<!-- F = \frac{\hat\sigma^2_{\mathrm{Model}}}{\hat\sigma^2_{\mathrm{Error}}} -->
<!-- $$ -->

<!-- Stat theory tells us that the sampling distribution for a variance is $\chi^2$-distributed with a particular *df*. The model explained variance estimate ($\hat\sigma^2_{\mathrm{Model}}$) is $\chi^2$-distributed with *p* degrees of freedom (where *p* is the number of predictors in the model) and the unexplained variance estimate ($\hat\sigma^2_{\mathrm{Error}}$) is $\chi^2$-distributed with $\mathit{df}_{\mathrm{Total}} - p$ degrees of freedom. -->

<!-- <br /> -->


### Relationship Between Coefficient-Level and Model-Level Inference

Lastly, we point out that in simple regression models (models with only one predictor), the results of the model-level inference (i.e., the *p*-value) is exactly the same as that for the coefficient-level inference for the slope. 


```r
# Model-level inference
glance(lm.1)
```


```
# A tibble: 1 x 12
  r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
      <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
1     0.107        0.0981  7.24      11.8 0.000885     1  -339.  684.  691.
  deviance df.residual  nobs
     <dbl>       <int> <int>
1    5136.          98   100
```


```r
# Coefficient-level inference
tidy(lm.1)
```

```
# A tibble: 2 x 5
  term        estimate std.error statistic  p.value
  <chr>          <dbl>     <dbl>     <dbl>    <dbl>
1 (Intercept)    74.3      1.94      38.3  1.01e-60
2 homework        1.21     0.354      3.43 8.85e- 4
```


That is because the model is composed of a single predictor, so asking whether the model accounts for variation in GPA **is the same as** asking whether GPA is different, on average, for students who spend a one-hour difference in time on homework. *Once we have multiple predictors in the model, the model-level results and predictor-level results will not be the same.*

<br />


## Confidence Envelope for the Model

Re-consider our thought experiment. Again, imagine you have a population that is infinitely large. The observations in this population have two attributes, call them $X$ and $Y$. The relationship between these two attributes can be expressed via a regression equation as: $\hat{Y}=\beta_0 + \beta_1(X)$. Randomly sample $n$ observations from the population, and compute the fitted regression equation, this time plotting the line (rather than only paying attention to the numerical estimates of the slope or intercept). Continue sampling from this population, each time drawing the fitted regression equation.

<div class="figure" style="text-align: center">
<img src="figs/notes-07-thought-experiment-confidence-envelope.png" alt="Thought experiment for sampling samples of size *n* from the population to obtain the fitted regression line." width="80%" />
<p class="caption">(\#fig:unnamed-chunk-17)Thought experiment for sampling samples of size *n* from the population to obtain the fitted regression line.</p>
</div>

Now, imagine superimposing all of these lines on the same plot. 

<div class="figure" style="text-align: center">
<img src="figs/notes-07-superimposed-lines.png" alt="Plot showing the fitted regression lines for many, many random samples of size *n*." width="50%" />
<p class="caption">(\#fig:unnamed-chunk-18)Plot showing the fitted regression lines for many, many random samples of size *n*.</p>
</div>

Examining where the sampled lines fall gives a visual interpretation of the uncertainty in the model. This two-dimensional display of uncertainty is referred to as a *confidence envelope*. In practice we estimate the uncertainty from the sample data and plot it around the fitted line from the sample.

For simple regression models, we can plot this directly by including the the `geom_smooth()` layer in our plot. This adds a smoother to the plot. To add the fitted simple regression line, we use the argument `method="lm"`. This will add the fitted regression line and confidence envelope to the plot based on fitting a linear model to the variables included in the `x=` and `y=` arguments in the aesthetic mapping defined in `aes()`.^[The confidence envelope can be omitted by using the argument `se=FALSE`.] The color of the fitted line and of the confidence envelope can be set using `color=` and `fill=` respectively.


```r
# Create plot
ggplot(data = keith, aes(x = homework, y = gpa)) +
  geom_smooth(method = "lm", color = "#c62f4b", fill = "#696969") +
  xlab("Time spent on homework") +
  ylab("GPA (on a 100-pt. scale)") +
  theme_bw()
```

<div class="figure" style="text-align: center">
<img src="08-model-level-inference_files/figure-html/unnamed-chunk-19-1.png" alt="GPA plotted as a function of time spent on homework. The OLS regression line (raspberry) and confidence envelope (grey shaded area) are also displayed." width="50%" />
<p class="caption">(\#fig:unnamed-chunk-19)GPA plotted as a function of time spent on homework. The OLS regression line (raspberry) and confidence envelope (grey shaded area) are also displayed.</p>
</div>

Note that we want to indicate the confidence envelope or make reference to the uncertainty in the figure caption. We pointed out that the confidence envelope indicates uncertainty by displaying the sampling variation associated with the location of the fitted regression line. 

We can also use this plot to make inferences about the mean $Y$-value conditioned on $X$. For example, using the fitted regression equation, the model predicts that the mean GPA for students who spend 6 hours each week on homework is 81.6. Graphically this is the point on the fitted regression line associated with $X=6$. 

However, we also now understand that there is uncertainty associated with estimates obtained from sample data. How much uncertainty is there in that estimate of 81.6? We can use the bounds of the confidence envelope at $X=6$ to answer this question. The lower bound of the confidence envelope at $X=6$ is approximately 80 and the upper bound is approximately 83. This tells, based on the sample data, we think the mean GPA for students who spend 6 hours each week on homework is between 80 and 83. Graphically, we can see these values in the plot.

<div class="figure" style="text-align: center">
<img src="08-model-level-inference_files/figure-html/unnamed-chunk-20-1.png" alt="GPA plotted as a function of time spent on homework. The OLS regression line (raspberry) and confidence ebnvelope (grey shaded area) are also displayed. The fitted value at *X*=6 is displayed as a point and the uncertainty in the estimate is displayed as an error bar." width="50%" />
<p class="caption">(\#fig:unnamed-chunk-20)GPA plotted as a function of time spent on homework. The OLS regression line (raspberry) and confidence ebnvelope (grey shaded area) are also displayed. The fitted value at *X*=6 is displayed as a point and the uncertainty in the estimate is displayed as an error bar.</p>
</div>

This uncertainty estimate is technically a 95% confidence interval for the mean GPA for students who spend 6 hours each week on homework. As such, a more formal interpretation is:

> With 95% confidence, the mean GPA for students who spend 6 hours each week on homework is between 80 and 83.


Notice that there is more uncertainty for the mean GPA for some values of $X$ than for others. This is because of the amount of information at each $X$. We have more information in the data around the mean $X$-value and less information at extreme $X$-values. That implies that we have more certainty in the estimates we make for the mean GPA for students who spend around 5 hours of homework each week than we do in students who only spend 1 hour aweek or those who spend 11 hours a week on homework.



