require 'test_helper'

class SensorTest < ActiveSupport::TestCase

  test "not_ass_sensors_plus_actual(actual_sensor_id) shoud return not associated sensors plus actual sensor" do
    sensor_list = Sensor.not_ass_sensors_plus_actual("7XnG6nS2JbcyAKoUfTqHhbSben1f684t")
    s1 = sensors(:one)
    s2 = sensors(:not_associated_with_room)
    sx = sensors(:two)
    assert_includes(sensor_list, s1)
    assert_includes(sensor_list, s2)
    assert_not_includes(sensor_list, sx)
  end

  test "find_not_associated_sensors shoud return not associated sensors" do
    sensor_list = Sensor.find_not_associated_sensors
    s1 = sensors(:not_associated_with_room)
    sx = sensors(:two)
    sy = sensors(:one)
    assert_includes(sensor_list, s1)
    assert_not_includes(sensor_list, sx)
    assert_not_includes(sensor_list, sy)
  end

end
