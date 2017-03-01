# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.id}"
  end

  process :resize_to_limit => [1600, 1200], :if => :image?
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
    process :resize_to_fill => [250, 280]
    process :optimize
  end

  version :pixel, :if => :image? do
    process :resize_to_limit => [10, 10]
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

end
