# Without the -6, curl issues a AAAA DNS Query, which dnsspoof won't respond to
while true; do
#    curl -4 www.goodle.com:80;
    curl -4  10.0.0.4:8000;
    sleep 2;
    echo "";
    echo "--`date`--";
done
