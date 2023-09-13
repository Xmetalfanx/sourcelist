debian_branch="stable"
debian_codename="bookworm"

function oldTests() {
    #sed '/deb.debian.org/s/$/ contrib non-free/' source.list

    #targetLine=$(sed -ne "deb\s;/${debian_codename}\s/p" source.list)
    #targetLine=$(grep -e "^deb " source.list)

    return 
}

function addSources() {
    sed -i "s|$targetLine|$targetLine $additionalRepos|g" source.list
}

function checkTargetLine() {
    additionalRepos="contrib non-free"

    # 1 - if the line starts with "deb "- the space here prevents deb-src from being in the results
    # 2 - if the codename or branch (some users may say use "stable" others may use "bookworm" in the source.list file )
    # 3 - the line at this point DOESN'T contain additionalRepos
    targetLine=$(awk -v branch="$debian_branch " -v codename="$debian_codename " -v repos="$additionalRepos" '
    { 
        if (/^deb /) 
            if ($0 ~ codename || $0 ~ branch)
                if ($0 !~ repos)
                    print;
                else if ($0 ~ repos)
                    print "Additional Repos already added to source.list"                
                 
    } ' source.list )

    echo -e "$targetLine"
    addSources
}

clear 

checkTargetLine
