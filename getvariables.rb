#!/usr/bin/ruby
require 'net/https'
require 'json'


uri = URI.parse("https://raw.githubusercontent.com/powdahound/ec2instances.info/master/www/instances.json")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Get.new(uri.request_uri)
res = http.request(request)
ami_types = Hash[JSON.parse(http.request(request).body).map { |tuple| [tuple['instance_type'], tuple['linux_virtualization_types']] }]

output = {
 "variable" => {
    "prefer_pv" => {
      "default" => Hash[ami_types.map { |k, v| [k, v.include?('PV') ? 'pv' : 'hvm'] }]
    },
    "prefer_hvm" => {
      "default" => Hash[ami_types.map { |k, v| [k, v.include?('HVM') ? 'hvm' : 'pv'] }]
    }
  }
}

File.open('variables.tf.json.new', 'w') { |f| f.puts JSON.pretty_generate(output) }
File.rename 'variables.tf.json.new', 'variables.tf.json'

