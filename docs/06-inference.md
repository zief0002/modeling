# Inference: Comparing Two Groups {#comparing-groups}

Adapted from @Zieffler:2011



<br /><br />

:::note
This chapter assumes a working knowledge of **dplyr** and **ggplot2** functionality to work with and plot data. 
:::

<br /><br />

In the [chapter on exploration](#exploration), differences between two groups were examined. Specifically, the question of whether there were differences in the annual household per capita expenditures between the rural and urban populations in Vietnam was addressed. In that chapter, exploratory methods, such as graphical and numerical summarizations, were used to quantify the differences in the two distributions of household per capita expenditures. Exploration is often only the starting point for examining research questions involving group differences. 

These methods, however, do not always provide a complete answer to the research question. For example, most educational and behavioral researchers also want to determine whether the differences that might have shown up in the exploration phase are "real," and to what population(s) the "real" effect can be attributed. A "real" effect is a sample effect that is caused by an actual difference in the population of interest. For example, suppose the mean per capita household expenditures for the entirety of Vietnam is actually less for rural regions. Then a sample result would be expected to reflect this, provided the sample was obtained in a particular way, namely, randomly (see below). In addition to evaluating whether effects are "real", it is important to estimate the size of the effect. Uncertainty is always involved in this endeavor, which relates to the *precision* of the estimate.

Questions of whether or not group differences are "real", estimates of the size of group differences, and the precision of these estimates are typically problems of *statistical inference*. In this chapter, we begin to present some useful methods to answer these types of inferential questions. To do so, we will examine a research question related to the efficacy of after-school programs. 

<br /><br />


## Research Question and Preparation

Demands for accountability and delinquency prevention in recent years have led to rising popularity of after-school programs in the United States. The intuitive appeal of these programs is based on the perception that adolescents left unsupervised will either  simply waste time or, worse, engage in delinquent and dangerous behaviors. To empirically study the effects of attending an after-school program, @gottfredson randomly assigned middle-school students to either a treatment group or control group. The treatment consisted of participation in an after-school program, whereas the control group engaged in their usual routine, but control students were invited to attend one after-school activity per month. In this chapter we will be addressing the following reseacrh question:

> Is there a difference in delinquent behaviors between students who participated in the after-school treatment program and students that did not?

To address these research questions, we will use the data in [after-school.csv](https://raw.githubusercontent.com/zief0002/musings/master/data/after-school.csv) to explore and compare the level of delinquency between the two groups. To begin, we will load two packages that we will use in this analysis.


```r
# Load libraries
library(e1071)
library(tidyverse)
```

The data contains outcome measures for 78 middle-school students that were randomly assigned to either a treatment group (i.e., invited to participate in an after school program) or control group ('treatment as usual' except that members of the control group were invited to attend one after-school activity per month). The outcome measures were T-scaled scores^[T-scaled measurements are scaled to have a mean of 50 and a standrd deviation of 10.] and included measures of the student's aggression, delinquent behavior, and level of victimization. For each measure, higher scal scores indicate higher levels of the outcome in question.

We will import this data using the `read_csv()` function from the **tidyverse** package. 


```r
# Import data
after_school = read_csv("https://raw.githubusercontent.com/zief0002/musings/master/data/after-school.csv")
head(after_school)
```

```
## # A tibble: 6 x 4
##   treatment aggress delinq victim
##   <chr>       <dbl>  <dbl>  <dbl>
## 1 Control      74.5   70.3   58.7
## 2 Control      40.5   44.5   53  
## 3 Control      63.2   57.4   47.3
## 4 Control      40.5   44.5   41.5
## 5 Control      54.1   57.4   47.3
## 6 Control      38.2   44.5   41.5
```


<br /><br />



## Graphically and Numerically Summarizing the Conditional Distributions

Any group comparion should begin with a graphical and numerical exploration of the sample data. Here we will plot the KDE for the distribution of delinquent behaviors for the control and treatment groups.


```r
# Create plot of KDE
ggplot(data = after_school, aes(x = delinq)) +
  geom_density(aes(fill = treatment), alpha = 0.6, bw = 3) +
  theme_bw() +
  xlab("T-scaled delinquency measure") +
  ylab("Probability density") +
  scale_fill_manual(
    name = "",
    values = c("#003366", "#ffcc00")
  )
```

<div class="figure" style="text-align: center">
<img src="06-inference_files/figure-html/fig-01-1.png" alt="Kernel density plots for the distribution of the T-scaled delinquency measure conditioned on treatment group." width="60%" />
<p class="caption">(\#fig:fig-01)Kernel density plots for the distribution of the T-scaled delinquency measure conditioned on treatment group.</p>
</div>

```r
# Compute summary measures
after_school %>%
  group_by(treatment) %>%
  summarize(
    M = mean(delinq),
    SD = sd(delinq),
    G1 = skewness(delinq, type = 2),
    G2 = kurtosis(delinq, type = 2)
  )
```

```
## # A tibble: 2 x 5
##   treatment     M    SD    G1      G2
##   <chr>     <dbl> <dbl> <dbl>   <dbl>
## 1 Control    54.9 13.7   1.08  0.0973
## 2 Treatment  48.0  8.29  3.89 18.2
```

Examination of Figure \@ref(fig:fig-01) reveals similarities in the shape of the distribution for the two groups---both are right skewed. The sample means suggest that the students in the control group had, on average, a level of delinquent behaviors that was 6.9 points higher than the students in the treatment group ($54.9 - 48.0 = 6.9$). The distribution of scores for students in the treatment group also had less variation, were more skewed, and more peaked (leptokurtic) than the distribution of scores in the control group.

<br /><br />


## Is there an Effect of Treatment?

Based on the sample data, it looks as though there may be an effect of treatment on delinquent behaviors. After all, the students in the treatment group have a lower mean level of delinquent behaviors than the students in the control group. However, this difference might be a function of the random assingment of the 78 students into the two different group. It is possible that there is *no effect of treatment* and just by chance students with lower levels of delinquent behaviors were assigned to the treatment group. These two competing hypotheses are foundational to comparing two groups via statistical inference.

- There is *no effect of treatment*; the difference in sample means is due to the random assignment.
- There is an *effect of treatment*; the difference in sample means is due to something more than just the random assignment.

There are several methods applied researchers use to evaluate these competing hypothesis using statistical inference. The most common method, introduced in this chapter, is to use a two-sample *t*-test. However, the exact same results can be obtained from carrying out an analysis of variance (ANOVA), or regression analysis. Some researcher would use a permutation or randomization test to analyze whether the sample differences were due to chance. 

<br /><br />

## The Two-Sample t-Test

The justification for the two-sample *t*-test lies in the assumption of a specific statistical model underlying the relationship between the observed scores and population parameters. This statistical model is,

$$
Y_{ij} = \mu + \alpha_j + \epsilon_{ij}
$$

In this model, 

- $Y_{ij}$ is the observed measurement or score for the $i$th individual in group (or treatment) $j$;
- $\mu$ is the marginal mean across all individuals and groups;
- $\alpha_j$ is the treatment effect for the group $j$ (defined as $\alpha_j = \mu_j − \mu$, where $\mu_j$ is the mean for group $j$); and 
- $\epsilon_{ij}$ is the amount of random error or vartiation for the $i$th individual in group $j$.

This model states that a person's measurement on the outcome is a function of the marginal mean, an effect of being in a particular group, and some amount of randomness. For example, if a student was in the treatment group, this model would state that the student's delinquency score is a function of the marginal mean delinquency level, an effect of being in the treatment group, and some amount of randomness. If, on the other hand, the student was in the control group, this model would state that the student's delinquency score is a function of the marginal mean delinquency level, an effect of being in the control group, and some amount of randomness.

In this model, parameters with a $j$-subscript vary across groups but not within groups. For example the group effect ($\alpha_j$) would be the same value for every member of the control group. Similarly this parameter would be the same value for every member of the treatment group. But, the parameter values for control and treatment groups could be different.

If the parameter has both an $i$- and a $j$-subscript, it means that the parameter value can vary for individual within the same group. For example students in the control group could have different outcome values and different random error values. Lastly, if the parameter has no subscripts ($\mu$), it means that the parameter value is the same for all individuals in all groups.



### Statistical Hypotheses and the Statistical Model

Recall the two competing hypotheses underlying the statistical inference:

- There is *no effect of treatment*; the difference in sample means is due to the random assignment.
- There is an *effect of treatment*; the difference in sample means is due to something more than just the random assignment.

The first hypothesis of no effect of treatment specifies that the $\alpha_j$ parameter in the statistical model is 0. If $\alpha_j=0$, then the model reduces to:

$$
\begin{split}
Y_{ij} &= \mu + 0 + \epsilon_{ij} \\
&= \mu + \epsilon_{ij}
\end{split}
$$

This model states that regardless of whether a student is in the control or the treatment group their delinquency score is a function of the marginal mean and random error. Since the only parameter that varies on the right-hand side of this equation is $\epsilon_{ij}$, this implies that the only reason there are differences in students' delinquency scores is because of random error.

In the other competing hypothesis, that there is an effect of treatment, $\alpha_j \neq 0$. That corresponds to the full statistical model presented earlier:

$$
Y_{ij} = \mu + \alpha_j + \epsilon_{ij}
$$

In this model there are two parameters that vary on the right-hand side of this equation, namely $\alpha_j$ and $\epsilon_{ij}$, this implies that the reason there are differences in students' delinquency scores is because of both a group effect and random error.

This is to say that we can evaluate the two competing hypotheses by focusing on the parameter $\alpha_j$. Mathematically we can express these hypotheses as:

$$
\begin{split}
H_0:&~ \alpha_j=0 \\
H_1:&~\alpha_j \neq 0
\end{split}
$$

The first mathematical hypothesis ($H_0$) is referred to as the *null hypothesis* and corresponds to the hypothesis that there is no effect of treatment. The second hypothesis ($H_1$) is referred to as the *alternative hypothesis* and corresponds to the hypothesis that there is an effect of treatment.

<br /><br />

### Another Expression of the Hypotheses

When we first looked at the statistical model, we defined $\alpha_j$ as the difference between the group mean and the marginal mean,

$$
\alpha_j = \mu_j − \mu
$$

where $\mu_j$ is the mean for group $j$ and $\mu$ is the marginal mean. If we substitute this into the statistical model we get,

$$
\begin{split}
Y_{ij} &= \mu + \alpha_j + \epsilon_{ij} \\
&= \mu + \mu_j − \mu + \epsilon_{ij} \\
&= \mu_j + \epsilon_{ij}
\end{split}
$$

This expression of the model states that students' delinquency scores are a function of their group mean and individual random error. 

Compare this model (which corresponds to the alternative hyptheis) with the reduced model (corresponding to the null hypothesis):

$$
\begin{split}
\mathbf{Null~Model:}&~~Y_{ij} = \mu + \epsilon_{ij} \\
\mathbf{Alternative~Model:}&~~Y_{ij} = \mu_j + \epsilon_{ij}
\end{split}
$$

These two models are quite similar in that both say students' delinquency scores arew a function of a mean and individual random error. The difference is whether the mean is the same for both groups ($\mu$ in the null model) or is allowed to vary by group ($\mu_j$ in the alternative model). Taking advantage of this equivalence (or non-equivalence) of group means we can mathematically express the null and alternative hypotheses using means as:

$$
\begin{split}
H_0:&~ \mu_{\mathrm{Treatment}} = \mu_{\mathrm{Control}}\\
H_1:&~ \mu_{\mathrm{Treatment}} \neq \mu_{\mathrm{Control}}
\end{split}
$$

We can also express these two competing hypotheses as the difference in means as:

$$
\begin{split}
H_0:&~ \mu_{\mathrm{Treatment}} - \mu_{\mathrm{Control}} = 0\\
H_1:&~ \mu_{\mathrm{Treatment}} - \mu_{\mathrm{Control}} \neq 0
\end{split}
$$

This last expression makes it clear why we looked at the sample difference in means as evidence of group differences. The differrence of 6.9 we observed in the sample data appears to support the alternative hypothesis (at least prior to formally testing it). Since all three forms of the mathematical hypotheses are equivalent, it doesn't matter which version we use in practice. 

<br /><br />


### Estimating Model Parameters

We can use the data to estimate the model parameters and error terms for each case in the data. We start by getting data-based estimate of the marginal mean.


```r
# Estimate marginal mean 
after_school %>%
  summarize(
    M = mean(delinq)
  )
```

```
## # A tibble: 1 x 1
##       M
##   <dbl>
## 1  51.6
```

The estimated value of the parameter $\mu$ from the model is 51.62. To indicate that it is an estimate, we adda "hat" to the parameter symbol:

$$
\hat\mu = 51.62
$$

Previously, we also computed the conditional means from the data. These are estimates of the $\mu_j$ values.

$$
\begin{split}
\hat\mu_{\mathrm{Control}} &= 54.89 \\
\hat\mu_{\mathrm{Treatment}} &= 47.98
\end{split}
$$

We can use the conditional mean estimates, along with the marginal mean estimate, to compute estimates of the group effects (the $\alpha_j$ estimates) using:

$$
\hat\alpha_j = \hat\mu_j − \hat\mu
$$


$$
\begin{split}
\hat\alpha_{\mathrm{Control}} &= 54.89 - 51.62 \\
&= 3.27 \\[1em]
\hat\alpha_{\mathrm{Treatment}} &= 47.98 - 51.62 \\
&= -3.64
\end{split}
$$

Now, we can use these estimates in the statistical model, along with the observed outcomes for each case to compute the estimates for the error terms. For example, consider the first case. This student has a delinquency score of 70.3 and was a member of the control group. 

$$
\begin{split}
Y_{ij} &= \hat\mu + \hat\alpha_{\mathrm{Control}} + \hat{\epsilon}_{ij} \\[1em]
70.3 &= 51.62 + 3.27 + \hat{\epsilon}_{ij} \\
70.3 &= 54.89 + \hat{\epsilon}_{ij} \\
15.41 &= \hat{\epsilon}_{ij} 
\end{split}
$$

The first case's error estimate is 15.41. Note that in the penultimate line of the computation we add together the marginal mean and the group effect ($\hat\mu + \hat\alpha_j$) to get the control group's conditional mean. We will use this idea directly to compute the error estimate for the second case.

$$
\begin{split}
Y_{ij} &= \hat\mu_j + \hat{\epsilon}_{ij} \\[1em]
40.5 &= 54.89 + \hat{\epsilon}_{ij} \\
-14.39 &= \hat{\epsilon}_{ij} 
\end{split}
$$

The second case's error estimate is $-14.39$. We would go on and compute the error estimates for each case in the sample.

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-4)Outcome values and Parameter Estimates for Eight Cases</caption>
 <thead>
  <tr>
   <th style="text-align:center;text-align: center;"> Group </th>
   <th style="text-align:center;text-align: center;"> $Y_{ij}$ </th>
   <th style="text-align:center;text-align: center;"> $\hat\mu$ </th>
   <th style="text-align:center;text-align: center;"> $\hat\mu_j$ </th>
   <th style="text-align:center;text-align: center;"> $\hat\epsilon_{ij}$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Control </td>
   <td style="text-align:center;"> 70.3 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> 3.27 </td>
   <td style="text-align:center;"> 15.41 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Control </td>
   <td style="text-align:center;"> 44.5 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> 3.27 </td>
   <td style="text-align:center;"> -10.39 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Control </td>
   <td style="text-align:center;"> 57.4 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> 3.27 </td>
   <td style="text-align:center;"> 2.51 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Control </td>
   <td style="text-align:center;"> 44.5 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> 3.27 </td>
   <td style="text-align:center;"> -10.39 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> ⋮ </td>
   <td style="text-align:center;"> ⋮ </td>
   <td style="text-align:center;"> ⋮ </td>
   <td style="text-align:center;"> ⋮ </td>
   <td style="text-align:center;"> ⋮ </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Treatment </td>
   <td style="text-align:center;"> 44.5 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> -3.64 </td>
   <td style="text-align:center;"> -3.48 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Treatment </td>
   <td style="text-align:center;"> 44.5 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> -3.64 </td>
   <td style="text-align:center;"> -3.48 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Treatment </td>
   <td style="text-align:center;"> 44.5 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> -3.64 </td>
   <td style="text-align:center;"> -3.48 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Treatment </td>
   <td style="text-align:center;"> 44.5 </td>
   <td style="text-align:center;"> 51.62 </td>
   <td style="text-align:center;"> -3.64 </td>
   <td style="text-align:center;"> -3.48 </td>
  </tr>
</tbody>
</table>

The values in this table help us further understand the subscipting in the statistical model. Recall that parameters with a $j$-subscript vary across groups but not within groups. You can see that the estimated group effect ($\hat\alpha_j$) is the same value for every member of the control group. Similarly the estimated parameter for every case in the treatment group is also the same.

The estimated terms with both an $i$- and a $j$-subscript ($\hat\epsilon_{ij}$ and $Y_{ij}$) have values that can vary for individuals within the same group. For example students in the control group have different outcome values and different random error values. Lastly, the estimated $\mu$ parameter has no subscripts, which implies that it has the same value for all cases, regardless of group.


<br /><br />

### The Test 

<!-- In contrast to the mode, the median and mean are always unique values. The median is the middle-most score in a distribution. The `median()` function is used to find the median of the distribution. The best known and most frequently used measure of central tendency is the mean, or the average. The `mean()` function is used to find the mean of a distribution.  -->



<!-- ```{r} -->
<!-- ## Marginal mean and median household per capita expenditure -->
<!-- vlss %>% -->
<!--   summarize( -->
<!--     M = mean(expend), -->
<!--     Med = median(expend) -->
<!--     ) -->
<!-- ``` -->

<!-- The median household per capita expenditure is $160, and the mean household per capita expenditure is $213. In symmetric distributions, the mean and median can be equal or nearly so. However, in asymmetric distributions, the two can differ, sometimes drastically. -->

<!-- <br /><br /> -->


<!-- ### Conditional Means and Medians -->

<!-- The mean and median computed in the previous section summarize the marginal distribution, as `area` is ignored. Though the marginal estimates are useful, the goal is to compute the conditional estimates of a typical household per capita expenditure for each area. To do this we add a `group_by()` layer into our piping syntax prior to computing the summary values. Consider the following syntax: -->

<!-- ```{r} -->
<!-- ## Condition mean and median household per capita expenditure -->
<!-- vlss %>% -->
<!--   group_by(area) %>% -->
<!--   summarize( -->
<!--     M = mean(expend), -->
<!--     Med = median(expend) -->
<!--     ) -->
<!-- ``` -->

<!-- The mean household per capita expenditure for the urban area is more than twice that for the rural area. This is consistent with Figure \@ref(fig:fig-02) that shows the urban distribution being right-shifted relative to the rural distribution. This suggests that the average household per capita expenditure differs for urban and rural areas in the sample. -->


<!-- <br /><br /> -->


<!-- ### Measuring Variation -->

<!-- When an analysis deals with at least two groups, as in the rural/urban comparisons, it is important to consider group differences in variability and well as location. Variability within the groups influences the evaluation of location differences. High within-group variability can be an overwhelming feature that can render location differences as irrelevant, or at least less relevant. On the other hand, low within-group variability can work to accentuate location differences.  -->

<!-- Consider the examples in Figure \@ref(fig:fig-04). In both panels the mean difference between the distributions is the same. However, the large within-group variation in the rural distribution in the left-panel makes the interpretation of group differences less clear for these data than for the data shown in the right-panel. In fact, it can be argued that the most important feature is the fact that the urban distribution is almost entirely contained within the rural distributions. This means, for example, that though the rural mean is lower than the urban mean, there are several rural households that are higher than the urban mean, and some that are higher than *any* urban households.  -->

<!-- In contrast, in the right-panel of Figure \@ref(fig:fig-04), there is essentially no overlap between the two distributions. This means that the mean difference also characterizes the difference between almost every pair of households from the two distributions. If we were to randomly select one rural and one urban household, the rural household would almost surely have a lower annual income. The same cannot be said of the overlapping distributions in the right-panel of Figure \@ref(fig:fig-04). -->

<!-- ```{r fig-04, echo=FALSE, fig.cap='Simulated density plots for the distribution of household per capita expenditures conditioned on area showing large within-group variation (LEFT PANEL) and small within-group variation (RIGHT PANEL).', fig.width=8, fig.height=3.5, out.width="90%"} -->
<!-- # Create data for plot 1 -->
<!-- x1 = seq(from = 60, to = 150, length = 10000) -->
<!-- x2 = seq(from = 90, to = 135, length = 10000) -->

<!-- y1 = 0.90 * dnorm(x1, mean = 106, sd = 12) -->
<!-- y2 = 0.35 * dnorm(x2, mean = 115, sd =  6) -->

<!-- # Create data for plot 2 -->
<!-- x3 = seq(from = 102, to = 110, length = 10000) -->
<!-- x4 = seq(from = 111, to = 119, length = 10000) -->

<!-- y3 = 0.15 * dnorm(x3, mean = 106, sd = 1) -->
<!-- y4 = 0.06 * dnorm(x4, mean = 115, sd = 1) -->

<!-- d = data.frame( -->
<!--   x = c(x1, x2, x3, x4),  -->
<!--   y = c(y1, y2, y3, y4),  -->
<!--   area = c(rep("Urban", 10000), rep("Rural", 10000), rep("Urban", 10000), rep("Rural", 10000)), -->
<!--   plot = c(rep("(1)", 20000), rep("(2)", 20000)) -->
<!--   ) -->

<!-- # Create plot -->
<!-- ggplot(data = d, aes(x = x, y = y, linetype = area, color = area)) + -->
<!--   geom_line() + -->
<!--   theme_bw() + -->
<!--   xlab("Household per capita expenditures (in U.S. dollars)") + -->
<!--   ylab("Probability density") + -->
<!--   scale_linetype(name = "") + -->
<!--   scale_color_manual( -->
<!--     name = "", -->
<!--     values = c("#003366", "#c73e1d") -->
<!--   ) + -->
<!--   facet_wrap(~plot, nrow = 1) -->
<!-- ``` -->

<!-- Two summary measures of variation---the standard deviation and variance---are based on the deviations of the data from the mean. The `sd()` and `var()` functions can be used to compute these quantities, respectively. The syntax below illustrates the use of the functions to find the standard deviation for both the marginal and conditional distributions of household per capita expenditures. -->

<!-- ```{r} -->
<!-- ## SD and variance of the marginal distribution of household per capita expenditure -->
<!-- vlss %>% -->
<!--   summarize( -->
<!--     SD = sd(expend), -->
<!--     Variance = var(expend) -->
<!--     ) -->


<!-- ## SD and variance of the conditional distributions of household per capita expenditure -->
<!-- vlss %>% -->
<!--   group_by(area) %>% -->
<!--   summarize( -->
<!--     SD = sd(expend), -->
<!--     Variance = var(expend) -->
<!--   ) -->
<!-- ``` -->

<!-- Based on these conditional summaries, the rural households show less variation than the urban households. This is consistent with Figure \@ref(fig:fig-02) that shows the urban distribution being wider relative to the rural distribution. The average household per capita expenditure is more homogeneous for rural than for urban households. There are some caveats regarding indexes of variation. Most notably, measures of variation are sensitive to asymmetry, and their values can be inflated by even a single extreme value. For this reason, the skewness of the distributions should be considered when comparing measures of variation computed on such distributions. -->

<!-- Another measure of variation that often gets reported in the educational and behavioral sciences, is the *standard error of the mean*. The idea underlying the standard error is that different samples drawn from the same population have different values of the sample mean. This is a consequence of random sampling and the fact that sample information is always incomplete relative to the population. The standard error of the mean is the standard deviation of all the possible sample means for  a given sample size. As such, this measure offers an indication of the precision of the sample mean, when it is used as an estimate of the population mean. The smaller the standard error the greater the precision. The standard error for the mean is computed as -->

<!-- $$ -->
<!-- \mathrm{SE}_{\bar{Y}}=\frac{\mathrm{SD}_Y}{\sqrt{n}}. -->
<!-- $$ -->

<!-- where $\mathrm{SD}_Y$ is the standard deviation of the observed measurements on some variable $Y$. The standard error of the mean is computed for both the urban and rural households in the syntax below. The standard error for the rural group is approximately four times smaller than that of the urban group ($\frac{6.01}{1.48} \approx 4$). This suggests that the sample mean for the rural households is a more precise estimate of the rural population mean than the sample urban mean is for the urban population. The use of the sample estimates and standard error for estimating population parameters is discussed further in Chapter 9. -->

<!-- ```{r} -->
<!-- vlss %>% -->
<!--   group_by(area) %>% -->
<!--   summarize( -->
<!--     SD = sd(expend), -->
<!--     N = n() -->
<!--     ) %>% -->
<!--   mutate( -->
<!--     SE = SD / sqrt(N) -->
<!--   ) -->
<!-- ``` -->

<!-- <br /><br /> -->


<!-- ### Measuring Skewness -->

<!-- Skewness is a numerical measure that helps summarize a distribution's departure from symmetry about its mean. A completely symmetric distribution has a skewness value of zero.^[Technically this is only true for an index of skewness that has been "corrected" or "standardized" so that the normal distribution has a skewness of zero. Skewness indices need not be zero for a normal distribution in general.] Positive values suggest a positively skewed (right-tailed) distribution with an asymmetric tail extending toward more positive values, whereas negative values suggest a negatively skewed (left-tailed) distribution with an asymmetric tail extending toward more negative values. -->

<!-- The **e1071** package^[An alternative package is **moments**.] provides a function called `skewness()`, which computes the skewness value for a sample distribution based on three common algorithms. This function is supplied with the argument `type=2` to compute *G1*, a slightly modified version of skewness that is a better population estimate [e.g., @joanes-gill]. The syntax below shows the use of `skewness()` to find the *G1* values for the conditional distributions. -->

<!-- ```{r} -->
<!-- ## Skewness (G1) of the conditional distributions of household per capita expenditure -->
<!-- vlss %>% -->
<!--   group_by(area) %>% -->
<!--   summarize( -->
<!--     G1 = skewness(expend, type = 2)  -->
<!--   ) -->
<!-- ``` -->

<!-- These values suggest that both the urban and rural distributions are positively skewed, but more so for the rural group. The following guidelines are offered as help in interpreting the skewness statistic. Like all guidelines these should be used with a healthy amount of skepticism. All statistics should be interpreted in terms of the types and purposes of the data analysis, as well as the substantive area of the research. -->

<!-- - If $G_1=0$, the distribution is symmetric. -->
<!-- - If $\left|G_1\right| < 1$, the skewness of the distribution is slight.^[$\left|G_1\right|$ indicates the absolute value of $G1$ (cut off the sign).] -->
<!-- - If $1 < \left|G_1\right| < 2$, the the skewness of the distribution is moderate. -->
<!-- - If $\left|G_1\right| >2$, the distribution is quite skewed. -->

<!-- The above guidelines indicate that both distributions in the example are severely positively skewed. Furthermore, the rural distribution is more asymmetric than the urban distribution. This is again consistent with Figure \@ref(fig:fig-02), which shows the rural distribution has a longer tail relative to its mean than the urban distribution. The distribution of rural households shows relatively less density for household per capita expenditures above the mean than below the mean. This asymmetry is even more evident for urban households. -->


<!-- <br /><br /> -->


<!-- ### Measuring Kurtosis -->

<!-- Kurtosis is often used as a numerical summarization of the "peakedness" of a distribution, referring to the relative concentration of scores in the center, tail, and shoulders. Normal distributions have a kurtosis value of zero and are called *mesokurtic*.^[Again, technically this is only true for indices of kurtosis that have been "corrected" so that a normal distribution has a kurtosis of zero.] Distributions that reflect a more peaked and heavy-tailed distribution than the normal distribution have positive kurtosis values, and are said to be *leptokurtic*. Distributions which are flatter and lighter-tailed than the normal distribution have negative kurtosis values and are said to be *platykurtic*. @dyson [p. 360] suggest an "amusing mnemonic"---which was attributed to Gossett [@student]---for the above terms: -->

<!-- <p class="actualquote"> -->
<!-- Platykurtic curves, like the platypus, are squat with short tails. Leptokurtic curves are high with long tails, like the kangaroo---noted for "lepping". -->
<!-- </p> -->

<!-- The left- and right-hand panels of Figure \@ref(fig:fig-05) depict distributions with different kurtosis values. The mesokurtic distribution is shown for a basis of comparison in both figures. The distributions in the left-hand panel show positive kurtosis, whereas the distributions in the right-hand panel show negative kurtosis. -->

<!-- ```{r fig-05, echo=FALSE, fig.cap='LEFT PANEL: Kernel density estimate for a mesokurtic distribution (dashed, orange line) and a leptokurtic distribution (solid, purple line). The leptokurtic distributions are skinnier and more peaked than the mesokurtic distribution. RIGHT PANEL: Kernel density estimate for a mesokurtic distribution (dashed, orange line) and a platykurtic distribution (solid, blue line). The platykurtic distribution is flatter than the mesokurtic distribution.', fig.width=8, fig.height=3.5, out.width="90%"} -->
<!-- # Create data for plot 1 -->
<!-- x1 = seq(from = -4, to = 4, length = 10000) -->

<!-- y1 = dnorm(x1, mean = 0, sd = 1) -->
<!-- y2 = VGAM::dlaplace(x1) -->
<!-- y3 = dunif(x1, min=-3.9, max=3.9) -->

<!-- d = data.frame( -->
<!--   x = c(x1, x1, x1, x1),  -->
<!--   y = c(y1, y2, y3, y1),  -->
<!--   type = c(rep("Mesokurtic (G2=0)", 10000), rep("Leptokurtic Distribution (G2=3)", 10000), rep("Platykurtic Distribution (G2=-1.2)", 10000), rep("Mesokurtic (G2=0)", 10000)), -->
<!--   plot = c(rep("(1)", 20000), rep("(2)", 20000)) -->
<!--   ) -->

<!-- # Create plot -->
<!-- ggplot(data = d, aes(x = x, y = y, linetype = type, color = type)) + -->
<!--   geom_line() + -->
<!--   theme_bw() + -->
<!--   xlab("Household per capita expenditures (in U.S. dollars)") + -->
<!--   ylab("Probability density") + -->
<!--   scale_linetype_manual( -->
<!--     name = "",  -->
<!--     values = c("solid", "dashed", "solid") -->
<!--     ) + -->
<!--   scale_color_manual( -->
<!--     name = "",  -->
<!--     values = c("#a23b72", "#f18f01", "#246082") -->
<!--     ) + -->
<!--   facet_wrap(~plot, nrow = 1) -->
<!-- ``` -->

<!-- The `kurtosis()` function provided in the **e1071** package can be used to compute the sample kurtosis value for a distribution based on three common algorithms. We use this function with the argument `type=2` to compute *G2*, a slightly modified version of the kurtosis statistic that is a better population estimate of kurtosis [e.g., @joanes-gill]. The syntax below shows the use of `kurtosis()` to find the *G2* values for the conditional distributions. -->

<!-- ```{r} -->
<!-- ## Kurtosis (G2) of the conditional distributions of household per capita expenditure -->
<!-- vlss %>% -->
<!--   group_by(area) %>% -->
<!--   summarize( -->
<!--     G2 = kurtosis(expend, type = 2)  -->
<!--   ) -->
<!-- ``` -->



<!-- The kurtosis statistics for the conditional distributions suggest that both distributions are severely leptokurtic indicating that these distributions are more peaked than a normal distribution. They also have more density in the tails of the distribution than we would expect to see in a normal distribution. One can see in Figure \@ref(fig:fig-02) that the rural distribution is even more peaked than the urban distribution. -->

<!-- While the kurtosis statistic is often examined and reported by educational and behavioral scientists who want to numerically describe their samples, it should be noted that "there seems to be no universal agreement about the meaning and interpretation of kurtosis" [@moors, p. 283]. Most textbooks in the social sciences describe kurtosis in terms of peakedness and tail weight. @balanda [p. 116] define kurtosis as "the location- and scale free movement of probability mass from the shoulders of a distribution into its center and tails &#8230; peakedness and tail weight are best viewed as components of kurtosis. Other statisticians have suggested that it is a measure of the bimodality present in a distribution [e.g., @darlington; @finucan]. Perhaps it is best defined by @mosteller, who suggest that like location, variation, and skewness, kurtosis should be viewed as a "vague concept" that can be formalized in a variety of ways. -->

<!-- <br /><br /> -->


<!-- ## Summarizing the Findings -->

<!-- The APA manual [@apa] provides suggestions for presenting descriptive statistics for groups of individuals. The information should be presented in the text when there are three or fewer groups and in a table when there are more than three groups. While this number is not set in stone, we want to present results in a manner that will facilitate understanding. Typically we report measures of location, variation, and sample size for each group, at the very least. We present the results of our data analysis below. -->

<!-- <blockquote> -->
<!-- Empirical evidence on the process of urbanization has shown increased economic segregation among urban and rural households, as well as increased spatial differentiation of land uses [e.g., @leaf]. The Socialist Republic of Vietnam, for the last decade, has experienced an industrialization characterized by economic growth and urbanization. -->

<!-- Statistical analysis shows that the typical household per capita expenditure is higher for urban households ($M=\$349$, $\mathrm{SE}=\$6$) than for rural households ($M=\$157$, $\mathrm{SE}=\$1$). The distribution for urban households ($\mathrm{SD}=\$250$) also shows more variation than the distribution for rural households ($\mathrm{SD}=\$97$) indicating that rural areas tend to be more homogeneous in their household per capita expenditures. This evidence is further strengthened by the difference in asymmetry and heavy-tailedness in the urban ($G1=2.73$, $G2=42.66$) and rural ($G1=4.28$, $G2=14.03$) distributions. -->

<!-- In contrast to their urban counterparts, the economic stimulation in rural areas of Vietnam seems not to have been as dynamic. The typical household for rural areas is only \$15 U.S. above the poverty line. Furthermore, except for a rather small number of wealthier rural households, the majority of rural households show little variation in their household per capita expenditures. This shared level of poverty could be due to the fact that a substantial share of the populace living in rural areas of Vietnam are now unemployed or underemployed. -->

<!-- It is worth noting, that the poverty line---established in 1998 by the General Statistical Office at \$119 U.S. [@gso]---is close to the mode of the rural expenditure per capita distribution, which could indicate that a small increase in household expenditure per capita is enough to shift many of the rural households to a position above the poverty line. This is one likely explanation for recent dramatic reductions in poverty rates in Vietnam. As the poverty line moves higher, further reductions in poverty rates are likely to be smaller in magnitude. -->

<!-- </blockquote> -->


<br /><br />



<!-- FIX MATH -->
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({ CommonHTML: { scale: 180 } });
</script>
