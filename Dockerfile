# Dockerfile
FROM python:3.10-slim

# Install system dependencies for dlib & face_recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-all-dev \
    libssl-dev \
    git \
    && apt-get clean

# Set work directory
WORKDIR /app

# Copy all project files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose the application port
EXPOSE 8000

# Start the Django app with Gunicorn
CMD ["gunicorn", "face_login_project.wsgi:application", "--bind", "0.0.0.0:8000"]
