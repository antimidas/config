function gcap --description 'git add, commit, push'
    git add -A
    if test (count $argv) -eq 0
        git commit -m "Update"
    else
        git commit -m "$argv"
    end
    git push
end
