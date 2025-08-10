{smcl}
{* *! version 1.0.0 10aug2025}{...}
{cmd:help texttranslation}

{hline}
{title:Title}

{cmd:texttranslation} — Translate open-ended survey responses (Bangla/English) in Stata using Python

{hline}
{title:Syntax}

{p 8 17 2}
{cmd:texttranslation} {cmd:using} "{it:inputfile.xlsx}", {cmd:originalvar(}{it:varname}{cmd:)} {cmd:output(}{it:outputfile.xlsx}{cmd:)}

{hline}
{title:Description}

{pstd}
{cmd:texttranslation} reads an Excel file containing survey data, translates the specified text
column from Bangla, English, or Bangla written in English letters to English, and saves the
translated results to a new Excel file.

{pstd}
This program uses Python and the free Google Translate web service via the {it:googletrans} library.
No API key is required.

{hline}
{title:Options}

{p 4 8}{cmd:originalvar(varname)}  
    Name of the column in the Excel file containing the text to be translated.

{p 4 8}{cmd:output(filename.xlsx)}  
    Name of the Excel file to save the results to. This file will include the original
    data plus a new variable {_translated_text}.

{hline}
{title:Remarks}

{pstd}
Before first use, make sure you have Python installed and install the required libraries:

{cmd}
pip install googletrans==4.0.0-rc1 pandas
{txt}

{pstd}
The Python helper script {it:translate_helper.py} must be in the same directory as the ado file.

{hline}
{title:Example}

{cmd}
. texttranslation using "survey.xlsx", originalvar(open_text) output("translated.xlsx")
{txt}

{hline}
{title:Author}

{pstd}
YOUR NAME  
YOUR EMAIL OR WEBSITE
{hline}
