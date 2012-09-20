
BEGIN {
  print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
  print "<analysis name=\""FILENAME"\">"
}

toupper($1)=="CREATE" && toupper($2)=="DATABASE" {}



toupper(substr($0,1,12))=="CREATE TABLE" {
  if (substr($3,1,1)=="\"") {
    print "  <table name="$3" label=\"\">"
  } else {
    print "  <table name=\""$3"\" label=\"\">"
  }
}

toupper(substr($0,1,12))=="CREATE TABLE", $0==")" ||$0==");" {
  if (toupper(substr($0,1,12))!="CREATE TABLE" && $0!=")" && $0!=");") {
    if (substr($0,length($0),length($0))==",") {
      $0 = substr($0,1,length($0)-1)
    }
    if (substr($1,1,1)=="\"") {
      name = $1
    } else {
      name = "\""$1"\""
    }
    type=$2
    start=3
    if (tolower($2)=="character") {
      type = "varchar"substr($3,8,length($3))
      start=4
    } else {
      if (tolower($2)=="timestamp" || tolower($2)=="time") {
	if (tolower($3)=="with" || tolower($3)=="without") {
	  type=$2" "$3" "$4" "$5
	  start=6
	}
      }
    }
    type=toupper(type)
    notnull=""
    if (index($0,"NOT NULL")!=0) {
      notnull=" notnull=\"true\""
    }
    default=""
    if (toupper($start)=="DEFAULT") {
      default=""
      start+=1
      first=1
      while (start<=NF && $start!="NOT") {
	if (first!=1) {
	  default = default" "
	}
	default = default""$start
	start += 1
	first = 0
      }
      gsub(/\"/,"",default)
      default = " default=\""default"\""
    }
    print "    <column name="name" type=\""type"\""notnull""default"/>"
  }
}



$1=="INHERITS" { print "    <inherits table=\""substr($2,2,length($2)-3)"\"/>\n  </table>"}

$0==");" {print "  </table>"}


toupper($1)=="CREATE" && toupper($2)=="INDEX" {
  columns = ""
  for (i=8;i<=NF;i++) {
    columns = columns""$i
  }
  column = substr(columns,2,length(columns)-3)
  if (index(column,"\"")>0) {
    gsub(/\"/,"",column)
  }
  print "  <index table=\""$5"\" column=\""column"\"/>"
}



function simpop(line, event) {
  ret = ""
  opt = ""
  action = ""
  option = ""
  ik = index($0,event) 
  if (ik>0) {
    option = substr($0,ik+length(event)+1,length($0))
    ie = index(option,"ON");
    if (ie>0) {
      action = substr(option,1,ie-2);
    } else {
      action = substr(option,1,length(option)-1);
    }
    if (event=="DELETE") {
      ret = "od"
    } else {
      if (event=="UPDATE") {
	ret = "ou"
      } else {
	ret = "error"
      }
    }
    if (toupper(action)=="SET NULL") { ret = ret"sn" } 
    else {
      if (toupper(action)=="CASCADE") { ret = ret"c" }
      else {
	if (toupper(action)=="RESTRICT") { ret = ret"r" } 
	else {
	  if (toupper(action)=="NO ACTION") { ret = ret"na"}
	  else {
	    if (toupper(action)=="SET DEFAULT") { ret = ret"sd" }
	    else { ret = ret""}
	  }
	}
      }
    }
  }
  return ret
}


toupper($1)=="ALTER" && toupper($2)=="TABLE", toupper($1)=="ADD" && toupper($2)=="CONSTRAINT" {
  if (toupper($1)=="ALTER") {
    if (toupper($3)=="ONLY") {
      table = $4
    } else {
      table = $3
    }
    print "  <constraint table=\""table"\""
  } else {
    const = ""
    detail = ""
    if (toupper($4)=="UNIQUE") {
      $5 = substr($5, 2,length($5)-3)
      if (index($5,"\"")>0) {
	$5 = substr($5, 2,length($5)-2)
      }
      const = "unique"
      detail = " column=\""$5"\""
    } else {
      gsub(/\"/,"",$6)
      $6 = substr($6, 2,length($6)-2)
      if (toupper($4)=="PRIMARY") {
	$6 = substr($6, 1,length($6)-1)
	const  = "primarykey"
	detail = " column=\""$6"\""
      } else {
	const  = "foreignkey"
	references = $8
	detail = " column=\""$6"\" references=\""references"\" opt=\""simpop($0,"DELETE")simpop($0,"UPDATE")"\""
      }
    }
    print "    type=\""const"\""detail"/>"
  }
}






END {print "</analysis>"}
