# ghr - fuzzy-find a GitHub repo in an organisation and act on it.
#
# Usage: ghr [query]
#   enter   open the repo in your browser
#   ctrl-y  copy the SSH clone URL to the clipboard
#   ctrl-x  clone the repo into the work directory and cd into it
#           (or just cd there if it's already cloned)
#   ctrl-r  re-fetch the repo list from GitHub
#
# Run with no query inside a cloned repo and that repo is pre-selected.
#
# Configuration (via environment variables, with defaults below):
#   GHR_ORG      GitHub organisation to list repos from
#   GHR_WORKDIR  directory to clone repos into
#
# The repo list is fetched once via the gh CLI and cached in /tmp. It is never
# auto-expired (we add repos rarely); press ctrl-r in fzf to refresh on demand.
function ghr --description "Fuzzy-find a GitHub repo: open, copy clone URL, or clone"
    # Defaults, overridable via environment variables
    set -l org lemone-com
    set -l workdir ~/Work
    set -q GHR_ORG; and set org $GHR_ORG
    set -q GHR_WORKDIR; and set workdir $GHR_WORKDIR

    # Cache per organisation so switching orgs never serves stale data.
    set -l cache /tmp/ghr-cache-$org.tsv
    set -l jqfmt '.[] | "\(.name)\t\(.url)\t\(.sshUrl)"'

    # First run only: populate the cache (the one time we block on the
    # network). Write via a temp file so a failed fetch never leaves an empty
    # cache behind — there's no auto-refresh to recover from that.
    if not test -f $cache
        set -l tmp $cache.new
        if gh repo list $org --limit 200 --json name,url,sshUrl --jq $jqfmt >$tmp
            mv $tmp $cache
        else
            rm -f $tmp
            echo "ghr: could not fetch repos for $org" >&2
            return 1
        end
    end

    # Pre-fill the query: an explicit argument wins; otherwise, when run inside
    # a git work tree, default to the current repo's name so it's pre-selected.
    set -l query "$argv"
    if test -z "$query"
        set -l repo (git config --get remote.origin.url 2>/dev/null \
            | string replace -r '.*/' '' | string replace -r '\.git$' '')
        test -n "$repo"; and set query $repo
    end

    # --expect makes fzf print the pressed key on the first line, followed by
    # the selected line (name<TAB>url<TAB>sshUrl). ctrl-r re-fetches the list
    # and rewrites the cache, falling back to the existing cache on failure.
    set -l fetched (date -d @(stat -c %Y $cache) '+%-d %B %H:%M')
    set -l out (fzf --query="$query" --with-nth=1 --delimiter=\t \
        --expect=ctrl-y,ctrl-x \
        --bind="ctrl-r:reload(gh repo list $org --limit 200 --json name,url,sshUrl --jq '$jqfmt' >$cache.new && mv $cache.new $cache; cat $cache)" \
        --header="last fetched $fetched · press ctrl-r to refresh
enter: browser · ctrl-y: copy clone url · ctrl-x: clone in $workdir" <$cache)
    test (count $out) -lt 2; and return # cancelled with ESC
    set -l key $out[1]
    set -l fields (string split \t -- $out[2])
    set -l name $fields[1]
    set -l url $fields[2]
    set -l ssh $fields[3]
    switch $key
        case ctrl-y
            echo -n $ssh | wl-copy
            echo "📋 $ssh"
        case ctrl-x
            if test -d $workdir/$name
                # Already cloned: just go there
                cd $workdir/$name
            else if git clone $ssh $workdir/$name
                cd $workdir/$name
            end
        case '*'
            xdg-open $url
    end
end
