module CarrierWave
  module MiniMagick

    def optimize
      manipulate! do |img|
        return img unless img.mime_type.match /image\/jpeg/
        img.strip
        img.combine_options do |c|
          c.quality "82"
          c.depth "8"
          c.interlace "plane"
        end
        img
      end
    end
  end
end
