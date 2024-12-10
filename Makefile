.PHONY: clean
all: report/count_report.pdf report/count_report.html report/count_report_files

# count words
results/isles.dat: scripts/wordcount.py data/isles.txt
	python scripts/wordcount.py \
		--input_file=data/isles.txt \
		--output_file=results/isles.dat

results/abyss.dat: scripts/wordcount.py data/abyss.txt
	python scripts/wordcount.py \
		--input_file=data/abyss.txt \
		--output_file=results/abyss.dat

results/last.dat: scripts/wordcount.py data/last.txt
	python scripts/wordcount.py \
		--input_file=data/last.txt \
		--output_file=results/last.dat
		
results/sierra.dat: scripts/wordcount.py data/sierra.txt
	python scripts/wordcount.py \
		--input_file=data/sierra.txt \
		--output_file=results/sierra.dat


# plot counts
results/figure/isles.png: scripts/plotcount.py results/isles.dat
	python scripts/plotcount.py \
	--input_file=results/isles.dat \
	--output_file=results/figure/isles.png

results/figure/abyss.png: scripts/plotcount.py results/abyss.dat
	python scripts/plotcount.py \
		--input_file=results/abyss.dat \
		--output_file=results/figure/abyss.png

results/figure/last.png: scripts/plotcount.py results/last.dat
	python scripts/plotcount.py \
		--input_file=results/last.dat \
		--output_file=results/figure/last.png

results/figure/sierra.png: scripts/plotcount.py results/sierra.dat
	python scripts/plotcount.py \
	--input_file=results/sierra.dat \
	--output_file=results/figure/sierra.png


# render report
report/count_report.pdf report/count_report_files: report/count_report.qmd \
results/figure/isles.png results/figure/abyss.png \
results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd --to pdf

report/count_report.html report/count_report_files: report/count_report.qmd \
results/figure/isles.png results/figure/abyss.png \
results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd --to html

clean: 
	rm -f results/isles.dat
	rm -f results/abyss.dat
	rm -f results/last.dat
	rm -f results/sierra.dat
	rm -f results/figure/isles.png
	rm -f results/figure/abyss.png
	rm -f results/figure/last.png
	rm -f results/figure/sierra.png
	rm -f report/count_report.html
	rm -f report/count_report.pdf
	rm -rf report/count_report_files
