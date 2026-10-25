FROM python:3.14-slim

COPY --from=ghcr.io/astral-sh/uv:0.13.5 /uv /bin/uv

WORKDIR /app

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PYTHON_DOWNLOADS=never \
    PATH="/app/.venv/bin:$PATH" \
    FLASK_APP=belizeorchids.app

COPY pyproject.toml uv.lock .python-version ./
RUN uv sync --frozen --no-dev

COPY belizeorchids belizeorchids
RUN flask digest compile

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "belizeorchids.app:app"]
