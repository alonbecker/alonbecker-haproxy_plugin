class MCollective::Application::Haproxy<MCollective::Application
  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift
    else
      docs
    end
  end

  def docs
    puts "Usage: #{$0} [enable|maintenance|status]"
  end

  def main
    mc = rpcclient("haproxy", :chomp => true)
    mc.send(configuration[:command]).each do |resp|
      puts "#{resp[:sender]}:"
    end
    mc.disconnect
    printrpcstats
  end
end