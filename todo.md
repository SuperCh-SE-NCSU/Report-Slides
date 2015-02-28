write a make file that is a recursive walker

```
.md ==> .html % via pandoc
.mkd ==> .html % via pandoc slides
.dot ==> png # graphs
.plt ==> png # plots
.x   ==> x
```

if gets fired off on a Raw directory and is written to an Out directory

so the whole site is

```
.cook
   lib # my code
   inc # a whole bunch of defaults used in compilation
         references.bib
         style.css
         before.html
         after.html
         template.html
.raw
   inc
     optional stuff 
  the rest of your stuff   
```

during compilation, we use files in cook/inc UNLESS they are found in raw/inc

```
ifeq ($(wildcard file1),) 
    CLEAN_SRC =
else 
    CLEAN_SRC = *.h file3
endif
```
