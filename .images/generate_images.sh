#!/bin/sh

gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=1 -dLastPage=1 \
    -sDEVICE=pngalpha -o %stdout -r50 "../thesis.pdf" |
convert -background white -alpha remove - title-th.png

gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=1 -dLastPage=1 \
    -sDEVICE=pngalpha -o %stdout -r144 "../thesis.pdf" |
convert -background white -alpha remove - title.png


gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=2 -dLastPage=2 \
    -sDEVICE=pngalpha -o %stdout -r50 "../thesis.pdf" |
convert -background white -alpha remove - colophon-th.png

gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=2 -dLastPage=2 \
    -sDEVICE=pngalpha -o %stdout -r144 "../thesis.pdf" |
convert -background white -alpha remove - colophon.png


gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=7 -dLastPage=7 \
    -sDEVICE=pngalpha -o %stdout -r50 "../thesis.pdf" |
convert -background white -alpha remove - publications-th.png

gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=7 -dLastPage=7 \
    -sDEVICE=pngalpha -o %stdout -r144 "../thesis.pdf" |
convert -background white -alpha remove - publications.png


gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=31 -dLastPage=31 \
    -sDEVICE=pngalpha -o %stdout -r50 "../thesis.pdf" |
convert -background white -alpha remove - introduction-th.png

gs -q -dSAFER -dBATCH -dNOPAUSE -dFirstPage=31 -dLastPage=31 \
    -sDEVICE=pngalpha -o %stdout -r144 "../thesis.pdf" |
convert -background white -alpha remove - introduction.png
