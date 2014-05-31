require 'csv'
rooms_index = Hash.new
CSV.foreach('visitors.csv') do |row|
	if rooms_index.has_key?(row[1].to_i)
   	 rooms_index[row[1].to_i] << row
	else
  	 rooms_index[row[1].to_i] = [row]
	end
end
 rooms_index = Hash[rooms_index.sort]
 rooms_index.each do |room, persons_visited|
 
   visitors_of_a_room = []
   time_spent = 0

 persons_visited.each do |visitor|
   if !(visitors_of_a_room.include?(visitor[0].to_i))
    visitors_of_a_room << visitor[0].to_i
   end
  end
  visitors_of_a_room.each do |visitor|
    visitor_time_in = 0
    visitor_time_out = 0
   persons_visited.each do |visit|
    if (visit[0].to_i == visitor) && (visit[2] == ' I')
    	visitor_time_in = visit[3].to_i
    elsif (visit[0].to_i == visitor) && (visit[2] == ' O')
        visitor_time_out = visit[3].to_i
        break
    end
   end
    time_spent +=  (visitor_time_out - visitor_time_in)
  end
    p  "Room: "+ room.to_s +
       ", No.of visitors: "+ visitors_of_a_room.count.to_s + 
       ", Average time: " + ((time_spent+1)/visitors_of_a_room.count).to_s 
  time_spent = 0
 end


