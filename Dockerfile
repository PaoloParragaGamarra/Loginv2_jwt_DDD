# Use the official Flutter image as base
FROM ubuntu:22.04

# Add labels for better identification
LABEL maintainer="Login_JWT_DDD"
LABEL description="Flutter web application with JWT authentication"
LABEL version="1.0"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_HOME=/flutter
ENV PATH=$FLUTTER_HOME/bin:$PATH

# Install dependencies
RUN apt-get clean && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-11-jdk \
    wget \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME
RUN flutter channel stable
RUN flutter upgrade
RUN flutter doctor

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Expose port 3000
EXPOSE 3000

# Command to run when container starts
CMD ["flutter", "run", "-d", "web", "--web-port", "3000"] 