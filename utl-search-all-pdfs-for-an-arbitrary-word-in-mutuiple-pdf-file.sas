%let pgm=utl-search-all-pdfs-for-an-arbitrary-word-in-mutuiple-pdf-files;

Search all pdfs for an arbitrary word in mutuiple pdf files

github
http://tinyurl.com/yc6a66zw
https://github.com/rogerjdeangelis/utl-search-all-pdfs-for-an-arbitrary-word-in-mutuiple-pdf-file

related repos on end

see
https://goo.gl/8eFoWu
https://stackoverflow.com/questions/44370333/classifying-pdf-text-documents-based-on-the-presence-absence-of-specific-words-i

Davids profile
https://stackoverflow.com/users/3048453/david

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                       |                                                    |                           */
/*               INPUT                   |            PROCESS                                 |       OUTPUT              */
/*                                       |                                                    |                           */
/* d:/pdffnd/roger1.pdf                  |    Search all pdfs in a directory for 'alfred'     | file          relevance   */
/*                                       |    case insensitive                                |                           */
/*    NAME       SEX AGE  HEIGHTWEIGHT   |                                                    | roger1.pdf    Present     */
/*                                       | %let searchword = alfred;                          | roger2.pdf    Not Present */
/*    Alfred      M   14   69.0  112.5 * |                                                    | roger3.pdf    Not Present */
/*    Carol       F   14   62.8  102.5   |                                                    |                           */
/*    Jeffrey     M   13   62.5   84.0   | search_pdf <- function(pdf_files                   | Note relevance is a long  */
/*    John        M   12   59.0   99.5   |     ,search_term                                   | variable name in a V5     */
/*    Mary        F   15   66.5  112.0   |     ,n_words = 100) {                              | transport file            */
/*    Robert      M   12   64.8  128.0   |   res_list <- lapply(pdf_files, function(file) {   |                           */
/*    Ronald      M   15   67.0  133.0   |     content <- pdf_text(file);                     |                           */
/*                                       |     content2 <- tolower(content);                  |                           */
/* d:/pdffnd/roger2.pdf                  |     content2 <- gsub("\\n", "", content2);         |                           */
/*                                       |     content2 <- gsub("[[:punct:]]", "", content2); |                           */
/*    NAME       SEX AGE  HEIGHTWEIGHT   |     content_vec <- strsplit(content2, " ")[[1]];   |                           */
/*                                       |     found <- search_term %in% content_vec[1:n_words|;                          */
/*    Jane        F   12   59.8   84.5   |     res <- data_frame(file = file,                 |                           */
/*    Janet       F   15   62.5  112.5   |        relevance =                                 |                           */
/*    Jeffrey     M   13   62.5   84.0   |          ifelse(found, "Present", "Not Present")); |                           */
/*    John        M   12   59.0   99.5   |     return(res);                                   |                           */
/*    Judy        F   14   64.3   90.0   |   });                                              |                           */
/*    Mary        F   15   66.5  112.0   |   res_df <- bind_rows(res_list);                   |                           */
/*                                       |   return(res_df);                                  |                           */
/* d:/pdffnd/roger3.pdf                  | };                                                 |                           */
/*                                       | want<-as.data.frame(search_pdf(pdf_files           |                           */
/*   NAME       SEX AGE  HEIGHT EIGHT    | , search_term = "&searchword", n_words = 1000));   |                           */
/*                                       |                                                    |                           */
/*   Barbara     F   13   65.3   98.0    |                                                    |                           */
/*   Jeffrey     M   13   62.5   84.0    |                                                    |                           */
/*   John        M   12   59.0   99.5    |                                                    |                           */
/*   Mary        F   15   66.5  112.0    |                                                    |                           */
/*   Thomas      M   11   57.5   85.0    |                                                    |                           */
/*                                       |                                                    |                           */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/*----                                                                   ----*/
/*---- CREATE THREE PDFS                                                 ----*/
/*----                                                                   ----*/

data _null_;
  do fyl="d:/pdffnd/roger1.pdf","d:/pdffnd/roger2.pdf","d:/pdffnd/roger3.pdf";
     call symputx('fyl',fyl);
     cnt+1;
     call symputx('seed',put(cnt,2.));
     rc=dosubl('
        ods pdf file="&fyl";
          proc print data=sashelp.class(where=(uniform(&seed)<.3));
          run;quit;
        ods pdf close;
        run;quit;

     ');
  end;
stop;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*               INPUT                                                                                                    */
/*                                                                                                                        */
/* d:/pdffnd/roger1.pdf                                                                                                   */
/*                                                                                                                        */
/*    NAME       SEX AGE  HEIGHTWEIGHT                                                                                    */
/*                                                                                                                        */
/*    Alfred      M   14   69.0  112.5                                                                                    */
/*    Carol       F   14   62.8  102.5                                                                                    */
/*    Jeffrey     M   13   62.5   84.0                                                                                    */
/*    John        M   12   59.0   99.5                                                                                    */
/*    Mary        F   15   66.5  112.0                                                                                    */
/*    Robert      M   12   64.8  128.0                                                                                    */
/*    Ronald      M   15   67.0  133.0                                                                                    */
/*                                                                                                                        */
/* d:/pdffnd/roger2.pdf                                                                                                   */
/*                                                                                                                        */
/*    NAME       SEX AGE  HEIGHTWEIGHT                                                                                    */
/*                                                                                                                        */
/*    Jane        F   12   59.8   84.5                                                                                    */
/*    Janet       F   15   62.5  112.5                                                                                    */
/*    Jeffrey     M   13   62.5   84.0                                                                                    */
/*    John        M   12   59.0   99.5                                                                                    */
/*    Judy        F   14   64.3   90.0                                                                                    */
/*    Mary        F   15   66.5  112.0                                                                                    */
/*                                                                                                                        */
/* d:/pdffnd/roger3.pdf                                                                                                   */
/*                                                                                                                        */
/*   NAME       SEX AGE  HEIGHT EIGHT                                                                                     */
/*                                                                                                                        */
/*   Barbara     F   13   65.3   98.0                                                                                     */
/*   Jeffrey     M   13   62.5   84.0                                                                                     */
/*   John        M   12   59.0   99.5                                                                                     */
/*   Mary        F   15   66.5  112.0                                                                                     */
/*   Thomas      M   11   57.5   85.0                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/


%symdel word / nowarn;
%utlfkil(d:/xpt/want.xpt);

%let word=alfred;

%utl_submit_r64x(resolve('
library(pdftools);
library(dplyr);
library(Hmisc);
library(SASxport);

pdf_files <- list.files("d:/pdffnd/", full.names = T);
pdf_files;

search_pdf <- function(pdf_files
    ,search_term
    ,n_words = 100) {
  res_list <- lapply(pdf_files, function(file) {
    content <- pdf_text(file);
    content2 <- tolower(content);
    content2 <- gsub("\\n", "", content2);
    content2 <- gsub("[[:punct:]]", "", content2);
    content_vec <- strsplit(content2, " ")[[1]];
    found <- search_term %in% content_vec[1:n_words];
    res <- data_frame(file = file,
       relevance =
         ifelse(found, "Present", "Not Present"));
    return(res);
  });
  res_df <- bind_rows(res_list);
  return(res_df);
};
want<-as.data.frame(search_pdf(pdf_files
, search_term = "&word", n_words = 1000));
want;
for (i in 1:ncol(want)) {
      label(want[,i])<-colnames(want)[i];
      print(label(want[,i])); };
write.xport(want,file="d:/xpt/want.xpt");
'));

proc datasets lib=work nolist mt=data mt=view nodetails;delete want want_r_long_names; run;quit;

/*--- handles long variable names by using the label to rename the variables  ----*/

libname xpt xport "d:/xpt/want.xpt";
proc contents data=xpt._all_;
run;quit;

data want_r_long_names;
  %utl_rens(xpt.want) ;
  set want;
run;quit;
libname xpt clear;

proc print ;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*        OUTPUT                                                                                                          */
/*                                                                                                                        */
/*  file          relevance (long variable name)                                                                          */
/*                                                                                                                        */
/*  roger1.pdf    Present                                                                                                 */
/*  roger2.pdf    Not Present                                                                                             */
/*  roger3.pdf    Not Present                                                                                             */
/*                                                                                                                        */
/*  Note relevance is a long                                                                                              */
/*  variable name in a V5                                                                                                 */
/*  transport file                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/


REPO
----------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-convert-pdf-to-text-using-python-and-r
https://github.com/rogerjdeangelis/utl-create-a-simple-n-percent-clinical-table-in-r-sas-wps-python-output-pdf-rtf-xlsx-html-list
https://github.com/rogerjdeangelis/utl-creating-identical-pdf-and-powerpoint-slides
https://github.com/rogerjdeangelis/utl-identical-side-by-side-text-and-graphics-in-pdf-and-powerpoint
https://github.com/rogerjdeangelis/utl-overlaying-histograms-and-scatterplots-in-powerpoint-pdf-and-jpeg
https://github.com/rogerjdeangelis/utl-putting-a-frame-around-text-in-doc-rtf-and-pdf-ods-destinations-with-and-without-layout
https://github.com/rogerjdeangelis/utl-removing-unwanted-bookmarks-in-pdf-table-of-contents-toc
https://github.com/rogerjdeangelis/utl-scraping-pdf-output-for-pdf-tables-and-lists
https://github.com/rogerjdeangelis/utl-side-by-side-proc-report-output-in-pdf-html-and-excel
https://github.com/rogerjdeangelis/utl_combine_pdf_files_and_delete_pages_from_a_pdf_pyPDF_ghostscript
https://github.com/rogerjdeangelis/utl_combining_all_pdf_files_in_a_directory
https://github.com/rogerjdeangelis/utl_convert_pdf_tables_to_SAS_WPS_datasets
https://github.com/rogerjdeangelis/utl_convert_pdf_tables_to_sas_tables
https://github.com/rogerjdeangelis/utl_dropping-down-to-R-and-converting-pdfs-to-sas-tables-and-text
https://github.com/rogerjdeangelis/utl_dropping-down-to-powershell-and-converting-doc-and-rtf-files-to-pdfs
https://github.com/rogerjdeangelis/utl_ods_pdf_and_rtf_two_different_page_titles_on_the_same_page
https://github.com/rogerjdeangelis/utl_pdf_graphics_top_40_a_sas_ods_graphics_look_at_chicago_public_schools_salaries_by_job

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/



















































d:/pdffnd/roger1.pdf                                search all pdfs in a directory for 'alfred'                     file            relevance
                                                    case insensitive
   NAME       SEX    AGE    HEIGHT    WEIGHT                                                                d:/pdffnd/roger1.pdf    Present
                                                    %let searchword = alfred;                               d:/pdffnd/roger2.pdf    Not Present
   Alfred      M      14     69.0      112.5 *                                                              d:/pdffnd/roger3.pdf    Not Present
   Carol       F      14     62.8      102.5
   Jeffrey     M      13     62.5       84.0        search_pdf <- function(pdf_files
   John        M      12     59.0       99.5            ,search_term
   Mary        F      15     66.5      112.0            ,n_words = 100) {
   Robert      M      12     64.8      128.0          res_list <- lapply(pdf_files, function(file) {
   Ronald      M      15     67.0      133.0            content <- pdf_text(file);
                                                        content2 <- tolower(content);
d:/pdffnd/roger2.pdf                                    content2 <- gsub("\\n", "", content2);
                                                        content2 <- gsub("[[:punct:]]", "", content2);
   NAME       SEX    AGE    HEIGHT    WEIGHT            content_vec <- strsplit(content2, " ")[[1]];
                                                        found <- search_term %in% content_vec[1:n_words];
   Jane        F      12     59.8       84.5            res <- data_frame(file = file,
   Janet       F      15     62.5      112.5               relevance =
   Jeffrey     M      13     62.5       84.0                 ifelse(found, "Present", "Not Present"));
   John        M      12     59.0       99.5            return(res);
   Judy        F      14     64.3       90.0          });
   Mary        F      15     66.5      112.0          res_df <- bind_rows(res_list);
                                                      return(res_df);
d:/pdffnd/roger3.pdf                                };
                                                    want<-as.data.frame(search_pdf(pdf_files
  NAME       SEX    AGE    HEIGHT    WEIGHT         , search_term = "&searchword", n_words = 1000));

  Barbara     F      13     65.3       98.0
  Jeffrey     M      13     62.5       84.0
  John        M      12     59.0       99.5
  Mary        F      15     66.5      112.0
  Thomas      M      11     57.5       85.0


         file            relevance

 d:/pdffnd/roger1.pdf    Present
 d:/pdffnd/roger2.pdf    Not Present
 d:/pdffnd/roger3.pdf    Not Present

















 The WPS System

 Up to 40 obs from wantwps total obs=3

 Obs            FILE            RELEVANCE

  1     d:/pdffnd/roger1.pdf    Relevant     (Alfred is only in this pdf)
  2     d:/pdffnd/roger2.pdf    Irrelevant
  3     d:/pdffnd/roger3.pdf    Irrelevant


* create 3 pdfs;
data _null_;
  do fyl="d:/pdffnd/roger1.pdf","d:/pdffnd/roger2.pdf","d:/pdffnd/roger3.pdf";
     call symputx('fyl',fyl);
     cnt+1;
     call symputx('seed',put(cnt,2.));
     rc=dosubl('
        ods pdf file="&fyl";
          proc print data=sashelp.class(where=(uniform(&seed)<.3));
          run;quit;
        ods pdf close;
        run;quit;

     ');
  end;
stop;
run;quit;


*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

see link for commented code

%utl_submit_wps64('
libname wrk "%sysfunc(pathname(work))";
proc r;
submit;
library(pdftools);
library(dplyr);

pdf_files <- list.files("d:/pdffnd/", full.names = T);
pdf_files;

search_pdf <- function(pdf_files, search_term, n_words = 100) {
  res_list <- lapply(pdf_files, function(file) {
    content <- pdf_text(file);
    content2 <- tolower(content);
    content2 <- gsub("\\n", "", content2);
    content2 <- gsub("[[:punct:]]", "", content2);
    content_vec <- strsplit(content2, " ")[[1]];
    found <- search_term %in% content_vec[1:n_words];
    res <- data_frame(file = file,
       relevance = ifelse(found, "Present", "Not Present"));
    return(res);
  });
  res_df <- bind_rows(res_list);
  return(res_df);
};
want<-as.data.frame(search_pdf(pdf_files, search_term = "alfred", n_words = 1000));
want;
endsubmit;
import r=want data=wrk.wantwps;
run;quit;
proc print data=wrk.wantwps;
run;quit;
');


%symdel word / nowarn;
%utlfkil(d:/xpt/want.xpt);

%let word=alfred;

%utl_submit_r64x(resolve('
library(pdftools);
library(dplyr);
library(Hmisc);
library(SASxport);

pdf_files <- list.files("d:/pdffnd/", full.names = T);
pdf_files;

search_pdf <- function(pdf_files
    ,search_term
    ,n_words = 100) {
  res_list <- lapply(pdf_files, function(file) {
    content <- pdf_text(file);
    content2 <- tolower(content);
    content2 <- gsub("\\n", "", content2);
    content2 <- gsub("[[:punct:]]", "", content2);
    content_vec <- strsplit(content2, " ")[[1]];
    found <- search_term %in% content_vec[1:n_words];
    res <- data_frame(file = file,
       relevance =
         ifelse(found, "Present", "Not Present"));
    return(res);
  });
  res_df <- bind_rows(res_list);
  return(res_df);
};
want<-as.data.frame(search_pdf(pdf_files
, search_term = "&word", n_words = 1000));
want;
for (i in 1:ncol(want)) {
      label(want[,i])<-colnames(want)[i];
      print(label(want[,i])); };
write.xport(want,file="d:/xpt/want.xpt");
'));

proc datasets lib=work nolist mt=data mt=view nodetails;delete want want_r_long_names; run;quit;

/*--- handles long variable names by using the label to rename the variables  ----*/

libname xpt xport "d:/xpt/want.xpt";
proc contents data=xpt._all_;
run;quit;

data want_r_long_names;
  %utl_rens(xpt.want) ;
  set want;
run;quit;
libname xpt clear;































         ;;;;%end;%mend;/*'*/ *);*};*];*/;/*"*/;run;quit;%end;end;run;endcomp;%utlfix;






















* T1005340 StackOverflow R: Classifying PDF Text Documents based on the presence/absence of specific words in R

Is Alfred is in any of the three pdfs? Case insensitive.

Fancy word is Text Mining. I prefer 'Find Alfred'.

WORKING CODE WPS/R  (stops after 1000 words)

     search_pdf(pdf_files, search_term = "alfred", n_words = 1000))

see
https://goo.gl/8eFoWu
https://stackoverflow.com/questions/44370333/classifying-pdf-text-documents-based-on-the-presence-absence-of-specific-words-i

Davids profile
https://stackoverflow.com/users/3048453/david


HAVE ( three PDF files )
========================

d:/pdffnd/roger1.pdf

   NAME       SEX    AGE    HEIGHT    WEIGHT

   Alfred      M      14     69.0      112.5   * only in roger1.pdf
   Carol       F      14     62.8      102.5
   Jeffrey     M      13     62.5       84.0
   John        M      12     59.0       99.5
   Mary        F      15     66.5      112.0
   Robert      M      12     64.8      128.0
   Ronald      M      15     67.0      133.0

d:/pdffnd/roger2.pdf

   NAME       SEX    AGE    HEIGHT    WEIGHT

   Jane        F      12     59.8       84.5
   Janet       F      15     62.5      112.5
   Jeffrey     M      13     62.5       84.0
   John        M      12     59.0       99.5
   Judy        F      14     64.3       90.0
   Mary        F      15     66.5      112.0

d:/pdffnd/roger3.pdf

  NAME       SEX    AGE    HEIGHT    WEIGHT

  Barbara     F      13     65.3       98.0
  Jeffrey     M      13     62.5       84.0
  John        M      12     59.0       99.5
  Mary        F      15     66.5      112.0
  Thomas      M      11     57.5       85.0


WANT
====

The WPS System

Up to 40 obs from wantwps total obs=3

Obs            FILE            RELEVANCE

 1     d:/pdffnd/roger1.pdf    Relevant     (Alfred is only in this pdf)
 2     d:/pdffnd/roger2.pdf    Irrelevant
 3     d:/pdffnd/roger3.pdf    Irrelevant

*                _                    _  __
 _ __ ___   __ _| | _____   _ __   __| |/ _|___
| '_ ` _ \ / _` | |/ / _ \ | '_ \ / _` | |_/ __|
| | | | | | (_| |   <  __/ | |_) | (_| |  _\__ \
|_| |_| |_|\__,_|_|\_\___| | .__/ \__,_|_| |___/
                           |_|
;

* create 3 pdfs;
data _null_;
  do fyl="d:/pdf/roger1.pdf","d:/pdf/roger2.pdf","d:/pdf/roger3.pdf";
     call symputx('fyl',fyl);
     cnt+1;
     call symputx('seed',put(cnt,2.));
     rc=dosubl('
        ods pdf file="&fyl";
          proc print data=sashelp.class(where=(uniform(&seed)<.3));
          run;quit;
        ods pdf close;
        run;quit;

     ');
  end;
stop;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

see link for commented code

%utl_submit_wps64('
libname wrk "%sysfunc(pathname(work))";
proc r;
submit;
library(pdftools);
library(dplyr);

pdf_files <- list.files("d:/pdffnd/", full.names = T);
pdf_files;

search_pdf <- function(pdf_files, search_term, n_words = 100) {
  res_list <- lapply(pdf_files, function(file) {
    content <- pdf_text(file);
    content2 <- tolower(content);
    content2 <- gsub("\\n", "", content2);
    content2 <- gsub("[[:punct:]]", "", content2);
    content_vec <- strsplit(content2, " ")[[1]];
    found <- search_term %in% content_vec[1:n_words];
    res <- data_frame(file = file,
       relevance = ifelse(found, "Relevant", "Irrelevant"));
    return(res);
  });
  res_df <- bind_rows(res_list);
  return(res_df);
};
want<-as.data.frame(search_pdf(pdf_files, search_term = "alfred", n_words = 1000));
want;
endsubmit;
import r=want data=wrk.wantwps;
run;quit;
proc print data=wrk.wantwps;
run;quit;
');
