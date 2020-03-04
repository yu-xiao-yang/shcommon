#!/usr/bin/sh
TABLE_INDEX=247
TABLE_NAME=net_${TABLE_INDEX}


NEXT_HOP=
SRC_NET=



function create_table(){
# route tables
has_net2=`cat /etc/iproute2/rt_tables|grep "${TABLE_INDEX}"`

cat  /etc/iproute2/rt_tables |grep -v ${TABLE_INDEX} > rt_tables
mv -f rt_tables /etc/iproute2/
echo "${TABLE_INDEX}    ${TABLE_NAME}" >> /etc/iproute2/rt_tables

}

function clear_table(){

#   NEXT_HOP=$1
   ip route flush table  ${TABLE_NAME}
  # ip route add  default  via  ${NEXT_HOP}    table ${TABLE_NAME}

   cnt=` ip rule list  | grep _${TABLE_INDEX} |wc -l`
   for((i=0 ;i<cnt; i++  ))
   {
        echo "---"
        ip rule  del  table ${TABLE_NAME}
        ip rule  del  table ${TABLE_NAME}
   }
}

function insert_table(){
#   SRC_NET=$1
   DST_NET=$1
   NEXT_HOP=$2
#  ip route add  default  via  ${NEXT_HOP}    table ${TABLE_NAME}
   ip rule  add  to   ${DST_NET}   table ${TABLE_NAME}   pref 32700
   echo ${DST_NET}  ${NEXT_HOP}
   ip route add  ${DST_NET}  via ${NEXT_HOP}  table ${TABLE_NAME}
}
function show_list(){

        ip  rule list

}

# create_table

# clear_table

# insert_table
# create_table

# clear_table

# insert_table

case $1 in
  "clear" )
        echo $1
        create_table
        clear_table  >/dev/null  2>&1
 ;;
   "insert" )
        echo $1
        insert_table  "$2"   "$3"
 ;;
   "show" )
       echo "show"
 ;;
    * )
        echo $1
        echo "####"
   ;;
esac



#example 




