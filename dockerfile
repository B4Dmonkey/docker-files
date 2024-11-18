# Use an official Debian as a parent image
FROM debian:latest

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y \
    zsh \
    wget \
    git \
    curl \
    && apt-get clean

# Set Zsh as the default shell
RUN chsh -s /bin/zsh

# Install Oh My Zsh
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --unattended

# Install Starship
RUN curl -sS https://starship.rs/install.sh | sh

# Copy custom .zshrc if needed
COPY .zshrc /root/.zshrc

# Add Starship initialization to .zshrc
RUN echo 'eval "$(starship init zsh)"' >> /root/.zshrc

# Create .config directory and copy starship.toml
RUN mkdir -p /root/.config
COPY starship.toml /root/.config/starship.toml

# Set the working directory
WORKDIR /root

# Start Zsh shell
CMD ["zsh"]