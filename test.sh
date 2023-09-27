# old variables left here for now
debian_branch="stable"
debian_codename="bookworm"


# Goal (summary) find lines in sources.list that start with "deb" and add "contrib" and "non-free" to the end of the line
function simpleSed() {

    # themachine way - grouping
    # sed 's/\(^deb.*\)/\1 contrib non-free/' sources.list

    # clear possible spaces at end
    echo -e "clearing possible spaces"
    #sed -i 's/[[:blank:]]*$//g' sources.list
    sed -i 's/\s*$//g' sources.list
    sleep 1

    echo -e "Adding to source file IF needed"
    #sed '/^deb/ s/$/ contrib non-free/g' sources.list
    sed '/.*deb .*\|;$/ s/$/ contrib non-free/g' sources.list

    exit 



    # 1 - if it starts with "deb" AND 
    # 2 - if "contrib non-free" doesn't exist in the line already, add it at the end 
    #awk '/^deb/ && $0 !~ "contrib non-free" {print $0 " contrib non-free"}' sources.list > sources.list.tmp

    # if sources.list.tmp is there but NOT blank, then move it
    #[ -s sources.list.tmp ] && mv sources.list.tmp sources.list

    # cleanup temp file if it still exists
    #[ -f sources.list.tmp ] && rm sources.list.tmp

}

clear && simpleSed
