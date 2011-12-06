#!/usr/bin/env python
import logging,sys
logger = logging.getLogger("test")
logger.addHandler(logging.StreamHandler(sys.stderr))
stderrhandler.setFormatter(logging.Formatter("    %(message)s"))
logger.setLevel(logging.DEBUG)



from cache_ensembl import *
log_file       = "/net/cpp-mirror/databases/ensembl_cache/core_protein_features.log"
index_file     = "/net/cpp-mirror/databases/ensembl_cache/core_protein_features.index"
data_directory = "/net/cpp-mirror/databases/ensembl_cache"
verbose                 = 1
log_parameters          = True
species        = "Homo_sapiens",
filter_feature_types    = "pfam", "smart"


#from json import dumps
from collections import defaultdict
prot_id_to_features = defaultdict(list)
for s in species:
    (protein_features,
    matches_by_type,
    ensembl_version,
    ensembl_version_str,
    cache_file_name) =  get_core_protein_features(index_file, s, logger,
                          ensembl_version = 58,
                          filter_feature_types = filter_feature_types)
    prot_id_to_features_per_species = get_prot_id_to_features(matches_by_type, protein_features, True)
    prot_id_to_features.update(prot_id_to_features_per_species)

from gtf_to_genes.dump_object import dump_object
print dump_object(prot_id_to_features["ENSP00000296682"])
print dump_object(prot_id_to_features["ENSP00000296682"], line_length = 2000)

