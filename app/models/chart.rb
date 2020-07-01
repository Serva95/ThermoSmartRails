class Chart < ApplicationRecord

  def self.find_last_temp(previous_temp_time, room_id)
    room = Room.find(room_id)
    last_read = Temp.read_last(room)
    if last_read.created_at.strftime("%T") == previous_temp_time
      nil
    else
      last_read
    end
  end
end
