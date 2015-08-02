compile: clean
		hugo
		gzip -k9 public/sitemap.xml

clean:
		rm -rf public
