require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do  # ensures that the Rake task has access to the local Rails environment, including the User model
    # reset database
    Rake::Task['db:reset'].invoke

    # create admin account
    admin = User.create!(:name => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)

    # create normal users
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    User.all(:limit => 10).each do |user|
        user.topics.create!(
          :summary => Faker::Lorem.sentence,
          :content => Faker::Lorem.paragraph((3..6).to_a.rand)
        )
    end

    User.all(:limit => 30).each do |user|
      (5..10).to_a.rand.times do
        user.posts.create!(
          :content => Faker::Lorem.paragraph((3..6).to_a.rand),
          :topic_id => Topic.all.rand.id
        )
      end
    end

  end
end
