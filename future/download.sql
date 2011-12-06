--Download all homology_member 48,409,690
SELECT
      homology_id,
      member_id,
      peptide_member_id,
      cigar_line,
      perc_cov,
      perc_id,
      perc_pos
  FROM
      homology_member
     ;
--Download all homology 24,204,845
 SELECT
         homology_id,
         method_link_species_set_id,
         description,
         dn,
         ds,
         n,
         s,
         ancestor_node_id,
         tree_node_id
     FROM
         homology
     WHERE
         method_link_species_set_id =20848
     LIMIT 1; 
--+-------------+----------------------------+------------------+---------+---------+-------+-----------------+------------------+--------------+
--| homology_id | method_link_species_set_id | description      | dn      | ds      | n     | threshold_on_ds | ancestor_node_id | tree_node_id |
--+-------------+----------------------------+------------------+---------+---------+-------+-----------------+------------------+--------------+
--|         124 |                      20848 | ortholog_one2one | 0.04400 | 0.04520 | 234.7 |            95.3 |           859698 |       839538 |
--+-------------+----------------------------+------------------+---------+---------+-------+-----------------+------------------+--------------+
 
 
gene_id_to_ortholog_set[gene_id][species_pair_id] = ancestor_node_id
[species_pair_id][ancestor_node_id]


t_ortholog_set_pairwise_scores
    dn, ds, n, s
t_ortholog_set
      ancestor_node_id
      tree_node_id
      description
      gene_ids[taxon_id] = [gene_id], [prot_id]
      prot_ids[taxon_id] = [gene_id], [prot_id]
      pairwise_scores = [t_ortholog_set_pairwise_scores]
 

ortholog_set_pairwise_alignments[ancestor_node_id] = [t_ortholog_set_pairwise_alignment]
t_ortholog_set_pairwise_alignment
    cigar_line,
    perc_cov  ,
    perc_id   ,
    perc_pos  ,
         
 
--Download all homology_member 48,409,690
SELECT
      homology_id,
      member_id,
      peptide_member_id,
      cigar_line,
      perc_cov,
      perc_id,
      perc_pos
  FROM
      homology_member JOIN
      homology USING (homology_id)
  WHERE
      method_link_species_set_id =20848
  LIMIT 1; 
     ;

--+-------------+----------------+----------------+------------+----------+---------+----------+
--| homology_id | gene_member_id | prot_member_id | cigar_line | perc_cov | perc_id | perc_pos |
--+-------------+----------------+----------------+------------+----------+---------+----------+
--|           1 |         683742 |         683744 | 243M56D    |      100 |      77 |       78 |
--+-------------+----------------+----------------+------------+----------+---------+----------+
--Download all member 4,160,684
 SELECT
         member_id,
         stable_id,
         taxon_id
     FROM
         member; 
--+-----------+--------------------+----------+
--| member_id | stable_id          | taxon_id |
--+-----------+--------------------+----------+
--|         1 | ENSXETG00000001053 |     8364 |
--+-----------+--------------------+----------+

