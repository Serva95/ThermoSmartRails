class Chart < ApplicationRecord

  def self.find_last_temp(previous_temp_time, sensor_id)
    last_read = Temp.read_last(sensor_id)
    if last_read.created_at.strftime("%T") == previous_temp_time
      nil
    else
      last_read
    end
  end

end
