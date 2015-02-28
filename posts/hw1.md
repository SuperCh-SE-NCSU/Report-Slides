---
title: Homework1
mantra: Cause we get more done if we work together
---

(See also: [the grading rubric](rubric1.html);
a [tutorial on make](make.html); 
the [Pandoc home page](http://johnmacfarlane.net/pandoc/);
the [dot reference page](http://www.graphviz.org/Documentation.php);
and the [gnuplot doco ](http://gnuplot.sourceforge.net/demo/).)

## Goals 

Learn how to work effectively in teams via

+ Version control systems (Github)
+ Configuration management systems (UNIX Makefile)
+ Virtualization (NcState Virtual Computing Lab)
+ Text-based markup tools (Pandoc, markdown, gnuplot, graphviz, bibtex)

## What to Do 

Build a very [simple static web site][egsite] that is:

+ Feed from a Github repo (so any context committed to the repo updates the website)
+ That is shared with your team mates via Github (so multiple people can work on the site)
+ That is rendered via text-based mark up tools (so it can be maintained very quickly)
+ That is configured using Make (so anyone can copy and set it up for themselves, locally)

Specifically, you will build a web site that
contains a slide show that describes your large
project proposal and your personnel (one slide per
person)

+ Do not put contact details onto the slides for each person (death to spammers);
+ The large project proposal will be described to you in lectures.

[egsite]: http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html "Example of site"

## What you Will do Wrong



You will be working in five _spaces_:


+ NCSU VCL environment;
+ Your NCSU personnel storage space
+ Your www4 account (which is inside the storage space)
+ Your local copies of your github repo
+ Your public sharable copy of the repo on Github

Here is the login page for VCL http://vcl.drupal.ncsu.edu

<center><img width=500 src="../img/vcl1.png"></center>

From there, you select a **New Reservation**.

<center><img width=500 src="../img/vcl2.png"></center>

Then you select _timmnix (perhaps giving yourself a longer duration than 1 hour).

<center><img width=500 src="../img/vcl3.png"></center>

Then you grab the IP address from which you can (e.g. `ssh unityid@123.45.678

<center><img width=500 src="../img/vcl4.png"></center>


You will get that all muddled and you will spend some time sorting all that out:

+ When you login, you will be in the NCSU VCL environment. This is a temporary
  space that _disappears_ when you log out, _destroying_ any work you did there.
+ When you `cd` across to your personnel  storage space, you have jumped
  files systems. Anything you change here, stays there forever.
+ But, unless you _start_ in VCL and _then_ `cd` to permanent, you will
  not be able to access all the tools I configured for your work.
+ A small bit of your personnel  storage is your `www` directory. You will
  lose it and try to write your static web pages to some other directory.
  This will either (a) cause a crash or (b) mean that your  web site does not update.
+ Another small bit of your personnel storage is contents of your github
  repo. You will forget to work in that repo, or you won't check it out in the
  first place, or you will forget to commit your changes from personnel  storage.
  In all those cases, your team mates will be unable to share code with you.
+ On the web is your github repo. You will forget to regularly update and
  commit from that repo. Which means you won't share anything with your
  colleagues.

So, as quick as you can, make all the above mistakes and move on from there.

## How to Start 

### Set up your WWW4 space

Using the instructions given to you at 
[https://oit.ncsu.edu/afs/www-setup](https://oit.ncsu.edu/afs/www-setup).


<center><img width=500 src="../img/www.png"></center>


### Set up Github

+ Create a team of people (four people per team)
+ Create a public Github account (do not use the NcState one);
+ In that Github, create a new organization (called, e.g. XYZ).
+ Go to https://github.com/orgs/XYZ/teams and create a new team with _Admin Access_.
+ Add all your team members to that team.
+ In that organization, create repos called   `txts`.
  
 

### Set up Tools

Set up pandoc, graphviz, gnuplot, pandoc-citeproc, make, bash, awk, graphviz and
20 other little tools used for this work

+ Method1: the easy way. Log into the  `\_timmnix` image I made for you at
  [http://http://vcl.drupal.ncsu.edu](http://http://vcl.drupal.ncsu.edu).  
  Then `cd /afs/unity.ncsu.edu/users/a-z/unityid/`
  Now you are using all the tools I installed for you, and you can write to
  your personnel file space.
+ Method2: another way. Download and run 
  [https://github.com/timm/timmnix/blob/master/install.sh](https://github.com/timm/timmnix/blob/master/install.sh)
  from the command line terminal
	on your own UNIX installation
  hardware  (e.g. ubuntu on virtual box
  on whatever machine you like). 

Note I will support Method1 users. As to Method2
**you are on their own**. If you
have any problems with Method2  then my only help will be to say "try method1".

### Download the repos

```
cd /afs/unity.ncsu.edu/users/a-z/unityid # or wherever you work
mkdir gits
cd gits
git clone https://github.com/XYZ/txts.git
cd txts
wget https://github.com/txts/txts/archive/master.zip
unzip master.zip
mv txts-master/* .
git add --all
rm master.zip
```

Tell the repo where to place its output. 
Edit the file `gits/txt/Makefile` and make it look something like the following.
Note that `../../www` is your NcState www4 space.

```
Out=../../www/cs510
Raw=$(PWD)
Lib=./lib

include $(Lib)/lib.mk
```


Then do a _test install_, as shown below.

## How to test the site 

### Test Install

```
cd gits/txts
make
```

You should see a lot of output.

Point a browser at 
[http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html](http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html).


You should now see something like [my example site][egsite].

Now do it again

```
cd gits/txt
make
```

And you should see no output since the slides are up to date with your current contents.

(Tip: if in your work you see

```
** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
```

then run these `git congfig` commands to get everything set up.

### Test Configuration Tools

Edit `gits/txts/slides/talk1.md`. Change the title of the talk. Then

```
cd gits/txts
make
```

There should be just a little output.

Point a browser at 
[http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html](http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html).

Can you see the new title?

### Test update

Check out the repo git clone https://github.com/XYZ/txts.git on another machine.

Add a new word to the title of `gits/txts/slides/talk1.md`. Commit the changes.

Come back to your VCL account and return to `/afs/unity.ncsu.edu/users/a-z/unityid/`

```
cd git/txts
make update
make
```

Point a browser at 
[http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html](http://www4.ncsu.edu/~tjmenzie/cs510/slides/talk1.html).

Can you see the new title?

## Using the Installed Site


Now that the site is working, write a proposal for [project1](projects.html).
Less than 10 slides saying what it is you are wanting to do. Also, add
four more slides containing info on your team members.

## What to hand in 

+ Fill out the [homework1 rubric](rubric1.html).
+ Print https://github.com/XYZ/txts/graphs/contributors.
+ Copy these two things three times.
+ Staple together each copy (table first, commit logs second). Unstabled
  material will not be accepted. No joke.
+ Hand in these three copies.

When you fill in the following table,
fill in the _self score_ column by ticking all the items
you think you have completed.

+ Do not write anything into the columns _peer score_`, _final score_


In the rubric:

+ Where it says _modified X_, this means at least one change (however slight)
  from the stuff already in [the example site][egsite].
+ Where is says "all members have committed", we will check that using
  the github logs. Note that we do **not** expect to see _outliers_ in the commit
  pattern such as one person with 90% or 10% of the commits.
  
 

