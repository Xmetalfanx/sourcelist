# old variables left here for now
debian_branch="stable"
debian_codename="bookworm"


# Goal (summary) find lines in source.list that start with "deb" and add "contrib" and "non-free" to the end of the line
function simpleSed() {
    # i know -i is missing ... i am leaving that out while testing

    # themachine way - grouping
    # sed 's/\(^deb.*\)/\1 contrib non-free/' source.list

    # my old way
    # remember/note to self ... -i is not there for now
    #sed "/^deb/ s/$/$ contrib non-free/g" source.list
    ################################################################

    # only issue is the extra repos keep getting added ... i need to add a check for that

    # works
    #sed -i "s/[[:space:]]*$//g;/^deb/ s/$/ contrib non-free/g" source.list


    # clear possible spaces at end
    echo -e "clearing possible spaces"
    sed -i 's/[[:blank:]]*$//g' source.list
    sleep 2

    echo -e "Adding to source file IF needed"
    # issue here: it will keep added the extra repos: i need to check "if they already are in the line", first
    #sed -e "/^deb/ s/$/ contrib non-free/g" source.list

    # 1 - if it starts with deb 
    # 2 - if "contrib non-free" doesn't exist in the line already, add it at the end 
    awk '/^deb/ && $0 !~ "contrib non-free" {print $0 " contrib non-free"}' source.list > source.list.tmp

    #wait ... file may exist but is blank ... same issue as before
    [ -s source.list.tmp ] && mv source.list.tmp source.list

    # cleanup temp file if it still exists
    [ -f source.list.tmp ] && rm source.list.tmp

}

clear && simpleSed
