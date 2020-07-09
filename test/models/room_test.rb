require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  test "join_sensor(id) shoud return join between room and its sensor" do
    room_with = Room.join_sensor(1)
    room_without = Room.join_sensor(10)
    assert_equal(room_with.sensor_id, "7XnG6nS2JbcyAKoUfTqHhbSben1f684t")
    assert_nil(room_without.sensor_id)
  end

end
