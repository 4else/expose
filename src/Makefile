tests:
	ls *.lua |entr -c ../etc/tasks.sh

duo:; $(MAKE) f=duo.lua pdf

pdfs: 
	$(MAKE) f=fun.lua pdf
	$(MAKE) f=duo.lua pdf

f=muse
pdf: ok 
	a2ps  -BjR --line-numbers=1                       \
            --borders=no --pro=color --columns 2 \
            --right-footer="" --left-footer="" \
            --footer="page %p." \
            -M letter -o ../docs/$f.ps $f 
	ps2pdf ../docs/$f.ps ../docs/$f.pdf
	rm ../docs/$f.ps
	git add ../docs/$f.pdf

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

