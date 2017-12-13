# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  storage :fog

  def store_dir
    "uploads/#{model.id}"
  end

  process :resize_to_limit => [2000, 1500], :if => :image?
  process :store_dimensions
  process :optimize, :if => :image?
  process :get_color, :if => :image?
  process :save_content_type_and_size_in_model


  version :mobile, :if => :image? do
    process :resize_to_limit => [500, 10000]
    process :optimize
  end

  version :thumb, :if => :image? do
    process :resize_to_limit => [10000, 200]
    process :optimize
  end

  version :index, :if => :image? do
    process :resize_to_fill => [250, 204]
    process :optimize
  end

  version :pixel, :if => :image? do
    process :resize_to_fill => [4, 4]
    process :optimize
  end

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def save_content_type_and_size_in_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
  end

  def get_color
  end

  private

  def store_dimensions
    if file && model
      model.width, model.height = `identify -format "%wx%h" #{file.path}`.split(/x/)
    end
  end

end
