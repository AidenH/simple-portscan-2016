require 'socket'

def scan( ip, port, max_port )
  sock = Socket.new( :INET, :STREAM )
  file = File.new( "Result of scan - #{ip}.txt", "w")
  open_ports = []

  # Get host name
  host = Socket.getnameinfo(Socket.sockaddr_in( nil, ip )).first
  file.puts "HOST: #{host}\r\n"
  puts "HOST: #{host}\r\n"

  # Start scan
  for x in port..max_port
    raw = Socket.sockaddr_in( x, ip )

    begin
      connect = sock.connect(raw)
    rescue
    end

    if connect
      file.puts "\r\n #{x} - OPEN"
      puts "\r\n #{x} - OPEN"

      port_type = Socket.getnameinfo(Socket.sockaddr_in( x, ip )).last
      puts port_type; file.puts port_type
      open_ports.push "#{x} - #{port_type} " if port_type.to_i == 0
    end

    puts "#{x} Closed" if !connect

  end

  # Write results to terminal and file
  puts open_ports; file.puts open_ports
  file.close

end

scan( ARGV[0], ARGV[1], ARGV[2] )
