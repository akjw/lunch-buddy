class Appointment < ApplicationRecord
  belongs_to :user

  has_many :appt_locations, dependent: :destroy
  has_many :locations, through: :appt_locations, dependent: :destroy

  def location_selects
    locations.join(", ")
  end

  def location_selects=(locations_string)
    no_empty_string = locations_string.reject { |l| l.empty? }
    location_parse = no_empty_string.collect{|s| s.strip.downcase}.uniq
    new_or_found_locations = location_parse.collect { |name| Location.find_or_create_by(name: name) }
    self.locations += new_or_found_locations
  end

  def location_list
    locations.join(", ")
  end

  def location_list=(locations_string)
    location_names = locations_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_locations = location_names.collect { |name| Location.find_or_create_by(name: name) }
    self.locations += new_or_found_locations
  end

end
