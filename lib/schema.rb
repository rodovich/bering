module Schema
  MIGRATIONS_PATH = 'db/migrate/'

  def Schema.print_plan(files)
    rollbacks = files[:rollbacks] || []
    migrations = files[:migrations] || []
    plan = []
    plan << "#{rollbacks.count} down" if rollbacks.any?
    plan << "#{migrations.count} up" if migrations.any?
    puts "Migrating:  #{plan.join(', ')}" if plan.any?
    puts "0 migrations" if plan.empty?
  end

  def Schema.migrate(files)
    system "rake db:migrate" unless files.empty?
  end

  def Schema.rollback(files)
    system "rake db:rollback STEP=#{files.count}" unless files.empty?
  end
end
