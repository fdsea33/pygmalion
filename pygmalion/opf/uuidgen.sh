rm -f uuid.h
touch uuid.h
echo "#ifndef __uuid_h__">>uuid.h
echo "#define __uuid_h__">>uuid.h
echo "">>uuid.h
echo "#define UUID_NB "${1}>>uuid.h
echo "">>uuid.h
echo "char * gUUID[UUID_NB]={">>uuid.h
for i in $(seq 2 1 $1); do
  u=`uuidgen`
  echo "  \""${u}"\",">>uuid.h
done
u=`uuidgen`
echo "  \""${u}"\"};">>uuid.h
echo "">>uuid.h
echo "#endif">>uuid.h
