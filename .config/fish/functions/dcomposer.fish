function dcomposer --description "Run composer in Docker with 1Password SSH agent"
    mkdir -p $HOME/.cache/docker-composer

    docker run --rm -it \
        --user (id -u):(id -g) \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v (pwd):/app \
        -v "$HOME/.1password/agent.sock":/ssh-auth.sock \
        -v "$HOME/.cache/docker-composer":/tmp/composer-home \
        --tmpfs /home/rutger:uid=(id -u),gid=(id -g) \
        -e SSH_AUTH_SOCK=/ssh-auth.sock \
        -e COMPOSER_HOME=/tmp/composer-home \
        -e GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new" \
        -w /app \
        composer:2 $argv
end
