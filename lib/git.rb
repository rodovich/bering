module Git
  def Git.changes_in(path, from, to, statuses='ADM')
    `git diff --name-status #{from} #{to} #{path}`.split("\n").inject([]) do |results, line|
      status, file = line.split("\t")
      results << file if statuses.index(status)
    end
  end

  def Git.checkout(branch, files={})
    `git checkout #{branch} #{files.join(' ')}`
  end

  def Git.common_ancestor(from, to)
    `git merge-base #{from} #{to}`.split("\n")[0]
  end

  def Git.reset
    `git reset --hard`
  end
end
