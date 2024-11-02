FROM python:3.12-slim AS builder

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Copy the application into the container.
COPY . .

# Install the application dependencies.
RUN uv sync --frozen --no-cache

FROM python:3.12-slim AS runner

ARG VERSION

WORKDIR /app

COPY --from=builder /app ./

ENV PYTHON_ENV=production
ENV VERSION=$VERSION

EXPOSE 80

# Run the application.
ENTRYPOINT ["/app/.venv/bin/fastapi", "run", "app/main.py", "--port", "80", "--host", "0.0.0.0"]