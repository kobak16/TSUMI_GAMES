class Game < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :genre, presence: true
  validates :machine, presence: true
  validates :rate, presence: false
  validates :comment, presence: false, length: { maximum:50 }

  enum genre: {
    action: 0,
    adventure: 1,
    arcade: 2,
    simulation: 3,
    shooting: 4,
    puzzle: 5,
    rpg: 6,
    love: 7,
    sports: 8,
    another: 9
  }, _prefix: true

  enum machine: {
    switch: 0,
    thr_ds: 1,
    ds: 2,
    wiiu: 3,
    wii: 4,
    gc: 5,
    n64: 6,
    gb_gba: 7,
    fc_sfc: 8,
    ps5: 9,
    ps4: 10,
    ps3: 11,
    ps2: 12,
    ps: 13,
    ps_vita: 14,
    psp: 15,
    xbox_sx: 16,
    xbox_one: 17,
    xbox_360: 18,
    xbox: 19,
    pc: 20,
    another: 21
  }, _prefix: true

  
end
