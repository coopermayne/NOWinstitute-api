namespace :images do
  desc "correct image sizes"

  task get_sizes: :environment do
    Upload.all.each do |u|
      if u.is_image
        u.width, u.height = `identify -format "%wx%h" #{u.name.url.sub('https', 'http')}`.split(/x/)
        puts "w: #{u.width}, h: #{u.height}"
        u.save
      end
    end
  end

  task recreate: :environment do
    Upload.all.each do |u|
      if u.name && u.name.file
        puts u.name.recreate_versions!
      else
        puts u.destroy
      end
    end
  end

end
