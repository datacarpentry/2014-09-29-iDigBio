# Using spreadsheet programs for scientific data #

Contributors: Christie Bahlai, Aleksandra Pawlik, Tracy Teal

---

Spreadsheets encompass a lot of the things we need
to be able to do as researchers. We can use them for:

- Data entry
- Organizing data
- Subsetting and sorting data
- Statistics
- Plotting

How many people have used spreadsheets in their research?

----

Spreadsheets can be very useful, but they can also be
frustrating and even sometimes give us incorrect results.

What are some things that you've accidentally done in
a spreadsheet, or have been frustrated that you can't do
easily?

---

### Common spreadsheet use case - all the things

![by @tim_yates](images/1_helpful_clippy.jpg)

---

### Challenges and opportunities

This doesn't seem obviously bad, but it was a pain to put
together, the whole thing is sort of tenuously linked
and if I accidentally change data everything breaks. Also
if I'm meeting with a collaborator and want to change
how we normalize something, or average by year instead
of treatment, it's not very easy to do.

In other sections today and tomorrow, we're going
to talk about how you can avoid some of these things
by using SQL and R.

---

### Spreadsheet outline

In this lesson, we’re going to talk about:

- Good data entry practices - formatting data tables in spreadsheets
- How to avoid common formatting mistakes
- Dates as data - beware!
- Basic quality control and data manipulation in spreadsheets
- Exporting data from spreadsheets

*Overall good data practices*

---

### What this lesson will not teach you

- How to do statistics in a spreadsheet
- How to do plotting in a spreadsheet
- How to write code in spreadsheet programs

If you're looking to do this, a good reference is
Head First Excel by O'Reilly

---

### Why aren't we teaching this

- It is difficult to track or reproduce statistical
or plotting analyses done in spreadsheet programs


### Bahlai 4 rules for spreadsheets

Spreadsheet programs are use very useful graphical interfaces for designing data
tables and handling basic data quality control functions.

The cardinal rules of using spreadsheet programs for data:

	1. Put all your variables in columns
	2. Put each observation in its own row
	3. Don’t @#$%! with it
	4. Be able to export to CSV

--

### Spreadsheet programs

- LibreOffice - used in these lessons because it's a free, open source
spreadsheet program
- Microsoft Excel
- Gnumeric
- OpenOffice.org

Commands may differ a bit between programs, but general ideas
for thinking about spreadsheets is the same.

---

### Formatting data tables in Spreadsheets

We commonly use spreadsheets as lab notebooks

Rely on context, notes in the margin, spatial
layout of data and fields to convey information.

As humans, we can (usually) interpret
these things, but computers are dumb, if we want to be able to stay consistently
organized and be able to move beyond spreadsheets we need to just think
in rows and columns.

This is why it’s extremely important to set up well-formatted tables from the outset-
before you even start entering data from your very first preliminary experiment.

Spreadsheets are powerful because they allow us to connect things that relate to each
other in a  machine-readable way.

---

### Getting the most out of spreadsheets

Entering and maintaining data in a machine readable
way let's us get the most power out of them.

Failing to use this functionality is essentially
the same as scanning your datasheets and saving them as jpegs- digitally backed up.
When you don’t set up your spreadsheet
which allows the computer to see how things are connected, you’re either creating a
lot of work for you or for someone else, or making your data hard to use.

We want to change thinking about spreadsheets as
lab notebooks to something you created that you
can use the power of the computer to do work for you.

Think like a computer! Let the power of the computer work for you!

---

### Spreadsheet guidelines

There are two simple rules you should keep in mind when entering your data into any spreadsheet:

- Each data cell is an observation that must have all the relevant information connected to it
for it to stand on its own.

- You must make it clear to the computer how the data cells relate to the relevant information
and each other.

---

### Rule of thumb

The rule of thumb, when setting up a datasheet, is
- columns= fields
- rows = observations
- cells=data (values)

- no multiple tables within one spreadsheet

---

### Examples

*Hands on*

Let's try this with an example using some of our sample data:
[a list of species](../data/biology/species.csv) and
[a list of plots](../data/biology/plots.csv).
You can do that by simply opening the `*.csv` files in Excel.
Excel will automatically try to fit the data from the `*.csv` file and put
the first value in column A and the second value in column B.

---

### The Dataset



---

### Open files

In the 'data' folder that you downloaded, open
'survey_data.xls'

---

### Opening a csv file in a spreadsheet program

- csv stands for 'comma separated values'
- all speadsheet programs can read this format
- computers can easily read and parse this format



---

### Do not put multiple tables in one spreadsheet


A common spreadsheet use is to create multiple data tables
 within one spreadsheet. NEVER DO THIS.

When you create multiple tables within one spreadsheet, you’re drawing
false associations between things for the computer, which sees each row as
an observation. You’re also potentially using the same field name in multiple
places, which will make it harder to clean your data up into a usable form.

![Classis spreadsheet mistake](images/2_datasheet_example.jpg)

[survey_data.xls]

---

### Tabs also make it harder to analyze data

But what about worksheet tabs? that seems like an easy way to organize data, right?
Well, yes and no. When you create extra tabs, you fail to allow the computer to
see connections in the data that are there. Say, for instance, you make a separate
tab for each day you take a measurement.

[survey_data_tab.xls]

This is bad practice for two reasons:

1. You are more likely to accidentally add
inconsistencies to your data if each time you take a measurement, you start recording
data in a new tab
2. Even if you manage to prevent all inconsistencies from
creeping in, you will add an extra step for yourself before you analyze the data
because you will have to combine these data into a single datatable. You will have
to explicitly tell the computer how to combine tabs- and if the tabs are
inconsistently formatted, you might even have to do it by hand!

The next time you’re entering data, and you go to create another tab or table, I want you to ask yourself “Self, could I avoid adding this tab by adding another column to my original spreadsheet?”

[survey_data_column.xls]

### Freeze panes

Your data sheet might get very long over the course of experiment. This makes it harder to enter data if you can’t see your headers at the top of the spreadsheet. But do NOT repeat headers. These can easily get mixed into the data, leading to problems down the road.

[Show an example of how to freeze panes in Excel]

---

## Common mistakes  
### Not filling in zeroes ##
-example: when entering count data for a community, nonzero observations may be rare- why bother if they’re mostly zeroes?
Spreadsheets and statistical programs will likely mis-interpret blank cells that are meant to be zero. This is equivalent to leaving out data. Zero observations are real data! Leaving zero data blank is not good in a written lab notebook, but NEVER okay when you move your data into a digital format

[create an example of this in Excel]

---

### Using bad null values ##
-example: using -999 or other numerical values (or zero)
Many statistical programs will not recognize that numeric values of null are indeed null. It will depend on the final application of your data and how you intend to analyse it, but it is essential to use a clearly defined and CONSISTENT null indicator. Blanks (most applications) and NA (for R) are good choices.

---

From White et al, 2013, Nine simple ways to make it easier to (re)use your data. Ideas in Ecology and Evolution:

![White et al.](https://raw.githubusercontent.com/cbahlai/datacarpentry/master/lessons/excel/images/3_white_table_1.jpg)

---

## Using formatting to convey information ##
 Example: highlighting cells, rows or columns that should be excluded from an analysis, leaving blank rows to indicate separations in data
	solution: create a new field to encode which data should be excluded

[create an example of this in Excel]

---

## Using formatting to make the data sheet look pretty ##
Example: merging cells
If you’re not careful, formatting a worksheet to be more aesthetically pleasing can compromise your computer’s ability  to see associations in the data. Merged cells are an absolute formatting NO-NO if you want to make your data readable by statistics software.  Consider restructuring your data in such a way that you will not need to merge cells to organize your data

[create an example of this in Excel]

---

## Placing comments or units in cells ##
Example: your data was collected, in part, by a summer student you later found out was mis-identifying some of your species, some of the time. You want a way to note these data are suspect.
Solution: most statistical programs can’t see Excel’s comments, and would be confused by comments placed within your data cells. Create another field if you need to add notes to cells. Similarly, don’t include units- ideally, all the measurements you place in one column should be in the same unit, but if for some reason they aren’t, create another field and specify the units the cell is in.

[create an example of this in Excel]

---

## More than one piece of information in a cell ##
Example: you find one male, and one female of the same species. You enter this as 1M, 1F.
Solution: Never, ever, EVER include more than one piece of information in a cell. If you need both these measurements, design your data sheet to include this information.

[create an example of this in Excel]

---

## Field name problems ##
Choose descriptive field names, but be careful not to include: spaces, numbers, or special characters of any kind. Spaces can be misinterpreted and some programs don’t like field names that are text strings that start with numbers.

[work through good examples of field names]

---

## Dates as data ##
Spreadsheet programs have numerous “useful features” which allow them to “handle” dates in a variety of ways.

![Many formats, many ambiguities](https://raw.githubusercontent.com/cbahlai/datacarpentry/master/lessons/excel/images/5_excel_dates_1.jpg)

But these ‘features’ often allow ambiguity to creep into your data. Ideally, data should be as unambiguous as possible. The first thing you need to know is that Excel stores dates as a number- see the last column in the above figure. Essentially, it counts the days from a default of December 31, 1899, and thus stores July 2, 2014 as  the serial number 41822.

(But wait. That’s the default on my version of Excel. We’ll get into how this can introduce problems down the line later in this lesson. )

This serial number thing can actually be useful in some circumstances. Say you had a sampling plan where you needed to sample every thirty seven days. In another cell, you could type:

    =B2+37

And it would return

    8-Aug

because it understands the date as a number 41822, and 41822 +37 =41859 which Excel interprets as August 8, 2014. It retains the format (for the most part) of the cell that is being operated upon, (unless you did some sort of formatting to the cell before, and then all bets are of)

Which brings us to the many ‘wonderful’ customizations Excel provides in how it displays dates. If you refer to the figure above, you’ll see that there’s many, MANY ways that ambiguity creeps into your data depending on the format you chose when you enter your data, and if you’re not fully cognizant of which format you’re using, you can end up actually entering your data in a way that Excel will heavily misinterpret.

---

Once, Bahlai received a dataset from a colleague representing insect counts that were taken every few days over the summer, and things went something like this:

![So, so ambiguous, it's even confusing Excel](https://raw.githubusercontent.com/cbahlai/datacarpentry/master/lessons/excel/images/6_excel_dates_2.jpg)


If Excel was to be believed, my colleague had been collecting bugs IN THE FUTURE. Now, I have no doubt this person is highly capable, but I believe time travel was beyond even his grasp.

---

Thus, in dealing with dates in spreadsheets, we recommend separating date data into separate fields, which will eliminate any chance of ambiguity.

In my own work, I tend to store my dates in two fields: year, and day of year (DOY). Why? Because this is what’s useful to me, and there is practically no possibility for ambiguity creeping in.

Many statistical models incorporate year as a factor, to account for year-to-year variation, and then you can use DOY to measure the passage of time within a year.

Alternatively, you can have different columns for day, month and year. This also
makes it easy if you want averages per year or just for a
certain month.

---

So, can you convert all your dates into DOY format? Well, in excel, here’s a handy dandy guide:

![Kill that ambiguity before it bites you!](https://raw.githubusercontent.com/cbahlai/datacarpentry/master/lessons/excel/images/7_excel_dates_3.jpg)



[Exercise: pulling month out of Excel dates]

---

## Basic quality control and data manipulation in spreadsheets #

When you have a well-structured data table, you can use several simple techniques within your spreadsheet to ensure the data you’ve entered is free of errors.

*Tip! before doing any quality control operations, ensure your data is stored as “values” and not as formulas.  Because formulas refer to other cells, and you may be moving cells around, you may compromise the integrity of your data if you do not take this step!

[Example: converting all data to values: use soybean aphid suction trap dataset for this section]

## Sorting ##
Bad values often sort to bottom or top of column. Sort your data by each field, one at a time. Scan through each column, but pay the most attention to the top and the bottom of a column.
If your dataset is well-structured and does not contain formulas, sorting should never affect the integrity of your dataset.

[Example: sorting]

---

## Conditional formatting ##
 Use with caution! But a great way to flag inconsistent values when entering data.

[Example: conditional formatting]

---

## Check on cell formats ##
A good way to check if you’ve got data of the wrong type in a column is by checking column format. This can also help prevent issues when you export your data.

[Example: variable format]

---

## Pivot tables ##
Pivot tables are a very powerful tool in Excel. They’re useful to check for issues with data integrity because they provide a quick, visual way to spot things that are amiss, including with categorical variables. They are also great for reshaping data and obtaining summary statistics quickly in a drag and drop interface.

[Example in Pivot Table]

Why would I need to reshape my data? Different analyses require data to be in different formats- example: taking a species list to a diversity analysis.

[Use species list example]

Note: these operations can be done in most statistical or programming packages (i.e. using reshape2, plyr  in R)

---

### What if I want to use a spreadsheet for some
lab notebook like activities

- Create a spreadsheet with just your data in it using
the data spreadsheet recommendations

1. Put all your variables in columns
2. Put each observation in its own row
3. Don’t @#$%! with it
4. Be able to export to CSV

- Name that files dataset_raw.csv or data_just-the-data.csv
or something like that. Put it somewhere and don't touch it.
Copy that file to data_analysis.xls and then do your analysis
there.

- The idea is you want just that raw data file somewhere
that you can always come back to, send to your collaborator,
upload to a central repository or distribute with your publication.
It's a file where you won't mess up the data on accident.

---

# Exporting data from spreadsheets #
Storing data in Excel is a bad idea. Why? Because it is a proprietary format, and it is possible that in the future, technology won’t exist (or will become sufficiently rare)  to make it inconvenient, if not impossible, to open the file.

Think about zipdisks. How many old theses in your lab are “backed up” and stored on zipdisks? Ever wanted to pull out the raw data from one of those?
Exactly.

But more insidious- different versions of Excel may be changed so they handle data differently, leading to inconsistencies.

As an example, do you remember how we talked about how Excel stores dates earlier? Turns out there are multiple defaults for different versions of the software. And you can switch between them all willy-nilly. So… say you’re compiling Excel-stored data from multiple sources. There’s dates in each file- Excel interprets them as their own internally consistent serial numbers. When you combine the data, Excel will take the serial number from the place you’re importing it from, and interpret it using the rule set for the version of Excel you’re using. Essentially, you could be adding a huge error to your data, and it wouldn’t necessarily be flagged by any data cleaning methods if your ranges overlap.

Storing data in a universal, open, static format will help deal with this problem. Try tab-delimited (ok) or csv (best). Most spreadsheet programs can do this easily, although they complain and make you feel like you’re doing something wrong along the way.

[Walk through an example of saving an Excel file to CSV]

An important note for backwards compatibility: you can open CSVs in Excel!

A cautionary note on Excel for Mac- apparently, there are some issues that can occur in certain versions when you attempt to save to .csv on a Mac- specifically, the line endings generate problems for several statistical problems and coding environments. The GUI-based workaround is to save the file as a “Windows comma separated (.csv)” file. A code-based work-around can be found here:
http://nicercode.github.io/blog/2013-04-30-excel-and-line-endings/

---

### Upload your awesome data to a shared repository

- Data itself can now be a DOI. You can get credit
for that dataset you worked so hard to create!
