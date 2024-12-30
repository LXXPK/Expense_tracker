# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app/

# Install system dependencies (example for PostgreSQL support)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Set environment variables for Django (e.g., disabling the debug mode for production)
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=ExpenseTracker.settings

# Run the Django application (you can use `python manage.py runserver` for development)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
