run:
	R --no-save -e "shiny::runApp('resale', host='0.0.0.0', port=3838)"

docker:
	docker run --rm -p 3839:3839 --user shiny -d shiny/resaledocker run --rm -p 3839:3839 --user shiny -d shiny/resale
