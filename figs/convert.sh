for file in *.svg
do
     /usr/bin/inkscape -z -f "${file}" -w 1800 -e "${file%%.*}.png"
done
