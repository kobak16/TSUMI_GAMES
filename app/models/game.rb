class Game < ApplicationRecord
  belongs_to :user
  has_many :likes

  validates :title, presence: true
  validates :genre, presence: true
  validates :machine, presence: true

  enum genre: {
    "-----": 0,
    action: 1,
    adventure: 2,
    arcade: 3,
    simulation: 4,
    shooting: 5,
    puzzle: 6,
    rpg: 7,
    love: 8,
    another: 9
  }, _prefix: true

  enum machine: {
    "-----": 0,
    switch: 1,
    thr_ds: 2,
    ds: 3,
    wiiu: 4,
    wii: 5,
    gc: 6,
    n64: 7,
    gb_gba: 8,
    fc_sfc: 9,
    ps5: 10,
    ps4: 11,
    ps3: 12,
    ps2: 13,
    ps: 14,
    ps_vita: 15,
    psp: 16,
    xbox_sx: 17,
    xbox_one: 18,
    xbox_360: 19,
    xbox: 20,
    pc: 21,
    another: 22
  }, _prefix: true

end
