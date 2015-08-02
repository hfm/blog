compile: clean
		compass compile scss
		hugo
		rm -rf public/tags
		gzip -k9 public/sitemap.xml

clean:
		rm -rf public
