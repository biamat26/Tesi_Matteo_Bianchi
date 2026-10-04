# aggiorna questo nome con il nome del file .tex che contiene la tua tesi
finalname = Tesi

# lista qui di seguito tutti i file aggiuntivi .tex (se ci sono) che compongono 
# la tua tesi (tipicamente sono quelli importati con il comando \input{miofile} dentro
# il file principale .tex
included_latex_sources = \
	ringraziamenti.tex \
	introduzione.tex \
	capitoli/capitolo1_llm-e-agenti.tex \
	capitoli/capitolo2_protocollo-a2a.tex \
	capitoli/capitolo3_requisiti-sistema.tex \
	capitoli/capitolo4_progettazione.tex \
	capitoli/capitolo5_validazione-testing.tex \
	conclusioni.tex

# lista qui le figure che ti servono 
pdffiles = \
	figure/uniroma3-logo.pdf

$(finalname): $(included_latex_sources) $(pdffiles) $(finalname).tex
	pdflatex $(finalname).tex

%.bbl: %.aux
	bibtex $<

%.ps: %.fig
	fig2dev -Leps $< $@

%.eps: %.fig
	fig2dev -Leps $< $@

%.ps: %.gif
	convert $< $@

%.ps: %.jpg
	convert $< $@

clean:
	rm -f $(finalname).pdf
	rm -f $(finalname).log
	rm -f $(finalname).out
	rm -f $(finalname).toc
	rm -f $(finalname).lof
	rm -f *~
	rm -f *.bak
	rm -f figure/*.bak
	rm -f *.toc
	rm -f *.aux
	rm -f *.blg
	rm -f *.dvi
	rm -f *.log
	rm -f temp.tex
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind


index: 
	latex $(finalname).tex
	makeindex $(finalname)
	latex $(finalname).tex
	latex $(finalname).tex

bib:
	pdflatex $(finalname).tex
	bibtex $(finalname)
	pdflatex $(finalname).tex
	pdflatex $(finalname).tex


