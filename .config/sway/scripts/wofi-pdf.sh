TMP=/tmp/wofi-pdf-search.txt

if [[ -z "$BOOK_PATH" ]]; then
    echo BOOK_PATH not set
    exit 1
fi

#fd -t f -e pdf -a '.*' $HOME > $TMP
rm -f $TMP
echo $BOOK_PATH \
    | sed "s;:;\n;g" \
    | xargs -I {} fd -t f -e pdf -a '.*' {} >> $TMP

HAS_SELECTION=0
NUM=$( \
    cat $TMP \
    | rev \
    | cut -d / -f 1 \
    | rev \
    | wofi -M fuzzy -i -D dmenu-print_line_num=true -d
) && HAS_SELECTION=1

if [ $HAS_SELECTION == "1" ]; then
    echo $HAS_SELECTION
    xdg-open $(awk "NR==$NUM+1" "$TMP")
    rm $TMP
fi

