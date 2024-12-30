# Use the official Python image from Docker Hub
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt /app/

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code into the container
COPY . /app/

# Expose the port that Django will run on
EXPOSE 8000

# Set environment variables for Django (optional, adjust for your environment)
ENV PYTHONUNBUFFERED=1

# Run the Django development server (adjust for production if needed)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
