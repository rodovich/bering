module Git
  def Git.changes_in(path, from, to, statuses='ADM')
    cmd = ['git', 'diff', '--name-status', from, to, path]
    IO.popen(cmd, 'r').readlines.inject([]) do |results, line|
      status, file = line.strip.split("\t")
      results << file if statuses.index(status)
    end
  end

  def Git.checkout(branch, files={})
    cmd = ['git', 'checkout', branch] + files
    IO.popen(cmd, 'r').read
  end

  def Git.common_ancestor(from, to)
    cmd = ['git', 'merge-base', from, to]
    IO.popen(cmd, 'r').readline.strip
  end

  def Git.has_changes?
    `git status --porcelain`.lines.any?
  end

  def Git.within_sandbox
    stashing = Git.has_changes?
    `git stash save --include-untracked` if stashing
    result = yield
    `git reset --hard`
    `git stash pop` if stashing
    result
  end
end
