/* data library for reading/writing data: ---------------------------------- */
%let in_path = ~/506Assignment4;
%let out_path = ~/506Assignment4; 
libname in_lib "&in_path."; 
libname out_lib "&out_path.";

/* Create a data set recs referring to existing file: ---------------------- */
data recs;
 set in_lib.recs2020_public_v5;
run;

/* view the contents of this file: ----------------------------------------- */
proc contents data = recs;
run;


/*(a)*/
/* calculate the frequency and percentage: --------------------------------- */
proc freq data = recs order = freq;
    tables state_name / nocum out = stateFreq;
    weight NWEIGHT;
run;

/* print the highest percentage of records: -------------------------------- */
proc print data=stateFreq(obs = 1);
run;

/* get the percentage of all records correspond to Michigan: --------------- */
data michigan;
    set stateFreq;
    if state_name = "Michigan" then output michigan;
run;

/* print the percentage of Michian: ---------------------------------------- */
proc print data = michigan;
run;


/*(b)*/
/* get those with strictly positive electricity cost: ---------------------- */
data positive_cost;
    set recs;
    if DOLLAREL > 0;
run;

/* plot a histogram of the electricity cost: ------------------------------- */
ods select Histogram;
proc univariate data = positive_cost noprint;
	var DOLLAREL;
    histogram DOLLAREL;
run;

	

/*(c)*/
/* get the log values of electricity cost: --------------------------------- */
data log_cost;
    set positive_cost;
    log_electric_cost = log(DOLLAREL);
run;

/* plot a histogram of the log of electricity cost: ------------------------ */
ods select Histogram;
proc univariate data = log_cost noprint;
	var log_electric_cost;
    histogram log_electric_cost;
run;


/*(d)*/
/* remove the missing data in garage column: ------------------------------- */
data positive_log_cost_garage;
    set log_cost;
    if PRKGPLC1 > -1;
run;

/* fit the regression model: ----------------------------------------------- */
proc reg data=positive_log_cost_garage;
    weight NWEIGHT;
    model log_electric_cost = TOTROOMS PRKGPLC1;
run;


/*(e)*/
/* get the predicted values: ------------------------------------------------ */
proc reg data=positive_log_cost_garage;
	weight NWEIGHT;
    model log_electric_cost = TOTROOMS PRKGPLC1;
    output out = pred_data predicted = pred_log_electric_cost;
run;

/* transform the predicted values back to the original scale: --------------- */
data pred_data;
    set pred_data;
    pred_electric_cost = exp(pred_log_electric_cost);
run;

/* print the scatterplot: --------------------------------------------------- */
proc sgplot data = pred_data;
    scatter x = pred_electric_cost y = DOLLAREL;
run;
ods html close;







