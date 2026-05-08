function ghr
    gh repo list lemone-com --limit 200 --json name,url \
        | jq -r '.[] | "\(.name)\t\(.url)"' \
        | fzf | awk '{print $2}' | xargs xdg-open
end
