NAME:=cge-article
ALL_OUTPUT:=$(NAME).html $(NAME).pdf $(NAME).xml
TEST_BROWSER:=x-www-browser

.PHONY: default
default: $(NAME).html

.PHONY: all
all: $(ALL_OUTPUT)

$(NAME).html: $(NAME).adoc
	asciidoctor $< -o $@
#	$(TEST_BROWSER) $@ &

$(NAME).xml: $(NAME).adoc
	asciidoctor -b docbook5 $< -o $@
#	yelp $@

$(NAME).pdf: $(NAME).xml
	fopub $(NAME).xml

.PHONY: pdf
pdf: $(NAME).pdf

# $(NAME).pdf: $(NAME).adoc
# 	asciidoctor-pdf $(NAME).adoc

.PHONY: clean
clean:
	rm -f $(ALL_OUTPUT)

SSH_TARGET:=michalis@ssh.castle-engine.io
SCP_TARGET:=$(SSH_TARGET):/home/michalis/cge-html/blaise-pascal-article/
HTML_BASE:=https://castle-engine.io/

.PHONY: upload
upload: clean all
	scp -r images/ $(NAME).html $(NAME).pdf $(SCP_TARGET)
	$(TEST_BROWSER) $(HTML_BASE)blaise-pascal-article/$(NAME).html &
	$(TEST_BROWSER) $(HTML_BASE)blaise-pascal-article/$(NAME).pdf &

.PHONY: zip-with-src
zip-with-src: clean all
	rm -Rf blaise-pascal-article-castle-game-engine blaise-pascal-article-castle-game-engine.zip
	mkdir -p blaise-pascal-article-castle-game-engine \
	         blaise-pascal-article-castle-game-engine/output \
		 blaise-pascal-article-castle-game-engine/sources
	cp -R cge-article.adoc images/ code-samples/   blaise-pascal-article-castle-game-engine/sources/
	cp -R cge-article.html cge-article.pdf images/ blaise-pascal-article-castle-game-engine/output/
	find blaise-pascal-article-castle-game-engine -name '*~' -execdir rm -f '{}' ';'
	zip -r blaise-pascal-article-castle-game-engine.zip blaise-pascal-article-castle-game-engine
