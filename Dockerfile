FROM debian:bullseye-slim
LABEL maintainer "Rich Rose <askrichardrose@gmail.com>"

# Install packages
RUN apt-get update && apt-get install -y \
    curl \
    fontconfig \
    fonts-powerline \
    git \
    tmux \
    vim \
    wget \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/*

# Create user account and home directory
ENV USER_ACCOUNT="lab-dev"
ENV USER_HOME="/home/$USER_ACCOUNT"
ENV USER_SHELL="/bin/bash" 
RUN useradd -ms $USER_SHELL $USER_ACCOUNT

# echo Add Developer Command Line (OhMyBash) ----------------------------------------------------
RUN wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
RUN mkdir -p /usr/share/fonts;mv PowerlineSymbols.otf /usr/share/fonts/
RUN fc-cache -vf
RUN mv 10-powerline-symbols.conf /etc/fonts/conf.d/

# Set environment variables
ENV GIT_NAME="tester"
ENV GIT_EMAIL="tester@gmail.com"
ENV GIT_PASSWORD="xxxxx"
ENV GIT_EDITOR="vim"
ENV GIT_REPO="github.com/CloudVLab/gcp-spl-content.git"
ENV GIT_CMD='https://$GIT_NAME:$GIT_PASSWORD@$GIT_REPO'

# Git configuration
#RUN mkdir -p "/home/$USER_ACCOUNT/.gitconfig"
RUN touch "/home/$USER_ACCOUNT/.gitconfig"

# Set cache timeout in seconds (15m)
RUN git config --global credential.helper 'cache --timeout=900'
RUN git config --global user.name $GIT_NAME 
RUN git config --global user.email $GIT_EMAIL 
RUN git config --global user.password $GIT_PASSWORD
RUN git config --global core.editor $GIT_EDITOR 

# Add package
ADD taskn /usr/local/bin/taskn
ADD ownr /usr/local/bin/ownr
# ADD v2r /usr/local/bin/v2r
ADD claat /usr/local/bin/claat

# Set User Account
USER $USER_ACCOUNT 
WORKDIR $USER_HOME

# Install Oh My Bash
RUN bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
# Replace the theme
RUN sed -i 's/OSH_THEME="font"/OSH_THEME="agnoster"/g' .bashrc
