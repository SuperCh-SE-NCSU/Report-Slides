Make
----

The grand-daddy of these is UNIX make. GNU make is ubiquitous in the linux world for installing and compiling software. It has been widely used to build computational pipelines because it supports:

+ Stopping and restarting computational processes
+ Running multiple, even thousands of jobs in parallel

For some notes on its drawbacks, and some  more recent alternatives see:
 
+ [http://www.ruffus.org.uk/design.html](http://www.ruffus.org.uk/design.html).
+ [Recursive Make considered harmful](http://aegis.sourceforge.net/auug97.pdf)

# About MAKE

A domain-specific language for handling dependencies.

MAKE = list of rules:

    target: dependents
       script for generating target
       

Internally, Make is a tree of dependancies and if the leaves are newer than the parents, then the parents are regenerated.
from the kids.

Example of a _Makefile_ (default is to run the first rule).

    SHELL=/bin/bash
    CFLAGS=-g -Wall -ansi -pedantic
    Exe=$(HOME)/bin
    CC=gcc
    
    all: tar3
    
    tar3: $(Exe)/tar3
    
    $(Exe)/tar3 : c/*.c
    	cd c && $(CC)  $(CFLAGS) -o $(Exe)/tar3 *.c -lm
    	@echo $(Exe)/tar3


Question: if I call this twice, nothing happens the second time.
Why?

Another _Makefile_. Builds the web site for this subject.
Source code comes from _doc/*_. Results got to _var/*_.
In the following:

+ _$@_ is the target and _$<_ is the first dependent.
+ _$(shell ...)_ calls stuff outside make.
+ _$(subset old, new, this)_ is text substitution.


```
    Down=markdown_py -x footnotes -x tables -x fenced_code -x codehilite
    Mds=$(shell ls doc/*.md)
    Htmls=$(subst .md,.html,$(subst doc/,var/,$(Mds)))
    
    all: dirs sources pythons htmls commit status
    
    # some stuff removed
    
    htmls: $(Htmls)
    
    var/%.html : doc/%.md
    	$(Down)  $< > $@
    	svn -q add --force $@
    	svn -q propset svn:mime-type text/html $@
    
    commit:
    	svn commit -m stuff --username $(Who) --password $(Pass)
```


Question: if I call this twice, nothing happens the second time.
Why?

## Aside: Parallel Makes

+ Make can analyze a dependency tree
+ Identity unrelated branches
+ Can run one branch per processor.

So simple!

    make -j 4 # for a quad-core machine

For example:


       prog :  x.o  y.o  z.o
               cc  x.o  y.o  z.o  -lm  -o prog
       x.o  :  x.c  defs.h
               cc  -c  x.c
       y.o  :  y.c  defs.h
               cc  -c  y.c
       z.o  :  z.c
               cc  -c  z.c


For the makefile shown above, it would create processes to build x.o, y.o and z.o in parallel. After these processes were complete, it would build prog.

You can use the .MUTEX directive to serialize the updating of some specified targets. This is useful when two or more targets modify a common output file.  
To prevent make from building x.o and y.o in parallel, the makefile above would contain a .MUTEX directive of the form:


       .MUTEX: x.o y.o

## Configuring Make

If we sperate Makefiles into some initial config then sme generic processing, we can
do a better job of reusing code.

For example, here is a configuration file that sets some variables:


```
Out=../../www/cs510
Raw=$(PWD)
Lib=./lib

include $(Lib)/lib.mk
```

Note that the last line includes another file and that
file has many rules. _Any_ of these can be called
from the command line using (e.g. `make ready` or `make gitting`).

First rule is the default rule

```
ready : dirs files dots talks plots pages
	@echo "See $(Out)"
```

Convenience code for stopping GIT pestering your for passwords

```
gitting:
	git config --global credential.helper cache
	git config credential.helper 'cache --timeout=3600'
```

As a commit hook, as a side effect of saving, we update site

```
commit: ready save
```

Convenience functions for git

```
save:
	- git status
	- git commit -a
	- git push origin master

addll:
	git add --all 

typo:
	- git status
	- git commit -am "typo"
	- git push origin master

update:
	- git pull origin master

status:
	- git status
```

Setting up dir structure

```
Skeleton=dot etc plot slides verbatim/img
dirs: 
	@$(foreach d,$(Skeleton),mkdir -p $(Raw)/$d;)
	@mkdir -p $(Out)/slides
	@mkdir -p $(Out)/posts
	@ mkdir -p $(Out)/img/dot
	@ mkdir -p $(Out)/img/plot
	@cp -vrup $(Lib)/etc/* $(Raw) 

files:
	@cp -vrup $(Raw)/verbatim/* $(Out)
```

Generates  lists of files to switch


```
talks:  $(call target,slides,md,html,$(Raw),$(Out))
dots  : $(call target,dot,dot,png,$(Raw),$(Out)/img)
plots : $(call target,plot,plt,png,$(Raw),$(Out)/img)
pages : $(call target,posts,md,html,$(Raw),$(Out))
```

Subroutine. changes pathnames and suffixes.
called via $(call target,dir,oldExt,newExtension,OldPath,NewPath)

```
define target
   $(subst $4,$5,\
      $(subst .$2,.$3,\
         $(shell ls $(Raw)/$1/*.$2)))
endef
```

Debugging trick

```
debug:
	echo  $(call target,posts,md,html,$(Raw),$(Out))
```

Finally, the workers

Making slides:
```
$(Out)/slides/%.html : $(Raw)/slides/%.md 
	pandoc -s \
              --webtex -i -t slidy \
              -r markdown+simple_tables+table_captions \
              --biblio $(Raw)/biblio.bib \
	      -c        ../img/slidy.css \
              -o $@ $<
```

Making directed graphs.

```
$(Out)/img/dot/%.png : $(Raw)/dot/%.dot
	dot -Tpng -o $@ $<
```

Visualizing data

```
$(Out)/img/plot/%.png : $(Raw)/plot/%.plt
	gnuplot $< > $@
```

Making good old fashioned html pages.

```
$(Out)/posts/%.html : $(Raw)/posts/%.md
	pandoc -s \
              -r markdown+simple_tables+table_captions+pipe_tables \
		-B $(Raw)/before.html \
              --biblio $(Raw)/biblio.bib \
	            -c        ../img/posty.css \
              -o $@ $<
```

That's all folks.
