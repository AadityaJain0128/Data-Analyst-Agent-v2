# Dockerfile

# Use the official Python 3.12 slim image as a base
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# [Optional but good practice] Install build tools needed for some Python packages,
# then clean up apt cache to keep the image small.
RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies from requirements.txt
# --no-cache-dir reduces image size
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code into the container
COPY app.py index.html entrypoint.sh ./

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# Expose the port that the application will run on
# This is documentation; the actual port is set by Railway's $PORT variable
EXPOSE 8000

# Set the command to run the application using the entrypoint script
CMD ["./entrypoint.sh"]