class GenerateSeed
  @@users = User.ransack(email_cont: "test").result

  def self.exec(cls)
    cls.generate_seed
  end
  %w[users].each do |inst|
    eval("def self.#{inst}
      @@#{inst}
    end
    ")
  end

  User.instance_eval do
    def generate_seed
      puts "generate user"

      user_pool_user = [
        { uid: "9093a0a5-dce1-4e53-9b3d-f91f00abadc8", email: "test01@test.com" },
        { uid: "e06f5deb-a0b4-46f6-bb5b-678e9e5773d1", email: "test02@test.com" },
        { uid: "ff8cb4e7-9c16-402c-bdf0-5932161165bf", email: "test03@test.com" },
        { uid: "9980cc0d-1220-48ac-ba3f-7414d2a8cc2d", email: "test04@test.com" },
        { uid: "008bbb85-3df9-44d2-8644-2b2144ca95cb", email: "test05@test.com" }
      ]
      # image_service = StorageService.new

      user_pool_user.each do |v|
        uuid, email = v.values
        # image = image_service.put_image("#{Rails.root}/public/photos/user#{rand(1..3)}.jpg")
        object_hash = {
          uid: uuid,
          email: email,
          name: "#{Faker::Name.last_name}#{Faker::Name.first_name}",
          phone: "010-#{rand(1000..9999)}-#{rand(1000..9999)}",
          gender: [1, 2].sample,
          description: Faker::Lorem.sentence(word_count: 100),
        }
        User.create!(object_hash)
      rescue StandardError => e
        p e
      end
      @@users = User.ransack(email_cont: "test").result
    end
  end

  TimeList.instance_eval do
    def generate_seed
      puts "generate time_list"
      10.times.each do |v|
        hour = 10 + v
  
        2.times.each do |v2|
          start_minute = v2 === 0 ? "00" : "30"
          start_at = "#{hour}:#{start_minute}"
  
          end_minute = v2 === 0 ? "29" : "59"  
          end_at = "#{hour}:#{end_minute}"
  
          TimeList.create(start_at: start_at, end_at: end_at)
        end        
      end
    end
  end
end
