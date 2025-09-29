FROM ruby:3.4.6

WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Starship
RUN curl -sS https://starship.rs/install.sh | FORCE=1 sh
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc
