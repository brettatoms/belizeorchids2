all: build

belizeorchids/static/style.css: tailwind.config.js ./belizeorchids/input.css belizeorchids/templates/index.html
	npx tailwindcss -i ./belizeorchids/input.css -o ./belizeorchids/static/style.css --minify
	touch $@ # prevent rebuilding the file if the content didn't change

tailwind.config.js: node_modules

node_modules: package-lock.json
	npm install -D tailwindcss
	touch $@ # update timestamp in case the folder already existed

venv: requirements.txt
	python3 -m venv venv
	pip install -r requirements.txt
	touch $@ # update timestamp in case the folder already existed

build: node_modules venv belizeorchids/static/style.css
	flask digest compile

deploy: build
	gcloud run deploy belizeorchids --source .

.PHONY: all build deploy
