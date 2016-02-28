class Entrant
  include Mongoid::Document
  field :_id, type: Integer
  field :name, type: String
  field :group, type: String
  field :secs, type: Float
  belongs_to :racer
  embedded_in :contest # m:1, annotated, embedded relationship

  validates_associated :racer

  before_create do |entrant|
    entrant.name = "#{racer.last_name}, #{racer.first_name}"
    # entrants never change racer instances and racer names rarely change
    # we will need this name for contest race results
  end
end
