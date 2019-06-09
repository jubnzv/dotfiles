complete --command update-gitignore -a '(__fish_complete_path ~/Sources/gitignore/(commandline -ct) | /bin/grep .gitignore | cut -d"/" -f 6- | cut -d"." -f 1)'
