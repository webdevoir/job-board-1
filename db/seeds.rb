# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Tags

tags = [
  :development,
  :marketing,
  :design,
  :teaching,
  :writing,
  :devops
]

tags.each do |tag|
  Tag.create(
    name: tag,
    original: true
  )
end

if Rails.env.development?

  # Companies

  20.times do
    Company.create(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      url: Faker::Internet.url
    )
  end

  companies = Company.all

  # Jobs

  20.times do
    Job.create(
      name: Faker::Job.title,
      description: Faker::Markdown.sandwich(8,4),
      company_id: companies.sample.id,
      highlight: rand(0..10) % 5 == 0
    )
  end

  # Job tags

  jobs = Job.all
  tags = Tag.all

  def create_job_tag(tags, job)
    tag = tags.sample
    JobTag.create(
      tag_id: tag.id,
      job_id: job.id
    )
  end

  jobs.each do |job|
    create_job_tag(tags, job)
    create_job_tag(tags, job) if rand(0..10) % 2 == 0
    create_job_tag(tags, job) if rand(0..10) % 2 == 0
  end
end