CarrierWave.configure do |config|

  config.fog_credentials = {
    :provider                   =>"AWS" ,
    :aws_access_key_id          =>ENV["aws_access_key_id"],
    :aws_secret_access_key      =>ENV["aws_secret_access_key"],
    :region                     =>ENV["bucket_region"]
  }
  config.fog_directory = ENV["bucket_name"]

  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}"}

end
