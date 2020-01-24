#!/usr/bin/env bash
cd $HOME/Org/Notes/

UNSORT_H="## Unsorted"

I=0
if [[ $1 == "-i" ]]; then
    I=1
fi

# We need an additional heading for unsorted files
HEADING_POS=$(grep -n "$UNSORT_H" index.md | awk -F':' '{print $1}' | head -1)
SHOULD_ADD_HEADING=0
if [[ $HEADING_POS == "" ]]; then
    SHOULD_ADD_HEADING=1
    HEADING_POS=$(($(wc -l index.md | awk '{print $1}')))

    # Keep empty line at the end of file
    if [[ $(tail -1 index.md) != "" ]]; then
        echo "" >> index.md
    fi
else
    HEADING_POS=$((HEADING_POS+1))
fi

# Check that all markdown notes occurs in index
for f in *.md; do

    if [[ $f == "index.md" ]]; then
        continue
    fi

    v=$(grep $f index.md)
    if [[ $v == "" ]]; then
        # Confirm action
        if [[ $I -eq 1 ]]; then
            read -p "Add $f to index.md (y/N)? " -r
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                continue
            fi
        fi

        # Add 'unsorted' heading
        if [[ $SHOULD_ADD_HEADING -eq 1 ]]; then
            sed -i "${HEADING_POS}i${UNSORT_H}" index.md
            SHOULD_ADD_HEADING=0
            HEADING_POS=$((HEADING_POS+1))
            if [[ $I -eq 1 ]]; then echo "$UNSORT_H will be added at the end of file"; fi
        fi

        # Add link
        link="* [$(echo $f | sed 's/...$//')]($f)"
        sed -i "${HEADING_POS}i$link" index.md
        HEADING_POS=$((HEADING_POS+1))
    fi
done

