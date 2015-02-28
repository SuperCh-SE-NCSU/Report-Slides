###########
#
# Not to be used directly.
# To be included in other Makefiles
# that have determined variables for
# Raw, Lib, Out
#
#########

Dirs=$(Lib) $(Raw) $(Out)

define target
   $(subst $4,$5,\
      $(subst .$2,.$3,\
         $(shell ls $(Raw)/$1/*.$2)))
endef


ready : intergrate dirs files dots talks plots pages
	@echo "See $(Out)"

gitting:
	git config --global credential.helper cache
	git config credential.helper 'cache --timeout=3600'

commit: ready save

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

intergrate:
	cat $(Raw)/separate_slides/*.md > $(Raw)/slides/talk1.md

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
	@cp -vrup $(Raw)/team_member_img/* $(Out)/img

talks:  $(call target,slides,md,html,$(Raw),$(Out))
dots  : $(call target,dot,dot,png,$(Raw),$(Out)/img)
plots : $(call target,plot,plt,png,$(Raw),$(Out)/img)
pages : $(call target,posts,md,html,$(Raw),$(Out))

debug:
	echo  $(call target,posts,md,html,$(Raw),$(Out))

$(Out)/slides/%.html : $(Raw)/slides/%.md 
	pandoc -s \
              --webtex -i -t slidy \
              -r markdown+simple_tables+table_captions \
              --biblio $(Raw)/biblio.bib \
	      -c        ../img/slidy.css \
              -o $@ $<

$(Out)/img/dot/%.png : $(Raw)/dot/%.dot
	dot -Tpng -o $@ $<

$(Out)/img/plot/%.png : $(Raw)/plot/%.plt
	gnuplot $< > $@

$(Out)/posts/%.html : $(Raw)/posts/%.md
	pandoc -s \
              -r markdown+simple_tables+table_captions+pipe_tables \
		-B $(Raw)/before.html \
              --biblio $(Raw)/biblio.bib \
	            -c        ../img/posty.css \
              -o $@ $<
