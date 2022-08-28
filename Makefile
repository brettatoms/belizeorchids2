all: belizeorchids/templates/index.html

belizeorchids/static/style.css: node_modules tailwind.config.js
	npx tailwindcss -i ./belizeorchids/input.css -o ./belizeorchids/static/style.css --minify

belizeorchids/templates/index.html: belizeorchids/static/style.css

node_modules: package-lock.json
	npm install -D tailwindcss

venv: requirements.txt
	python3 -m venv venv
	pip install -r requirements.txt

.PHONY: all
