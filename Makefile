all: belizeorchids/templates/index.html belizeorchids/static/style.css

belizeorchids/static/style.css: node_modules tailwind.config.js ./belizeorchids/input.css belizeorchids/templates/index.html
	npx tailwindcss -i ./belizeorchids/input.css -o ./belizeorchids/static/style.css --minify

node_modules: package-lock.json
	npm install -D tailwindcss

venv: requirements.txt
	python3 -m venv venv
	pip install -r requirements.txt

.PHONY: all
