module Schema
  def Schema.migrate(files)
    system "rake db:migrate" unless files.empty?
  end

  def Schema.rollback(files)
    system "rake db:rollback STEP=#{files.count}" unless files.empty?
  end
end
