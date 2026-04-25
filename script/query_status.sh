#! /bin/bash 

set -euo pipefail 
 
######## Config #########

PGDATABASE="zxsmp"
SCHEMA="tenant_14a6a16c2c9a40b8b265f332db3d342b"
TABLE="smp_t_stb_onlinestatus"

##########################

# Test Login 
# RESULT=$(psql -d "$PGDATABASE" -c "\dt")
# echo "$RESULT"

SQL="SELECT
        SUM(CASE WHEN onlinestatus = 1 THEN 1 ELSE 0 END) AS Online,
        SUM(CASE WHEN onlinestatus = 0 THEN 1 ELSE 0 END) AS Offline
    FROM \"${SCHEMA}\".${TABLE};"

# Test Login 
RESULT=$(psql -d "$PGDATABASE" -A -t -F '|' -c "$SQL")

# debug 
# echo "$RESULT"

# Split string 
ONLINE=$(echo "$RESULT" | cut -d'|' -f1)
OFFLINE=$(echo "$RESULT" | cut -d'|' -f2)

#echo "Online: $ONLINE, Offline: $OFFLINE "

ONLINE=${ONLINE:-0} # default 0 
OFFLINE=${OFFLINE:-0} # default 0 
ACTIVE=$((ONLINE + OFFLINE))

if [ $ACTIVE -gt 0 ]; then
    RATE=$(awk "BEGIN { printf \"%.1f\", ($ONLINE / $ACTIVE) * 100}")
else
    RATE="0.0"
fi 

echo "Active fleet : $ACTIVE"
echo "  Online     : $ONLINE  (${RATE}%)"
echo "  Offline    : $OFFLINE"