.PHONY: build watch run clean

build:
	mkdir -p output
	cp src/qrcode*.png output/
	pandoc src/content.md -o output/index.html \
	      --template=templates/base.html \
	      --css=templates/style.css
	cp templates/style.css output/

watch:
	# Linux: Use inotifywait
	while true; do \
	    inotifywait -r -e modify src/ templates/ && make build; \
	done

	# macOS: Use fswatch (install via `brew install fswatch`)
	# fswatch -o src/ templates/ | while read; do make build; done

run:
	python3 -m http.server --directory output 7777

clean:
	rm -rf output/*
