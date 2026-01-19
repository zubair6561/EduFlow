# EduFlow – Rails 7 EdTech LMS

EduFlow is a production-ready learning management platform built with Rails 7, Devise authentication, PostgreSQL, Tailwind CSS v4, Action Text, and Active Storage. It showcases multi-role dashboards, course management, lesson authoring, enrollments, and lesson progress tracking with modern SaaS UI.

## Features
- Devise authentication with roles (`admin`, `instructor`, `student`) and strong role-based guards.
- Dashboards per role:
  - **Admin:** platform metrics, user/course/enrollment counts, recent activity.
  - **Instructor:** course ownership view, enrollments, quick actions, progress snapshot.
  - **Student:** enrolled courses with completion percentages and “continue learning.”
- Course & lesson CRUD (admin/instructor), Action Text rich lesson content, Active Storage thumbnails.
- Student enrollments plus lesson completion tracking and course progress calculations.
- Tailwind CSS UI with sidebar navigation, cards, tables, and responsive layouts.

## Tech Stack
- Ruby 3.2.2, Rails 7.1, PostgreSQL
- Tailwind CSS v4 (tailwindcss-rails), Importmap, Stimulus/Turbo
- Devise, Action Text, Active Storage, Faker for seeds

## Setup
```bash
bundle install
bin/rails db:create db:migrate db:seed
# start dev server + tailwind watcher
bin/dev
# or run Rails server only
bin/rails server
```

## Seeded Accounts
- Admin: `admin@eduflow.test` / `Password123`
- Instructors: `ivy@eduflow.test`, `noah@eduflow.test` / `Password123`
- Students: `student1@eduflow.test` … `student5@eduflow.test` / `Password123`

## Key Routes
- `/dashboard` smart-redirects by role
- `/admin/dashboard`, `/instructor/dashboard`, `/student/dashboard`
- `/courses` (catalog + instructor view), `/courses/:id`, nested lessons, enrollments, and progress updates

## Screenshots
- Dashboard (admin, instructor, student) – add your captures here
- Course detail & lesson view – add captures

## Notes
- Action Text and Active Storage are enabled; thumbnails use `image_processing` (MiniMagick/vips).
- Tailwind build runs automatically via `bin/dev`; ensure PostgreSQL is running locally.
- Tests: default Rails test suite scaffolded; no custom specs added yet.
