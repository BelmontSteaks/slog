# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.12.2-slim-bookworm

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
ARG MYENV
ENV MYENV=${MYENV}

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# # Set environment variables
ENV APP_MODULE=slog.main:app

RUN python -m pip install --upgrade pip
RUN python -m pip install hatch

# Install Python app
COPY pyproject.toml README.md /app/
COPY slog /app/slog
COPY hatch_run.sh /app/slog/
WORKDIR /app/slog


EXPOSE 8080

# Install Hatch environment
RUN hatch env prune

# Creates a non-root user and adds permission to access the /app folder
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

ENTRYPOINT ["./hatch_run.sh"]
