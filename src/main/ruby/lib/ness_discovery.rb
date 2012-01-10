#require 'java'
require 'open-uri'
#java_import 'java.util.Properties'

class NessDiscovery

  def initialize(environment = "production", preload_servers = true)
    @config_url = "https://depot.trumpet.io/config/%s/config.properties"
    @service_port = 8090
    @environment = environment
    if preload_servers
      load_disco_servers(environment)
    end
  end

  def load_disco_servers(environment = "production")
    environment.downcase!
    puts sprintf "Loading %s discovery servers", environment
    address = sprintf(@config_url, environment)
    file = open(address, :http_basic_authentication => ["config", "verysecret"])
    servers = []
    file.each_line {|line|
      if line.start_with? "ness.zookeeper.server"
        servers.push line.split("=")[1].split(":")[0] + ":" + @service_port.to_s
      end
    }

    puts "Found disco servers: " + servers.join(", ")
    @disco_servers = servers
  end

  def convert_service_uri(uri)
    if @disco_servers.nil?
      load_disco_servers
    end

    disco = @disco_servers.at(rand(@disco_servers.size))
    puts "Using disco server: " + disco

    file = open sprintf("http://%s/convert?uri=%s", disco, uri)
    file.readline
  end

  def make_service_call(uri)
    JSON.parse(open(uri).readlines.join " ")
  end

  def make_dummy_service_call(uri)
    JSON.parse("{\"00000000-000d-cefb-c000-000000026810\":{\"id\":\"00000000-000d-cefb-c000-000000026810\",\"sourceId\":\"TRUMPET:904955\",\"name\":\"Steven Schlansker\",\"photoUrl\":\"https://graph.facebook.com/1044030131/picture\",\"createdDate\":1311022200738,\"modificationDate\":1323310377379,\"attributes\":[\"EMPLOYEE\"],\"metadata\":{\"OAUTH_TOKEN\":\"1|904955|48a8d5d93e074a8c03c721d4ccbcd44f\",\"UDID\":\"3a094c113173e201a4bc9ee0be60fa061d700b6f\"}}}")
  end

end
