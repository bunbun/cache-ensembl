#!/usr/bin/python
import sys, time

ortholog_type_id_to_ortholog_type    =  dict()
homolog_id_to_data                   =  dict()
member_id_to_real_id                 =  dict()
ortholog_sets                        =  dict()
ortholog_set_pairwise_scores         =  dict()
ortholog_set_pairwise_alignment      =  dict()

j = 1
def empty(ortholog_type_id_to_ortholog_type,
          homolog_id_to_data,
          member_id_to_real_id,
          ortholog_sets,
          ortholog_set_pairwise_scores,
          ortholog_set_pairwise_alignment):
    j = 1

start = time.time()
for i in xrange(24000000):
    if i % 1000000 == 0:
        print i
    empty(ortholog_type_id_to_ortholog_type,
          homolog_id_to_data,
          member_id_to_real_id,
          ortholog_sets,
          ortholog_set_pairwise_scores,
          ortholog_set_pairwise_alignment)

print "done %.2fs" % (time.time() - start)
i = sys.stdin.readline()
print "over done"

