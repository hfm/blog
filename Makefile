content: clean scss
	hugo -v
	rm -rf public/tags
	gzip -k9 public/sitemap.xml

scss:
	rm -f static/css/style.css
	compass compile scss

clean:
	rm -rf public

.PHONY: scss content clean
