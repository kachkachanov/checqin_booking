admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@roomly.local')
admin_password = ENV.fetch('ADMIN_PASSWORD', 'password123')

admin = User.find_or_initialize_by(email: admin_email)
admin.password = admin_password if admin.new_record?
admin.password_confirmation = admin_password if admin.new_record?
admin.role = 'admin'
admin.save!

puts "Admin ready: #{admin.email}"
