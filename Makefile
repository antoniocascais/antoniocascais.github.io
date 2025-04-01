run:
	docker run --rm \
		-v "$(PWD):/srv/jekyll" \
		-p 4000:4000 \
		jekyll/jekyll:latest \
		bash -c "bundle install && jekyll serve --watch --drafts --host 0.0.0.0"

