require 'test_helper'

class OrariOnOffTest < ActiveSupport::TestCase

  test "find_orari(room_id, giorno) shoud return room's orari" do
    o1 = orari_on_offs(:one)
    o2 = orari_on_offs(:one_a)
    o3 = orari_on_offs(:one_b)
    ox = orari_on_offs(:two)
    orari = OrariOnOff.find_orari(1, 0)
    assert_includes(orari, o1)
    assert_includes(orari, o2)
    assert_includes(orari, o3)
    assert_not_includes(orari, ox)
  end

  #params = '<ActionController::Parameters {"0"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>, "1"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>, "2"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>, "3"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>, "4"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>, "5"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>, "6"=><ActionController::Parameters {"timeonuno"=>"06:30", "timeoffuno"=>"08:30", "timeondue"=>"", "timeoffdue"=>"", "timeontre"=>"", "timeofftre"=>""} permitted: false>} permitted: false>'

  test  "save_all(orari, room_id) shoud save in db all orari passed as an array" do
    orari = [%w[06:30 08:30], %w[06:30 08:30], %w[06:30 08:30], %w[06:30 08:30], %w[06:30 08:30], %w[06:30 08:30], %w[06:30 08:30]]
    result = OrariOnOff.save_all(orari, 2)
    assert(result)
  end

end
