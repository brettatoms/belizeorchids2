all: build

.venv: uv.lock
	uv sync
	touch $@ # update timestamp in case the folder already existed

build: .venv
	uv run flask digest compile

deploy:
	fly deploy --ha=false

.PHONY: all build deploy
