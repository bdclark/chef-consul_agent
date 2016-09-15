#!/usr/bin/env ruby

require 'open-uri'

versions = %w(0.5.0 0.5.1 0.5.2 0.6.0 0.6.1 0.6.2 0.6.3 0.6.4 0.7.0)

versions.each do |v|
  url = "https://releases.hashicorp.com/consul/#{v}/consul_#{v}_SHA256SUMS"
  open(url) do |u|
    content = u.read
    content.each_line do |line|
      checksum, fname = line.gsub(/\s+/, ' ').strip.split(' ')
      puts "'#{fname}' => '#{checksum}',"
    end
  end
end
