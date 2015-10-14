# Dockerfile for a Rails application using Nginx and Unicorn

# Select ubuntu as the base image
FROM ubuntu

# Install duild-essential, nodejs and curl
RUN apt-get update -q
RUN apt-get install -qy build-essential
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN apt-get install -qy git

# Install rvm, ruby, bundler
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN type rbenv
RUN /bin/bash -l -c "rbenv install 2.2.2"
RUN /bin/bash -l -c "rbenv global 2.2.2"

# set WORKDIR
WORKDIR /rails

# bundle install
RUN /bin/bash -l -c "bundle install"

# Publish port 80
EXPOSE 80

# Startup commands
ENTRYPOINT /rails/bin/rails server -b 0.0.0.0
