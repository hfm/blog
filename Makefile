compile: clean
		compass compile scss
		hugo -v
		rm -rf public/tags
		gzip -k9 public/sitemap.xml

clean:
		rm -rf public
