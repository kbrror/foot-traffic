require 'csv'
class Parsecsv
	def parse_file(file_path)
		rooms_sorted = Hash.new
		statistics_info = []
		time_spent_in_room = 0
	  rooms_sorted = get_rooms_sorted(file_path)	
		# iterate over every room
		rooms_sorted.each do |room, persons_visited|
		  visitors_of_a_room = []
		  visitors_of_a_room = visitors_of_a_room(persons_visited)
		  time_spent_in_room = get_time_spent(visitors_of_a_room, persons_visited)
		  statistics_info <<  ("Room: "+ room.to_s +
		       ", No.of visitors: "+ visitors_of_a_room.count.to_s + 
		       ", Average time: " + ((time_spent_in_room+1)/visitors_of_a_room.count).to_s )
		end
		puts statistics_info
		end

   def get_time_spent(visitors_of_a_room, persons_visited)
   	visitors = visitors_of_a_room
   	persons = persons_visited
   	time_spent = 0 
   	visitors.each do |visitor|
		    visitor_time_in = 0
		    visitor_time_out = 0
		   persons.each do |visit|
		    if (visit[0].to_i == visitor) && (visit[2] == ' I')
		    	visitor_time_in = visit[3].to_i
		    elsif (visit[0].to_i == visitor) && (visit[2] == ' O')
		        visitor_time_out = visit[3].to_i
		        break
		    end
		   end
		    time_spent +=  (visitor_time_out - visitor_time_in)
		  end
		  return time_spent
   end
  # collect data in the order of rooms available 
	def get_rooms_sorted(file_path)
 		rooms_index = Hash.new
 		CSV.foreach(file_path) do |row|
			if rooms_index.has_key?(row[1].to_i)
		   	 rooms_index[row[1].to_i] << row
			else
		  	 rooms_index[row[1].to_i] = [row]
			end
		end
		return Hash[rooms_index.sort]
	end

	def visitors_of_a_room(persons_visited)
		visitors_of_a_room = []
		persons_visited.each do |visitor|
		  if !(visitors_of_a_room.include?(visitor[0].to_i))
		    visitors_of_a_room << visitor[0].to_i
		  end
		end
		visitors_of_a_room
	end
end


puts "Enter file name along with path"
file_path = gets.chomp
Parsecsv.new.parse_file(file_path)
  
