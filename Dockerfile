FROM rlister/ruby:2.1.5
MAINTAINER Ric Lister, ric@spreecommerce.com

## bundle deps for nokogiri and github gems
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    libxslt-dev libxml2-dev \
    git

## help docker cache bundle
WORKDIR /tmp
ADD ./Gemfile /tmp/
ADD ./Gemfile.lock /tmp/
RUN bundle install
RUN rm -f /tmp/Gemfile /tmp/Gemfile.lock

WORKDIR /app
ADD ./ /app

EXPOSE 5000

ENTRYPOINT [ "bundle", "exec" ]
CMD [ "unicorn", "-c", "./config/unicorn.rb", "-p", "5000" ]
