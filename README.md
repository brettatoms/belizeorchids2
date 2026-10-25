# Belize Orchids

### Install tools

The project uses [mise](https://mise.jdx.dev) to install uv and flyctl and to set `FLASK_APP`.

```sh
mise install
```

### Install dependencies

```sh
uv sync
```

### Start server

```sh
uv run gunicorn belizeorchids.app:app
```

### Build

```sh
make
```

### Deploy

The site runs on [Fly.io](https://fly.io) as the `belizeorchids` app.

```sh
make deploy
```
