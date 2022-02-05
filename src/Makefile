tests:
	ls *.lua |entr -c ../etc/tasks.sh


pdfs: ../docs/small.pdf

f=relax/lisp

../docs/%.pdf : %.lisp ok
	a2ps  -BjR --line-numbers=1                       \
            --borders=no --pro=color --columns 2 \
            --right-footer="" --left-footer="" \
            --footer="page %p." \
            -M letter -o $@.ps $<
	ps2pdf $@.ps $@
	rm $@.ps
	git add $@

html:
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

bye:
	git add *;git commit -am save;git push;git status

