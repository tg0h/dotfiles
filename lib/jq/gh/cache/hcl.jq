include "pad";

def mapCache: "\(.id)"
              +" \(.ref | lp(20))"
              +" \(.key | trunc(35)|lp(35))"
              # +" \(.version | trunc(75))"
              +" \(.size_in_bytes/1000000 | floor | lp(3)) MB"
              +" \(.created_at[0:16])"
              +" \(.last_accessed_at[0:16])"
              ;
# def mapCache: .;
def hcl: .total_count, (.actions_caches|map(mapCache))[];
