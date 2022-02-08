BEGIN {print "\n\n# "title"\n\n"}                   
NR==1 {next}                                       
{ pre=post=""                                 
  if (sub(/^    /,"")) {                      
    if(!code) {pre="\n```lisp\n";post=""} 
    code=1                                       
  } else {                                        
    if(code) {pre=""; post="\n```\n\n"}    
    code=0 }                                      
  gsub(/(#\||\|#)/,"")
  print pre $0 post     } 
