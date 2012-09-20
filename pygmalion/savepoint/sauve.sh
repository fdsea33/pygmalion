#!/bin/bash
psql -COx gestsea3 > gestsea3.sql
zz gestsea3.sql
rm -f gestsea3.sql
