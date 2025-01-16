# frozen_string_literal: true
puts 'Seeding database with demo user...'

# Reset database
User.destroy_all
Win.destroy_all

# Create demo user
@user = User.create!(
  username: 'winner',
  password: 'password123',
  password_confirmation: 'password123'
)

# Create wins for demo user
sample_wins = [
  {
    title: 'Migrated SYNRGY app to Microservices',
    description: 'Spearheaded the transition from a monolithic architecture to microservices, reducing deployment time from 1 hour to just 5 minutes.',
    category: 'project',
    accomplished_date: '2024-01-01'
  },
  {
    title: 'Developed Real-Time Data Streaming Pipeline',
    description: 'Designed and implemented a data streaming pipeline using Kafka and Spark, which enhanced the accuracy of machine learning models by 15%.',
    accomplished_date: '2024-02-02',
    category: 'project'
  },
  {
    title: 'Optimized SYNRGY Mobile App Performance',
    description: 'Improved mobile app performance by reducing network calls by 50% through optimization of the caching layer and access patterns.',
    accomplished_date: '2024-03-03',
    category: 'project'
  },
  {
    title: 'Implemented WebSocket Integration',
    description: 'Integrated WebSocket technology, resulting in a 300ms reduction in page load times.',
    accomplished_date: '2024-04-04',
    category: 'project'
  },
  {
    title: 'Mentored Junior Developers',
    description: 'Provided comprehensive mentorship to 3 junior developers throughout the software development lifecycle, including code reviews and design guidance.',
    accomplished_date: '2024-05-05',
    category: 'other'
  },
  {
    title: 'Led Hackathon Project',
    description: 'Directed a hackathon project that created an internal tool to automate the release process, which was subsequently adopted across the organization.',
    accomplished_date: '2024-06-06',
    category: 'project'
  },
  {
    title: 'Conducted Kubernetes Training',
    description: 'Delivered training sessions on Kubernetes best practices to the entire engineering organization.',
    accomplished_date: '2024-07-07',
    category: 'project'
  },
  {
    title: 'Collaborated on Project Roadmap',
    description: 'Worked cross-functionally to develop a project roadmap that prioritized the reduction of technical debt.',
    accomplished_date: '2024-08-08',
    category: 'other'
  },
  {
    title: 'Machine Learning Engineer Nanodegree',
    description: 'Successfully completed the Machine Learning Engineer Nanodegree certification program.',
    accomplished_date: '2024-09-09',
    category: 'learning'
  },
  {
    title: 'Spoke at Python conference',
    description: 'Invited to deliver a talk on microservice patterns at a regional Python conference.',
    accomplished_date: '2024-10-10',
    category: 'milestone'
  },
  {
    title: 'Excellence in Mentorship Award',
    description: 'Received the company’s Excellence in Mentorship award for outstanding support and guidance.',
    accomplished_date: '2024-11-11',
    category: 'kudos'
  },
  {
    title: 'Enhanced Mobile App Ratings',
    description: 'Improved mobile app ratings from 2.5 to 4.2 stars following the launch of version 2.',
    accomplished_date: '2024-12-12',
    category: 'other'
  },
  {
    title: 'Increased Development Velocity',
    description: 'Boosted feature development velocity by 40% through a microservice refactor.',
    accomplished_date: '2024-01-03',
    category: 'other'
  },
  {
    title: 'Boosted Page Views',
    description: 'Achieved a 150% increase in page views on marketing landing pages following a redesign.',
    accomplished_date: '2024-02-06',
    category: 'other'
  },
  {
    title: 'Enabled third parties to create integrations using webhooks',
    description: 'I developed and deployed a new set of API endpoints that enabled third parties to create integrations using webhooks.This enhancement addressed a critical need for several major customers, who collectively represent around $2 million in annual revenue. Notably, one key customer had a $400k renewal pending the month after the endpoints were launched and was considering switching to a competitor if the integration was not delivered on time. By ensuring timely release, I helped secure this significant contract and supported our company\'s broader strategic goals.',
    accomplished_date: '2024-10-09',
    category: 'project'
  },
  {
    title: 'Testimonial from Linus',
    description: "Thanks to Demo's mentorship, I've been able to take on more challenging projects and contribute effectively to our team's goals. Their dedication to helping others succeed is truly commendable, and I am grateful for the opportunity to have learned from one of the best in the field.",
    accomplished_date: '2024-08-12',
    category: 'kudos'
  },
  {
    title: 'Testimonial from Steve',
    description: 'I had the pleasure of being mentored by Demo during my time as a junior software engineer at SYNRGY. Demo played a pivotal role in my professional development, offering invaluable guidance and support throughout the onboarding process and beyond.',
    accomplished_date: '2024-10-15',
    category: 'kudos'
  },
  {
    title: 'Thank you from Ada',
    description: 'Beyond technical training, Demo exemplified professionalism and teamwork. Their constructive feedback and thoughtful code reviews not only helped me improve my coding skills but also taught me best practices in software development. Their willingness to share their own experiences and insights made a lasting impression and greatly contributed to my growth as an engineer.',
    accomplished_date: '2024-06-18',
    category: 'kudos'
  },
  {
    title: '1 year anniversary',
    description: 'One year of employment at SYNRGY',
    accomplished_date: '2024-10-20',
    category: 'milestone'
  },
  {
    title: 'Project Management Professional (PMP) certification',
    description: 'Completed 2000 hours of training',
    accomplished_date: '2024-05-02',
    category: 'learning'
  }
]

@user.wins.create!(sample_wins)

puts 'done seeding!'
