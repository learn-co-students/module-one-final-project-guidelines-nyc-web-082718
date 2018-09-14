def moves
  sleep 1
  puts "Choose your attack! (1-3)"
  puts "1. Punch"
  puts "2. Kick"
  puts "3. Takedown"
  action_capture = []
  action = gets.chomp.to_i

  if action_capture.empty?
    action_capture << action
    action_capture[0]
  end

end
