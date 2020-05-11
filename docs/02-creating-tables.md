# Creating Tables to Present Statistical Results



Below are some sample tables for presenting statistical information. Although some of them are conventional in the social sciences (e.g., the correlation tables), it is important to remember that these are only examples. You will encounter many variations of these tables as you read scientific work in your substantive area. There may be conventions that are adopted in some areas and not in others. Pay attention to how scholars in your discipline present tabular information. 

These examples were created using the [usnews.csv](https://raw.githubusercontent.com/zief0002/epsy-8252/master/data/usnews.csv) dataset (see the [data codebook](http://zief0002.github.io/epsy-8252/codebooks/usnews.html)) and the [riverview.csv](https://raw.githubusercontent.com/zief0002/epsy-8252/master/data/riverview.csv) dataset (see the [data codebook](http://zief0002.github.io/epsy-8252/codebooks/riverview.html)). 

<br /><br />

## Presenting Summary Statistics

Studies often present summary statistics such as the mean and standard deviation. If you only have one or two variables for which you are presenting summary statistics it is often better to present these in the prose of your manuscript. If you have several variables, the information is typically better conveyed in a table. Here is an example of a table presenting summary statistics for a sample of graduate schools of education.


<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-2)Means and Standard Deviations for Five Measures of Graduate Programs of Education</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Measure </th>
   <th style="text-align:center;text-align: center;"> *M* </th>
   <th style="text-align:center;text-align: center;"> *SD* </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Peer rating </td>
   <td style="text-align:center;"> 3.3 </td>
   <td style="text-align:center;"> 0.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Acceptance rate for Ph.D. students </td>
   <td style="text-align:center;"> 40.1 </td>
   <td style="text-align:center;"> 20.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Enrollment </td>
   <td style="text-align:center;"> 969.8 </td>
   <td style="text-align:center;"> 664.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (verbal) </td>
   <td style="text-align:center;"> 154.9 </td>
   <td style="text-align:center;"> 3.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (quantitative) </td>
   <td style="text-align:center;"> 151.0 </td>
   <td style="text-align:center;"> 4.4 </td>
  </tr>
</tbody>
</table>



Here are a few things to note about the table:

- It is numbered/named as "Table X". 
- It has a caption.
- The different variables being summarized are presented in the table rows. These are given names that readers can understand. (They are **not** the variable names used in the dataset which have shortened names like `doc_accept` and `peer`.)
- The different statistics being used to summarize the data are presented in the table columns. These are given abbreviated names as suggested in the *APA Publication Manual*. In general, statistics are italicized (this is also done in the text of your manuscript).
- There are no vertical borders in the table. There are horizontal borders above and below the header row, and at the bottom of the table. Other horizontal borders can be included to help readers if the table is particularly long.

<br /><br />

Here is another table presenting the means and standard deviations, but this time the statistical summaries are conditioned on sex.


<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-3)Means and Standard Deviations for Three Measures of Riverview Employees Conditioned on Sex</caption>
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="1"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; border-bottom: 1px solid black;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Females</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; border-bottom: 1px solid black;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Non-females</div></th>
</tr>
  <tr>
   <th style="text-align:left;text-align: center;"> Measure </th>
   <th style="text-align:center;text-align: center;"> *M* </th>
   <th style="text-align:center;text-align: center;"> *SD* </th>
   <th style="text-align:left;text-align: center;"> *M* </th>
   <th style="text-align:center;text-align: center;"> *SD* </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Education level (in years) </td>
   <td style="text-align:center;"> 16.0 </td>
   <td style="text-align:center;"> 4.0 </td>
   <td style="text-align:left;"> 16.0 </td>
   <td style="text-align:center;"> 5.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Seniority (in years) </td>
   <td style="text-align:center;"> 14.0 </td>
   <td style="text-align:center;"> 7.0 </td>
   <td style="text-align:left;"> 16.0 </td>
   <td style="text-align:center;"> 7.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Income (in thousand of U.S. dollars) </td>
   <td style="text-align:center;"> 48.9 </td>
   <td style="text-align:center;"> 13.3 </td>
   <td style="text-align:left;"> 59.9 </td>
   <td style="text-align:center;"> 14.2 </td>
  </tr>
</tbody>
</table>


<br /><br />

This table also presents the means and standard deviations conditioned on sex, but it also includes confidence intervals for the means. It also presents the conditioning in separate rows rather than separate columns.


<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-4)Means and Confidence Intervals (CI) for Three Measures of Riverview Employees Conditioned on Sex</caption>
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="3"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; border-bottom: 1px solid black;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">95% CI</div></th>
</tr>
  <tr>
   <th style="text-align:left;text-align: center;"> Measure </th>
   <th style="text-align:center;text-align: center;"> *M* </th>
   <th style="text-align:center;text-align: center;"> *SD* </th>
   <th style="text-align:center;text-align: center;"> *LL* </th>
   <th style="text-align:center;text-align: center;"> *UL* </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Education level (in years) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">      Female </td>
   <td style="text-align:center;"> 16.0 </td>
   <td style="text-align:center;"> 4.0 </td>
   <td style="text-align:center;"> 13.7 </td>
   <td style="text-align:center;"> 17.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;">      Non-female </td>
   <td style="text-align:center;"> 16.0 </td>
   <td style="text-align:center;"> 5.0 </td>
   <td style="text-align:center;"> 13.5 </td>
   <td style="text-align:center;"> 19.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Seniority (in years) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">      Female </td>
   <td style="text-align:center;"> 14.0 </td>
   <td style="text-align:center;"> 7.0 </td>
   <td style="text-align:center;"> 10.7 </td>
   <td style="text-align:center;"> 17.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;">      Non-female </td>
   <td style="text-align:center;"> 16.0 </td>
   <td style="text-align:center;"> 7.0 </td>
   <td style="text-align:center;"> 11.5 </td>
   <td style="text-align:center;"> 19.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Income (in thousand of U.S. dollars) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">      Female </td>
   <td style="text-align:center;"> 48.9 </td>
   <td style="text-align:center;"> 13.2 </td>
   <td style="text-align:center;"> 42.3 </td>
   <td style="text-align:center;"> 55.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;">      Non-female </td>
   <td style="text-align:center;"> 59.9 </td>
   <td style="text-align:center;"> 14.2 </td>
   <td style="text-align:center;"> 51.7 </td>
   <td style="text-align:center;"> 68.1 </td>
  </tr>
</tbody>
</table>

<br /><br />

## Presenting Correlation Coefficients

Similar to presenting summary statistics, if you only have one or two correlation coefficients to present, it is best to present these in the prose of your manuscript. If you have several correlations the information is typically better conveyed in a table. Here is an example of a table presenting correlation coefficients for our sample of graduate schools of education.


<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-5)Intercorrelations for Five Measures of Graduate Programs of Education</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Measure </th>
   <th style="text-align:center;text-align: center;"> 1 </th>
   <th style="text-align:center;text-align: center;"> 2 </th>
   <th style="text-align:center;text-align: center;"> 3 </th>
   <th style="text-align:center;text-align: center;"> 4 </th>
   <th style="text-align:center;text-align: center;"> 5 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1. Peer rating </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2. Acceptance rate for Ph.D. students </td>
   <td style="text-align:center;"> -.54 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3. Enrollment </td>
   <td style="text-align:center;"> .10 </td>
   <td style="text-align:center;"> -.03 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4. GRE score (verbal) </td>
   <td style="text-align:center;"> .43 </td>
   <td style="text-align:center;"> -.38 </td>
   <td style="text-align:center;"> .04 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5. GRE score (quantitative) </td>
   <td style="text-align:center;"> .49 </td>
   <td style="text-align:center;"> -.39 </td>
   <td style="text-align:center;"> .08 </td>
   <td style="text-align:center;"> .81 </td>
   <td style="text-align:center;"> — </td>
  </tr>
</tbody>
</table>


Here are a few things to note about the table:

- The correlation coefficients are generally rounded to two decimal places.
- In each column where numbers are presented, the decimal point should be vertically aligned.
- If the correlation table is to support a regression analysis, typically the outcome variable is the first variable presented in the table (in this case, peer rating). If there is a focal predictor (i.e., a predictor germane to your research question), this should be the second variable presented in the table, etc. Otherwise present the predictors alphabetically.
- Do not indicate "statistical significance" with stars as per the [recommendation of the American Statistical Association](https://amstat.tandfonline.com/doi/full/10.1080/00031305.2016.1154108#.XnF5l0N7lTY). Similarly, do not include *p*-values in a table of correlations. There are many issues related to statistical significance and *p*-values that arise in a table of correlations, not the least of which is that of multiple tests. It is better to save any presentation of *p*-values (if you really need to give them) for tables of the regression results.

<br /><br />

Here is an alternative table presenting both the summary statistics of each variable and the intercorrelations. Combining the information into a single table can be useful when trying to save space in a manuscript.



<table style="width:70%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-6)Descriptive Statistics and Correlations for Five Measures of Graduate Programs of Education</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Measure </th>
   <th style="text-align:center;text-align: center;"> *M* </th>
   <th style="text-align:center;text-align: center;"> *SD* </th>
   <th style="text-align:center;text-align: center;"> 1 </th>
   <th style="text-align:center;text-align: center;"> 2 </th>
   <th style="text-align:center;text-align: center;"> 3 </th>
   <th style="text-align:center;text-align: center;"> 4 </th>
   <th style="text-align:center;text-align: center;"> 5 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1. Peer rating </td>
   <td style="text-align:center;"> 3.3 </td>
   <td style="text-align:center;"> 0.5 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2. Acceptance rate for Ph.D. students </td>
   <td style="text-align:center;"> 40.1 </td>
   <td style="text-align:center;"> 20.2 </td>
   <td style="text-align:center;"> -.54 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3. Enrollment </td>
   <td style="text-align:center;"> 969.8 </td>
   <td style="text-align:center;"> 664.9 </td>
   <td style="text-align:center;"> .10 </td>
   <td style="text-align:center;"> -.03 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4. GRE score (verbal) </td>
   <td style="text-align:center;"> 154.9 </td>
   <td style="text-align:center;"> 3.7 </td>
   <td style="text-align:center;"> .43 </td>
   <td style="text-align:center;"> -.38 </td>
   <td style="text-align:center;"> .04 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5. GRE score (quantitative) </td>
   <td style="text-align:center;"> 151.0 </td>
   <td style="text-align:center;"> 4.4 </td>
   <td style="text-align:center;"> .49 </td>
   <td style="text-align:center;"> -.39 </td>
   <td style="text-align:center;"> .08 </td>
   <td style="text-align:center;"> .81 </td>
   <td style="text-align:center;"> — </td>
  </tr>
</tbody>
</table>

<br /><br />

## Presenting Results from a Fitted Regression Model

Typically the results of the "final" adopted model are presented in a table. However, if there are only one or two predictors in the model, it is best to present these in the prose of your manuscript rather than a table. If you have several predictors the information is often better conveyed in a table. Here is an example of a table presenting the results from a fitted regression model for our sample of graduate schools of education.


<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-7)Unstandardized Coefficients for an OLS Regression Model Fitted to Estimate Variation in Peer Ratings</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Predictor </th>
   <th style="text-align:center;text-align: center;"> *B* </th>
   <th style="text-align:center;text-align: center;"> *SE* </th>
   <th style="text-align:center;text-align: center;"> *t* </th>
   <th style="text-align:center;text-align: center;"> *p* </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Acceptance rate for Ph.D. students </td>
   <td style="text-align:center;"> -0.01 </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> -5.22 </td>
   <td style="text-align:center;"> &lt;0.001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (verbal) </td>
   <td style="text-align:center;"> 0.00 </td>
   <td style="text-align:center;"> 0.016 </td>
   <td style="text-align:center;"> 0.02 </td>
   <td style="text-align:center;"> 0.986 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (quantitative) </td>
   <td style="text-align:center;"> 0.04 </td>
   <td style="text-align:center;"> 0.014 </td>
   <td style="text-align:center;"> 2.67 </td>
   <td style="text-align:center;"> 0.009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant </td>
   <td style="text-align:center;"> -1.86 </td>
   <td style="text-align:center;"> 1.630 </td>
   <td style="text-align:center;"> -1.14 </td>
   <td style="text-align:center;"> 0.256 </td>
  </tr>
</tbody>
</table>




Here are a few things to note about the table:

- The intercept term of the model (Constant), is relegated to the bottom of the table as it is not typically substantively interesting.
- The different coefficients are presented in the table rows (when the table includes only one model). These are given names that readers can understand. (They are **not** the variable names used in the dataset which have shortened names like `doc_accept` and `peer`.)
- There are no stars indicating statistical significance as per the *American Statistical Association's* recommendation.
- The sample size ($N$) and variance accounted for ($R^2$) estimates could be added to a footnote or provided in prose.

<br /><br />

Alternatively, a regression table can include the confidence interval for each of the coefficients in addition to (or in place of!) the *p*-values. This addresses the uncertainty in the estimates.

<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-8)Unstandardized Coefficients and Confidence Intervals for an OLS Regression Model Fitted to Estimate Variation in Peer Ratings</caption>
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="3"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; border-bottom: 1px solid black;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">95% CI</div></th>
</tr>
  <tr>
   <th style="text-align:left;text-align: center;"> Predictor </th>
   <th style="text-align:center;text-align: center;"> *B* </th>
   <th style="text-align:center;text-align: center;"> *SE* </th>
   <th style="text-align:center;text-align: center;"> *LL* </th>
   <th style="text-align:center;text-align: center;"> *UL* </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Acceptance rate for Ph.D. students </td>
   <td style="text-align:center;"> -0.01 </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> -0.01 </td>
   <td style="text-align:center;"> -0.006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (verbal) </td>
   <td style="text-align:center;"> 0.00 </td>
   <td style="text-align:center;"> 0.016 </td>
   <td style="text-align:center;"> -0.03 </td>
   <td style="text-align:center;"> 0.033 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (quantitative) </td>
   <td style="text-align:center;"> 0.04 </td>
   <td style="text-align:center;"> 0.014 </td>
   <td style="text-align:center;"> 0.01 </td>
   <td style="text-align:center;"> 0.064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant </td>
   <td style="text-align:center;"> -1.86 </td>
   <td style="text-align:center;"> 1.630 </td>
   <td style="text-align:center;"> -5.09 </td>
   <td style="text-align:center;"> 1.368 </td>
  </tr>
</tbody>
</table>


<br /><br />

Another variation on this table includes the standardized regression coefficients.



<table style="width:60%; margin-left: auto; margin-right: auto;" class="table">
<caption>(\#tab:unnamed-chunk-9)Unstandardized and Standardized Coefficients for an OLS Regression Model Fitted to Estimate Variation in Peer Ratings</caption>
 <thead>
  <tr>
   <th style="text-align:left;text-align: center;"> Predictor </th>
   <th style="text-align:center;text-align: center;"> *B* </th>
   <th style="text-align:center;text-align: center;"> β </th>
   <th style="text-align:center;text-align: center;"> *t* </th>
   <th style="text-align:center;text-align: center;"> *p* </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Acceptance rate for Ph.D. students </td>
   <td style="text-align:center;"> -0.01 </td>
   <td style="text-align:center;"> -0.41 </td>
   <td style="text-align:center;"> -5.22 </td>
   <td style="text-align:center;"> &lt;0.001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (verbal) </td>
   <td style="text-align:center;"> 0.00 </td>
   <td style="text-align:center;"> 0.002 </td>
   <td style="text-align:center;"> 0.02 </td>
   <td style="text-align:center;"> 0.986 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GRE score (quantitative) </td>
   <td style="text-align:center;"> 0.04 </td>
   <td style="text-align:center;"> 0.33 </td>
   <td style="text-align:center;"> 2.67 </td>
   <td style="text-align:center;"> 0.009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Constant </td>
   <td style="text-align:center;"> -1.86 </td>
   <td style="text-align:center;"> — </td>
   <td style="text-align:center;"> -1.14 </td>
   <td style="text-align:center;"> 0.256 </td>
  </tr>
</tbody>
</table>

<br /><br />

## Presenting Results from Many Fitted Regression Models

In many analyses, you may need to present the results from a set of fitted models. Here is an example of a table presenting the results from a set of fitted regression models for our sample of graduate schools of education.





<table class="table" style="width: 70%; margin-left: auto; margin-right: auto;">
<caption>Unstandardized Coefficients and Confidence Intervals for a Series of OLS Regression Models Fitted to Estimate Variation in Peer Ratings</caption>
<thead>
<tr>
  <th></th>
  <th>Model A</th>
  <th>Model B</th>
  <th>Model C</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="text-align:left">GRE score (verbal)</td>
  <td style="text-align:center;">0.056</td>
  <td style="text-align:center;">0.011</td>
  <td style="text-align:center;">0.0003</td>
</tr>
<tr>
  <td style="text-align:left"></td>
  <td style="text-align:center;">(0.035, 0.078)</td>
  <td style="text-align:center;">(-0.024, 0.046)</td>
  <td style="text-align:center;">(-0.032, 0.032)</td>
</tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr>
  <td style="text-align:left">GRE score (quantitative)</td>
  <td></td>
  <td style="text-align:center;">0.047</td>
  <td style="text-align:center;">0.037</td>
</tr>
<tr>
  <td style="text-align:left"></td>
  <td></td>
  <td style="text-align:center;">(0.017, 0.076)</td>
  <td style="text-align:center;">(0.010, 0.063)</td>
</tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr>
  <td style="text-align:left">Acceptance rate for Ph.D. students</td>
  <td></td>
  <td></td>
  <td style="text-align:center;">-0.010</td>
</tr>
<tr>
  <td style="text-align:left"></td>
  <td></td>
  <td></td>
  <td style="text-align:center;">(-0.014, -0.006)</td>
</tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr>
  <td style="text-align:left">Constant</td>
  <td style="text-align:center;">-5.396</td>
  <td style="text-align:center;">-5.488</td>
  <td style="text-align:center;">-1.860</td>
</tr>
<tr>
  <td style="text-align:left"></td>
  <td style="text-align:center;">(-8.704, -2.089)</td>
  <td style="text-align:center;">(-8.683, -2.294)</td>
  <td style="text-align:center;">(-5.056, 1.335)</td>
</tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr>
<tr>
  <td style="text-align:left">R<sup>2</sup></td>
  <td style="text-align:center;">0.182</td>
  <td style="text-align:center;">0.243</td>
  <td style="text-align:center;">0.385</td>
</tr>
<tr>
  <td style="text-align:left">RMSE</td>
  <td style="text-align:center;">0.444</td>
  <td style="text-align:center;">0.429</td>
  <td style="text-align:center;">0.388</td>
</tr>
</tbody>
</table>



Here are a few things to note about the table:

- When presenting the results from multiple models, the goal is to often compare how coefficients differ from model-to-model. Because of this we typically present each model in a column and each coefficient in a row&emdash;this way you compare by reading horizontally.
- If a model does not include a particular coefficient, leave that cell blank.
- The intercept term of the model (Constant), is relegated to the bottom of the table as it is not typically substantively interesting.
- Use predictor names that readers can understand. (They are **not** the variable names used in the dataset which have shortened names like `doc_accept` and `peer`.)
- Model-level estimates are also included in the table, typically below the coefficient-level estimates. Sometimes a horizontal line is added to the table as a separator.

If you have many models to present, use a landscape orientation on your page.

<br /><br />

If you must present *p*-values, do not include stars indicating statistical significance (as per the [American Statistical Association's recommendation](https://amstat.tandfonline.com/doi/full/10.1080/00031305.2016.1154108#.XnF5l0N7lTY)). Include the *p*-value directly in the table.


<table class="table" style="width: 90%; margin-left: auto; margin-right: auto;">
<caption>Unstandardized Coefficients (Standard Errors) and p-Values for a Series of OLS Regression Models Fitted to Estimate Variation in Peer Ratings</caption>
<thead>
<tr>
  <th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center;"></th>
  <th colspan="3" style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center;"><div style="border-bottom: 1px solid black; padding-bottom: 5px;">Model A</div></th>
  <th colspan="3" style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center;"><div style="border-bottom: 1px solid black; padding-bottom: 5px;">Model B</div></th>
  <th colspan="3" style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center;"><div style="border-bottom: 1px solid black; padding-bottom: 5px;">Model C</div></th>
</tr>
<tr>
  <th></th>
  <th>*B*</th>
  <th>*SE*</th>
  <th>*p*</th>
  <th>*B*</th>
  <th>*SE*</th>
  <th>*p*</th>
  <th>*B*</th>
  <th>*SE*</th>
  <th>*p*</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="text-align:left">GRE score (verbal)</td>
  <td style="text-align:center;">0.056</td>
  <td style="text-align:center;">0.011</td>
  <td style="text-align:center;">&lt;0.001</td>
  <td style="text-align:center;">0.011</td>
  <td style="text-align:center;">0.018</td>
  <td style="text-align:center;">0.531</td>
  <td style="text-align:center;">0.0003</td>
  <td style="text-align:center;">0.016</td>
  <td style="text-align:center;">0.986</td>
</tr>
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr>
  <td style="text-align:left">GRE score (quantitative)</td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;">0.047</td>
  <td style="text-align:center;">0.015</td>
  <td style="text-align:center;">0.002</td>
  <td style="text-align:center;">0.037</td>
  <td style="text-align:center;">0.014</td>
  <td style="text-align:center;">0.009</td>
</tr>
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr>
  <td style="text-align:left">Acceptance rate for Ph.D. students</td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;"></td>
  <td style="text-align:center;">-0.010</td>
  <td style="text-align:center;">0.002</td>
  <td style="text-align:center;">&lt;0.001</td>
</tr>
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr>
  <td style="text-align:left">Constant</td>
  <td style="text-align:center;">-5.396</td>
  <td style="text-align:center;">0.056</td>
  <td style="text-align:center;">0.002</td>
  <td style="text-align:center;">-5.488</td>
  <td style="text-align:center;">1.630</td>
  <td style="text-align:center;">0.001</td>
  <td style="text-align:center;">-1.860</td>
  <td style="text-align:center;">1.630</td>
  <td style="text-align:center;">0.256</td>
</tr>
<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td colspan="10" style="border-bottom: 1px solid black"></td></tr>
<tr>
  <td style="text-align:left">R<sup>2</sup></td>
  <td style="text-align:center;" colspan="3">0.182</td>
  <td style="text-align:center;" colspan="3">0.243</td>
  <td style="text-align:center;" colspan="3">0.385</td>
</tr>
<tr>
  <td style="text-align:left">RMSE</td>
  <td style="text-align:center;" colspan="3">0.444</td>
  <td style="text-align:center;" colspan="3">0.429</td>
  <td style="text-align:center;" colspan="3">0.388</td>
</tr>
</tbody>
</table>


<br /><br />





