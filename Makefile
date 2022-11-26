DBSCHEME = "de"

MAPNIK_API = 3.0.15

TEMPFILE := $(shell mktemp -u)

XMLSTYLE := osm.xml

all: $(XMLSTYLE)

project.mml: project.mml.d/*
	./scripts/concat-split-project.mml.py > $@	

$(XMLSTYLE): style/*.mss project.mml
ifeq ($(DBSCHEME),upstream)
	cd contrib/use-upstream-database/; ./replace-tablenames.sh
	carto -a $(MAPNIK_API) project-mod.mml > $(TEMPFILE)
else
	carto -a $(MAPNIK_API) project.mml > $(TEMPFILE)
endif
	mv $(TEMPFILE) $@

country_languages/country_languages.data:
	grep -v \# country_languages/country_languages.data.in >country_languages/country_languages.data

# This target will render one single tile in every zoomlevel
# to ensure successful merges from upstream
test: test-l10n1.png test-l10n2.png test-l10n3.png test-l10n4.png

test-l10n4.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /10/612/416.png

test-l10n1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /3/5/3.png

test-l10n2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/792/483.png

test-l10n3.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/12777/7562.png

clean:
	rm -f project-de.* $(XMLSTYLE) test-*.png
