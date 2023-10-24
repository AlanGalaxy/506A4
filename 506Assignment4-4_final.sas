/* input and output paths: ------------------------------------------------- */
%let in_path = ~/506Assignment4/;
%let out_path = ~/506Assignment4/;
libname in_lib "&in_path.";
libname out_lib "&out_path.";
run;

/* Create a data set public referring to existing file: -------------------- */
data public;
  set in_lib.public2022;
run;

/* view the contents of this file: ----------------------------------------- */
proc contents data=public;
run;


/*(b)*/
/* use sql to create myTable, which contains useful columns: --------------- */
proc sql;
	create table work.myTable as
	select CaseID, weight_pop, B3, ND2, B7_a,GH1, ppeducat, race_5cat
	  from public;
quit;


/*(c)*/
/* save the dataset in outlib: ----------------------------------------- */
data out_lib.table;
    set work.myTable;
run;








