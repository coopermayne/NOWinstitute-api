namespace :images do
  desc "correct image sizes"
  task get_sizes: :environment do
    Upload.all.each do |u|
      if u.is_image
        u.width, u.height = `identify -format "%wx%h" #{u.name.url}`.split(/x/)
        puts "w: #{u.width}, h: #{u.height}"
        u.save
      end
    end
  end
end
