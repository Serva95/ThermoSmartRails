require 'test_helper'

class TempTest < ActiveSupport::TestCase

  test "#find_last_temp(previous_temp_time, sensor_id) should return last temp if different from passed" do
    c1 = Temp.update_chart_temp("17:00:00", "7XnG6nS2JbcyAKoUfTqHhbSben1f684t")
    c2 = temps(:last_temp)
    assert_equal(c2, c1)
  end

  test "find_room_temps(sensor_id) should return last 100 temps of room" do
    t1 = temps(:last_temp)
    t2 = temps(:previous_temp)
    t3 = temps(:one)
    t4 = temps(:two)
    tx = temps(:other_sensor_one)
    result = Temp.find_room_temps("7XnG6nS2JbcyAKoUfTqHhbSben1f684t")
    assert_includes(result, t1)
    assert_includes(result, t2)
    assert_includes(result, t3)
    assert_includes(result, t4)
    assert_not_includes(result, tx)
  end

  test "get_medium_temps(sensor_id, days) should return the avg value of temps for every day" do
    avg = Temp.get_medium_temps("7XnG6nS2JbcyAKoUfTqHhbSben1f684t", "7")
    assert_equal(avg[0].temp, 22)
  end

  test "read_last(sensor_id) should return last temp from the sensor" do
    last_read = Temp.read_last("7XnG6nS2JbcyAKoUfTqHhbSben1f684t")
    t1 = temps(:last_temp)
    assert_equal(last_read, t1)
  end

  test "last_temp_of_rooms(rooms) should return last temp of all rooms in the system" do
    rooms = Room.all
    reads = Temp.last_temp_of_rooms(rooms)
    t1 = temps(:last_temp)
    t2 = temps(:other_sensor_one)
    assert_equal(reads.fetch("7XnG6nS2JbcyAKoUfTqHhbSben1f684t")[0], t1.temp)
    assert_equal(reads.fetch("RKVPmgyGfQU43UTFBuguyubG0cbKKaA9")[0], t2.temp)
    assert_equal(reads.length , 2)
  end

end
