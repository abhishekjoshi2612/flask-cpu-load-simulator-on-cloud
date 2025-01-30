# Stage 1: Builder
FROM python:3.11 AS builder
ENV PYTHONUNBUFFERED=1
WORKDIR /app

# Install build dependencies
RUN pip install --upgrade pip setuptools wheel

# Copy dependency list
COPY requirements.txt /wheels/requirements.txt 

# Build wheels
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r /wheels/requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim AS runtime
WORKDIR /app

# Install necessary utilities
RUN apt-get update && apt-get install -y busybox curl && rm -rf /var/lib/apt/lists/*

# Copy prebuilt wheels & requirements.txt
COPY --from=builder /wheels /wheels 

# Install dependencies from wheels
RUN pip install --no-cache-dir --find-links=/wheels -r /wheels/requirements.txt

# Copy application code
COPY main.py .

# Expose the port the app runs on
EXPOSE 80

# Define the command to run the application with Gunicorn
CMD ["gunicorn", "-w", "3", "-b", "0.0.0.0:80", "main:app"]
