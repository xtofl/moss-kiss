all: site

_site:
	mkdir -p $@

_docker_builder: build-image/Dockerfile
	docker build build-image -t moss-kiss/builder
	touch $@

site: _docker_builder |  _site
	docker run --rm \
		-v .:/moss-kiss -w /moss-kiss \
		moss-kiss/builder \
		\
		jekyll build \
		-V \
		--incremental \
		--source docs

server:
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