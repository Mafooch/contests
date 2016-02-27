class Point
  attr_accessor :longitude, :latitude

  def initialize longitude, latitude
    @longitude = longitude
    @latitude = latitude
  end

  def mongoize
    geo_json_hash = { type: "Point", coordinates: [@longitude, @latitude] }
  end

  def self.demongoize geo_json_hash
    Point.new geo_json_hash[:coordinates][0], geo_json_hash[:coordinates][1]
  end

  def self.mongoize object
    case object
    when Point then object.mongoize
    when Hash
      if object[:type] #in GeoJSON Point format
        Point.new(object[:coordinates][0], object[:coordinates][1]).mongoize
      else # in legacy format
        Point.new(object[:lng], object[:lat]).mongoize
      end
    else
      object
    end
  end

  def self.evolve params
    case params
    when Point
      geo_json_hash = { type: "Point", coordinates: [params.longitude, params.latitude] }
    when Hash
      params
    end
  end
end
