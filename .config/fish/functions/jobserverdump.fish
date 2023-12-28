function jobserverdump --description "Copy Job Server's DB dump file to the current directory"
    command scp dokku4:/var/lib/dokku/data/storage/job-server/jobserver.dump jobserver.dump
end
