build tag="latest":
	docker build -t pmmp/dyncmdlist:latest .
	test {{tag}} == latest || docker build -t pmmp/dyncmdlist:{{tag}} .
poggit plugin_name:
	wget -O test/plugin.phar https://poggit.pmmp.io/get/{{plugin_name}}?prerelease=on
	docker run --rm -it -e SHOW_STDOUT=1 -v $PWD/test:/input pmmp/dyncmdlist ./wrapper.sh {{plugin_name}}
pogrsr plugin_name rid:
	wget -O test/plugin.phar https://poggit.pmmp.io/r/{{rid}}
	docker run --rm -it -e SHOW_STDOUT=1 -v $PWD/test:/input pmmp/dyncmdlist ./wrapper.sh {{plugin_name}}
run plugin_name:
	docker run --rm -it -e SHOW_STDOUT=1 -v $PWD/test:/input pmmp/dyncmdlist ./wrapper.sh {{plugin_name}}
