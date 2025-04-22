# Use official Python image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies for dlib and face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    python3-dev \
    git \
    && apt-get clean

# Create app directory
WORKDIR /app

# Copy project files
COPY . /app/

# Install Python packages
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Collect static files (if needed)
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Start the Django server
CMD ["gunicorn", "projectname.wsgi:application", "--bind", "0.0.0.0:8000"]
