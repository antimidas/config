function dotsync --description 'sync dotfiles repo: add, commit, push'
    pushd /home/anti/.config
    or return 1
    
    git add -A
    git commit -m "dotfiles update "(date "+%Y-%m-%d %H:%M")
    git push
    
    popd
end
