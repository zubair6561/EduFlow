require "faker"

Faker::Config.random = Random.new(42)

LessonProgress.destroy_all
Enrollment.destroy_all
Lesson.destroy_all
Course.destroy_all
User.destroy_all

admin = User.create!(full_name: "Amelia Admin", email: "admin@eduflow.test", password: "Password123", role: :admin)
instructor_one = User.create!(full_name: "Ivy Instructor", email: "ivy@eduflow.test", password: "Password123", role: :instructor)
instructor_two = User.create!(full_name: "Noah Mentor", email: "noah@eduflow.test", password: "Password123", role: :instructor)

students = 5.times.map do |i|
  User.create!(full_name: Faker::Name.name, email: "student#{i + 1}@eduflow.test", password: "Password123", role: :student)
end

instructors = [instructor_one, instructor_two]
courses = []

5.times do
  instructor = instructors.sample
  course = Course.create!(
    title: "#{Faker::Educator.course_name} Masterclass",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    status: :published,
    instructor:
  )

  6.times do |i|
    lesson = course.lessons.create!(
      title: "#{Faker::Educator.subject} Lesson #{i + 1}",
      position: i + 1,
      content: "<p>#{Faker::Lorem.paragraphs(number: 2).join("</p><p>")}</p>"
    )
    lesson.rich_text_content
  end

  courses << course
end

students.each do |student|
  courses.sample(3).each do |course|
    enrollment = Enrollment.create!(user: student, course:)
    course.lessons.sample(3).each do |lesson|
      LessonProgress.create!(user: student, lesson:, completed: [true, false].sample)
    end
  end
end

puts "Seeded:"
puts " - Admin: #{admin.email}"
puts " - Instructors: #{instructors.map(&:email).join(", ")}"
puts " - Students: #{students.map(&:email).join(", ")}"
