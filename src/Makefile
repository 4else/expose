.PHONY: help tests ho bye mds

help:
	@printf "make [OPTIONS]\n\nOPTIONS:\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%10s :\033[0m %s\n", $$1, $$2}'

tests: ## run tests
	ls *.lua |entr -c ../etc/tasks.sh

hi: ## start work (update all files)
	git add *;git commit -am save;git push;git status

bye: mds ## stop work (save all files)
	git add *;git commit -am save;git push;git status
	
MDS = ../docs/$(subst .lisp ,.md ../docs/,$(shell ls *.lisp))

mds : $(subst .lisp,.md,$(MDS))

../docs/%.md: %.lisp Makefile ../etc/head.md ../etc/md.awk
	@echo "# $@ ..."
	@(cat ../etc/head.md; gawk -f ../etc/md.awk -v title="$<" $< ) > $@
	@git  add $@


pdfs: ../docs/small.pdf

f=relax.lisp



../docs/%.pdf : %.lisp ok
	a2ps  -BjR --line-numbers=1                       \
            --borders=no --pro=color --columns 2 \
            --right-footer="" --left-footer="" \
            --footer="page %p." \
            -M letter -o $@.ps $<
	ps2pdf $@.ps $@
	rm $@.ps
	git add $@

html: ## show html
	gawk -f ../etc/lua2md.awk $f > ../docs/$f.md
	pandoc -s --toc --toc-depth=6 -V fontsize=9pt  -c lua.css --metadata title="$f" ../docs/$f.md -o ../docs/$f.html

pandoc:
	gawk -f ../etc/lua2md.awk $f > ../docs/$f.md
	pandoc ../docs/$f.md -V geometry:margin=1in  -V fontsize=9pt -V documentclass:scrbook -V fontfamily:times  \
	--highlight=tango  -s --toc --toc-depth=6 --metadata title="$f" -o ../docs/$f.pdf

header:
	@read x; echo $$x | figlet -W -f straight | gawk '{print "--    "$$0}'

ok:
	mkdir -p ../docs
