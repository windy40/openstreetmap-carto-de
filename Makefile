DBSCHEME = "de"

MAPNIK_API = 3.0.32

TEMPFILE := $(shell mktemp -u)

XMLSTYLE := osm-de.xml

all: $(XMLSTYLE) osm-hrb.xml osm-oc.xml

$(XMLSTYLE): *.mss project.mml
ifeq ($(DBSCHEME),upstream)
	cd contrib/use-upstream-database/; ./replace-tablenames.sh
	carto -q -a $(MAPNIK_API) project-mod.mml > $(TEMPFILE)
else
	carto -q -a $(MAPNIK_API) project.mml > $(TEMPFILE)
endif
	mv $(TEMPFILE) $@

project-hrb.mml: project.mml
	sed -e 's/localized_[a-z_]\+/name_hrb/g' project.mml >project-hrb.mml

osm-hrb.xml: *.mss project-hrb.mml
	carto -q -a $(MAPNIK_API) project-hrb.mml > $(TEMPFILE)
	mv $(TEMPFILE) $@

project-oc.mml: project.mml
	sed -e 's/localized_[a-z_]\+/name_fr_oc/g' project.mml >project-oc.mml

osm-oc.xml: *.mss project-oc.mml
	carto -q -a $(MAPNIK_API) project-oc.mml > $(TEMPFILE)
	mv $(TEMPFILE) $@

preview-de.png: $(XMLSTYLE)
	nik2img.py $(XMLSTYLE) -d 850 300 -z 15 -c 11.625 48.106  -fPNG --no-open $@

# This target will render one single tile in every zoomlevel
# to ensure successful merges from upstream
test: test-z03.png test-z04.png test-z05.png test-z06.png test-z07.png test-z08.png test-z09.png \
	test-z10.png test-z11.png test-z12.png test-z13.png test-z14.png test-z15.png test-z16.png \
	test-z17.png test-z18.png test-z19.png test-castle1.png test-castle2.png test-castle3.png\
	test-castle4.png test-camp-caravan.png test-campsite.png test-backcountry.png test-kebab.png \
	test-sport.png test-l10n1.png test-l10n2.png test-foot-cycle-path-track.png \
	test-living-street.png test-proposed.png test-coast1.png test-coast2.png test-lake-ocean.png \
	test-l10n1.png test-l10n2.png test-construction.png test-iata.png

test-z03.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /3/3/2.png

test-z04.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /4/7/4.png

test-z05.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /5/15/10.png
	
test-z06.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /6/33/20.png

test-z07.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /7/66/43.png

test-z08.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /8/133/87.png

test-z09.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /9/267/175.png

test-z10.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /10/612/416.png

test-z11.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /11/1071/703.png

test-z12.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /12/2143/1406.png

test-z13.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /13/4287/2812.png
	
test-z14.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8576/5626.png

test-z15.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /15/17153/11252.png

test-z16.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /16/34306/22505.png

test-z17.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68612/45011.png
	
test-z18.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137225/90022.png
	
test-z19.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/274450/180045.png

# tests for German style only features
# castle
test-castle1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8582/5621.png
# castle (ruined)
test-castle2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8581/5623.png
# castle (like upstream)
test-castle3.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137259/90022.png
# castle (ruined) (like upstream)
test-castle4.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137144/90174.png

# camping/caravaning
test-camp-caravan.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68658/44952.png
# camping tents only
test-campsite.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /18/137346/89837.png
# camping backcountry
test-backcountry.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/274268/181238.png
# Dönerbude
test-kebab.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /19/274475/180053.png
# hospital
test-hospital.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /15/17146/11253.png
# sport pitches
test-sport.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /16/34311/22505.png
# Airports incl. IATA code
test-iata.png: $(XMLSTYLE)
	 ./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /11/1072/694.png
# l10n (country-names)
test-l10n1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /3/5/3.png
# l10n (latin + asian scripts)
test-l10n2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /10/792/483.png
# l10n station (thai + latin)
test-l10n3.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/12777/7562.png

test-foot-cycle-path-track.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68596/45003.png
test-living-street.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68619/45014.png
test-proposed.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /17/68615/45002.png
test-construction.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /15/17090/11446.png

# coastline (using water polygons)
test-coast1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /14/8020/5446.png
test-coast2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /13/4010/2723.png
test-lake-ocean.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -t -s $(XMLSTYLE) -o $@ -u /7/114/25.png

clean:
	rm -f project-de.* $(XMLSTYLE) test-*.png
