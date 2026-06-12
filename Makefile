all: site

_site:
	mkdir -p $@

_docker_builder: build-image/Dockerfile
	docker build build-image -t moss-kiss/builder
	touch $@

site: _docker_builder web-images |  _site
	docker run --rm \
		-v .:/moss-kiss -w /moss-kiss \
		moss-kiss/builder \
		\
		jekyll build \
		-V \
		--incremental \
		--source docs


server: web-images
	docker run --rm \
		-p 4000:4000 \
		-v .:/moss-kiss -w /moss-kiss \
		moss-kiss/builder \
		\
		jekyll serve \
		--source docs 

clean:
	-rm _docker_builder
	-rm -rf _output

## Conveniences to scale down web images
IMAGE_SOURCES = $(filter-out %.web.jpg,$(wildcard docs/**/*.jpg))
WEB_IMAGES = $(addsuffix .web.jpg,$(basename ${IMAGE_SOURCES}))
web-images: ${WEB_IMAGES}
web-images-clean:
	-rm ${WEB_IMAGES}
%.web.jpg: %.jpg
	# https://stackoverflow.com/a/7262050
	convert  $< -auto-orient -strip -interlace Plane -gaussian-blur 0.05 -quality 50% $@
