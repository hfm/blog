compile: clean
		compass compile scss
		hugo
		gzip -k9 public/sitemap.xml

clean:
		rm -rf public
