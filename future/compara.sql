CREATE TABLE `analysis` (
  `analysis_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `logic_name` varchar(40) NOT NULL,
  `db` varchar(120) DEFAULT NULL,
  `db_version` varchar(40) DEFAULT NULL,
  `db_file` varchar(255) DEFAULT NULL,
  `program` varchar(255) DEFAULT NULL,
  `program_version` varchar(40) DEFAULT NULL,
  `program_file` varchar(255) DEFAULT NULL,
  `parameters` text,
  `module` varchar(80) DEFAULT NULL,
  `module_version` varchar(40) DEFAULT NULL,
  `gff_source` varchar(40) DEFAULT NULL,
  `gff_feature` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`analysis_id`),
  UNIQUE KEY `logic_name` (`logic_name`),
  KEY `logic_name_idx` (`logic_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `analysis_description` (
  `analysis_id` int(10) unsigned NOT NULL,
  `description` text,
  `display_label` varchar(255) DEFAULT NULL,
  `displayable` tinyint(1) NOT NULL DEFAULT '1',
  `web_data` text,
  UNIQUE KEY `analysis_idx` (`analysis_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `conservation_score` (
  `genomic_align_block_id` bigint(20) unsigned NOT NULL,
  `window_size` smallint(5) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `expected_score` blob,
  `diff_score` blob,
  KEY `genomic_align_block_id` (`genomic_align_block_id`,`window_size`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=15000000 AVG_ROW_LENGTH=841;
 
CREATE TABLE `constrained_element` (
  `constrained_element_id` bigint(20) unsigned NOT NULL,
  `dnafrag_id` bigint(20) unsigned NOT NULL,
  `dnafrag_start` int(12) unsigned NOT NULL,
  `dnafrag_end` int(12) unsigned NOT NULL,
  `dnafrag_strand` int(2) DEFAULT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `p_value` mediumtext,
  `taxonomic_level` mediumtext,
  `score` double NOT NULL DEFAULT '0',
  KEY `dnafrag_id` (`dnafrag_id`),
  KEY `constrained_element_id_idx` (`constrained_element_id`),
  KEY `mlssid_idx` (`method_link_species_set_id`),
  KEY `mlssid_dfId_dfStart_dfEnd_idx` (`method_link_species_set_id`,`dnafrag_id`,`dnafrag_start`,`dnafrag_end`),
  KEY `mlssid_dfId_idx` (`method_link_species_set_id`,`dnafrag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `dnafrag` (
  `dnafrag_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `length` int(11) NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL DEFAULT '',
  `genome_db_id` int(10) unsigned NOT NULL DEFAULT '0',
  `coord_system_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`dnafrag_id`),
  UNIQUE KEY `name` (`genome_db_id`,`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4680000066046 DEFAULT CHARSET=latin1;
 
CREATE TABLE `dnafrag_region` (
  `synteny_region_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dnafrag_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dnafrag_start` int(10) unsigned NOT NULL DEFAULT '0',
  `dnafrag_end` int(10) unsigned NOT NULL DEFAULT '0',
  `dnafrag_strand` tinyint(4) NOT NULL DEFAULT '0',
  KEY `synteny` (`synteny_region_id`,`dnafrag_id`),
  KEY `synteny_reversed` (`dnafrag_id`,`synteny_region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `domain` (
  `domain_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stable_id` varchar(40) NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `stable_id` (`stable_id`,`method_link_species_set_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `domain_member` (
  `domain_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `member_start` int(10) DEFAULT NULL,
  `member_end` int(10) DEFAULT NULL,
  UNIQUE KEY `domain_id` (`domain_id`,`member_id`,`member_start`,`member_end`),
  UNIQUE KEY `member_id` (`member_id`,`domain_id`,`member_start`,`member_end`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `family` (
  `family_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stable_id` varchar(40) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `description_score` double DEFAULT NULL,
  PRIMARY KEY (`family_id`),
  UNIQUE KEY `stable_id` (`stable_id`),
  KEY `method_link_species_set_id` (`method_link_species_set_id`),
  KEY `description` (`description`)
) ENGINE=MyISAM AUTO_INCREMENT=529767 DEFAULT CHARSET=latin1;
 
CREATE TABLE `family_member` (
  `family_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `cigar_line` mediumtext,
  UNIQUE KEY `family_member_id` (`family_id`,`member_id`),
  KEY `family_id` (`family_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `genome_db` (
  `genome_db_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `taxon_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL DEFAULT '',
  `assembly` varchar(100) NOT NULL DEFAULT '',
  `assembly_default` tinyint(1) DEFAULT '1',
  `genebuild` varchar(100) NOT NULL DEFAULT '',
  `locator` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`genome_db_id`),
  UNIQUE KEY `name` (`name`,`assembly`,`genebuild`),
  KEY `taxon_id` (`taxon_id`)
) ENGINE=MyISAM AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;
 
CREATE TABLE `genomic_align` (
  `genomic_align_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `genomic_align_block_id` bigint(20) unsigned NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dnafrag_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dnafrag_start` int(10) NOT NULL DEFAULT '0',
  `dnafrag_end` int(10) NOT NULL DEFAULT '0',
  `dnafrag_strand` tinyint(4) NOT NULL DEFAULT '0',
  `cigar_line` mediumtext,
  `level_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`genomic_align_id`),
  KEY `genomic_align_block_id` (`genomic_align_block_id`),
  KEY `method_link_species_set_id` (`method_link_species_set_id`),
  KEY `dnafrag` (`dnafrag_id`,`method_link_species_set_id`,`dnafrag_start`,`dnafrag_end`)
) ENGINE=MyISAM AUTO_INCREMENT=4690000200415 DEFAULT CHARSET=latin1 MAX_ROWS=1000000000 AVG_ROW_LENGTH=60;
 
CREATE TABLE `genomic_align_block` (
  `genomic_align_block_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `method_link_species_set_id` int(10) unsigned NOT NULL DEFAULT '0',
  `score` double DEFAULT NULL,
  `perc_id` tinyint(3) unsigned DEFAULT NULL,
  `length` int(10) DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`genomic_align_block_id`),
  KEY `method_link_species_set_id` (`method_link_species_set_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4690000014024 DEFAULT CHARSET=latin1;
 
CREATE TABLE `genomic_align_group` (
  `node_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `genomic_align_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `genomic_align_id` (`genomic_align_id`),
  KEY `node_id` (`node_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4680000171567 DEFAULT CHARSET=latin1;
 
CREATE TABLE `genomic_align_tree` (
  `node_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `root_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `left_index` int(10) NOT NULL DEFAULT '0',
  `right_index` int(10) NOT NULL DEFAULT '0',
  `left_node_id` bigint(10) NOT NULL DEFAULT '0',
  `right_node_id` bigint(10) NOT NULL DEFAULT '0',
  `distance_to_parent` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`node_id`),
  KEY `parent_id` (`parent_id`),
  KEY `root_id` (`root_id`),
  KEY `left_index` (`left_index`),
  KEY `right_index` (`right_index`)
) ENGINE=MyISAM AUTO_INCREMENT=4680000171567 DEFAULT CHARSET=latin1;
 
CREATE TABLE `homology` (
  `homology_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stable_id` varchar(40) DEFAULT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `description` enum('ortholog_one2one','apparent_ortholog_one2one','ortholog_one2many','ortholog_many2many','within_species_paralog','other_paralog','putative_gene_split','contiguous_gene_split','between_species_paralog','possible_ortholog','UBRH','BRH','MBRH','RHS') DEFAULT NULL,
  `subtype` varchar(40) NOT NULL DEFAULT '',
  `dn` float(10,5) DEFAULT NULL,
  `ds` float(10,5) DEFAULT NULL,
  `n` float(10,1) DEFAULT NULL,
  `s` float(10,1) DEFAULT NULL,
  `lnl` float(10,3) DEFAULT NULL,
  `threshold_on_ds` float(10,5) DEFAULT NULL,
  `ancestor_node_id` int(10) unsigned NOT NULL,
  `tree_node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`homology_id`),
  KEY `method_link_species_set_id` (`method_link_species_set_id`),
  KEY `tree_node_id` (`tree_node_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1000405923 DEFAULT CHARSET=latin1;
 
CREATE TABLE `homology_member` (
  `homology_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `peptide_member_id` int(10) unsigned DEFAULT NULL,
  `peptide_align_feature_id` int(10) unsigned DEFAULT NULL,
  `cigar_line` mediumtext,
  `cigar_start` int(10) DEFAULT NULL,
  `cigar_end` int(10) DEFAULT NULL,
  `perc_cov` int(10) DEFAULT NULL,
  `perc_id` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  UNIQUE KEY `homology_member_id` (`homology_id`,`member_id`),
  KEY `homology_id` (`homology_id`),
  KEY `member_id` (`member_id`),
  KEY `peptide_member_id` (`peptide_member_id`),
  KEY `peptide_align_feature_id` (`peptide_align_feature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=300000000;
 
CREATE TABLE `lr_index_offset` (
  `table_name` varchar(64) NOT NULL,
  `lr_index` int(10) unsigned NOT NULL,
  PRIMARY KEY (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `mapping_session` (
  `mapping_session_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('family','tree') DEFAULT NULL,
  `when_mapped` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rel_from` int(10) unsigned DEFAULT NULL,
  `rel_to` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`mapping_session_id`),
  UNIQUE KEY `type` (`type`,`rel_from`,`rel_to`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
 
CREATE TABLE `member` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stable_id` varchar(128) NOT NULL,
  `version` int(10) DEFAULT '0',
  `source_name` enum('ENSEMBLGENE','ENSEMBLPEP','Uniprot/SPTREMBL','Uniprot/SWISSPROT','ENSEMBLTRANS','EXTERNALCDS') NOT NULL,
  `taxon_id` int(10) unsigned NOT NULL,
  `genome_db_id` int(10) unsigned DEFAULT NULL,
  `sequence_id` int(10) unsigned DEFAULT NULL,
  `gene_member_id` int(10) unsigned DEFAULT NULL,
  `description` text,
  `chr_name` char(40) DEFAULT NULL,
  `chr_start` int(10) DEFAULT NULL,
  `chr_end` int(10) DEFAULT NULL,
  `chr_strand` tinyint(1) NOT NULL,
  `display_label` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `source_stable_id` (`stable_id`,`source_name`),
  KEY `taxon_id` (`taxon_id`),
  KEY `stable_id` (`stable_id`),
  KEY `source_name` (`source_name`),
  KEY `sequence_id` (`sequence_id`),
  KEY `gene_member_id` (`gene_member_id`),
  KEY `gdb_name_start_end` (`genome_db_id`,`chr_name`,`chr_start`,`chr_end`)
) ENGINE=MyISAM AUTO_INCREMENT=200386150 DEFAULT CHARSET=latin1 MAX_ROWS=100000000;
 
CREATE TABLE `meta` (
  `meta_id` int(11) NOT NULL AUTO_INCREMENT,
  `species_id` int(10) unsigned DEFAULT '1',
  `meta_key` varchar(40) NOT NULL,
  `meta_value` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`meta_id`),
  UNIQUE KEY `species_key_value_idx` (`species_id`,`meta_key`,`meta_value`),
  KEY `species_value_idx` (`species_id`,`meta_value`)
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=latin1;
 
CREATE TABLE `method_link` (
  `method_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT '',
  `class` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`method_link_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=502 DEFAULT CHARSET=latin1;
 
CREATE TABLE `method_link_species_set` (
  `method_link_species_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method_link_id` int(10) unsigned DEFAULT NULL,
  `species_set_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `source` varchar(255) NOT NULL DEFAULT 'ensembl',
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`method_link_species_set_id`),
  UNIQUE KEY `method_link_id` (`method_link_id`,`species_set_id`)
) ENGINE=MyISAM AUTO_INCREMENT=50021 DEFAULT CHARSET=latin1;
 
CREATE TABLE `nc_profile` (
  `model_id` varchar(10) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `type` varchar(40) NOT NULL DEFAULT 'ncrna',
  `hc_profile` mediumtext,
  PRIMARY KEY (`model_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `nc_tree_member` (
  `node_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `cigar_line` mediumtext,
  `cigar_start` int(10) DEFAULT NULL,
  `cigar_end` int(10) DEFAULT NULL,
  UNIQUE KEY `node_id` (`node_id`),
  KEY `root_id` (`root_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `nc_tree_node` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `clusterset_id` int(10) unsigned NOT NULL,
  `left_index` int(10) NOT NULL,
  `right_index` int(10) NOT NULL,
  `distance_to_parent` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`node_id`),
  KEY `parent_id` (`parent_id`),
  KEY `root_id` (`root_id`),
  KEY `left_index` (`left_index`),
  KEY `right_index` (`right_index`)
) ENGINE=MyISAM AUTO_INCREMENT=124789 DEFAULT CHARSET=latin1;
 
CREATE TABLE `nc_tree_tag` (
  `node_id` int(10) unsigned NOT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `value` mediumtext,
  UNIQUE KEY `tag_node_id` (`node_id`,`tag`),
  KEY `node_id` (`node_id`),
  KEY `tag` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `ncbi_taxa_name` (
  `taxon_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `name_class` varchar(50) DEFAULT NULL,
  KEY `taxon_id` (`taxon_id`),
  KEY `name` (`name`),
  KEY `name_class` (`name_class`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `ncbi_taxa_node` (
  `taxon_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `rank` char(32) NOT NULL DEFAULT '',
  `genbank_hidden_flag` tinyint(1) NOT NULL DEFAULT '0',
  `left_index` int(10) NOT NULL,
  `right_index` int(10) NOT NULL,
  `root_id` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`taxon_id`),
  KEY `parent_id` (`parent_id`),
  KEY `rank` (`rank`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `peptide_align_feature` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`),
  KEY `hmember_hit` (`hmember_id`,`hit_rank`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_anolis_carolinensis_88` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10088678 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_bos_taurus_64` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12934388 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_caenorhabditis_elegans_103` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4807867 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133
/*!50100 PARTITION BY LINEAR HASH (peptide_align_feature_id)
PARTITIONS 50 */;
 
CREATE TABLE `peptide_align_feature_callithrix_jacchus_102` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10023811 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133
/*!50100 PARTITION BY LINEAR HASH (peptide_align_feature_id)
PARTITIONS 50 */;
 
CREATE TABLE `peptide_align_feature_canis_familiaris_39` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
 `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11998590 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_cavia_porcellus_69` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11300576 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_choloepus_hoffmanni_78` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6888018 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_ciona_intestinalis_18` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4978078 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_ciona_savignyi_27` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4154135 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_danio_rerio_89` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11654364 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133
/*!50100 PARTITION BY LINEAR HASH (peptide_align_feature_id)
PARTITIONS 50 */;
 
CREATE TABLE `peptide_align_feature_dasypus_novemcinctus_86` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8342888 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_dipodomys_ordii_83` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9597586 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_drosophila_melanogaster_95` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6359070 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_echinops_telfairi_33` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9282133 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_equus_caballus_61` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12125537 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_erinaceus_europaeus_49` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8355178 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_felis_catus_66` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8659897 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_gallus_gallus_42` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9100619 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_gasterosteus_aculeatus_36` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12575615 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_gorilla_gorilla_101` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9946049 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133
/*!50100 PARTITION BY LINEAR HASH (peptide_align_feature_id)
PARTITIONS 50 */;
 
CREATE TABLE `peptide_align_feature_homo_sapiens_90` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10906073 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133
/*!50100 PARTITION BY LINEAR HASH (peptide_align_feature_id)
PARTITIONS 50 */;
 
CREATE TABLE `peptide_align_feature_loxodonta_africana_98` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12624332 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_macaca_mulatta_31` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12415447 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_macropus_eugenii_91` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9320494 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_microcebus_murinus_58` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9584284 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_monodelphis_domestica_46` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12417842 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_mus_musculus_57` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12580461 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_myotis_lucifugus_53` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9351510 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_ochotona_princeps_67` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9462974 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_orig` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`),
  UNIQUE KEY `member` (`hmember_id`,`hit_rank`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_ornithorhynchus_anatinus_43` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9018444 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_oryctolagus_cuniculus_99` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10469870 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_oryzias_latipes_37` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11627777 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_otolemur_garnettii_51` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8826142 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_pan_troglodytes_38` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12255240 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_pongo_pygmaeus_60` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
 `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11632579 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_procavia_capensis_79` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9689119 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_pteropus_vampyrus_85` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10641758 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_rattus_norvegicus_3` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13409810 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_saccharomyces_cerevisiae_44` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1399869 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_sorex_araneus_55` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7517773 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_spermophilus_tridecemlineatus_52` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8357526 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_sus_scrofa_93` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10069742 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_taeniopygia_guttata_87` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9645206 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_takifugu_rubripes_4` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12599942 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_tarsius_syrichta_82` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7874586 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_tetraodon_nigroviridis_65` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
 `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12092416 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_tupaia_belangeri_48` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8709236 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_tursiops_truncatus_80` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10307595 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_vicugna_pacos_84` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6617924 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `peptide_align_feature_xenopus_tropicalis_16` (
  `peptide_align_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qmember_id` int(10) unsigned NOT NULL,
  `hmember_id` int(10) unsigned NOT NULL,
  `qgenome_db_id` int(10) unsigned NOT NULL,
  `hgenome_db_id` int(10) unsigned NOT NULL,
  `analysis_id` int(10) unsigned NOT NULL,
  `qstart` int(10) NOT NULL DEFAULT '0',
  `qend` int(10) NOT NULL DEFAULT '0',
  `hstart` int(11) NOT NULL DEFAULT '0',
  `hend` int(11) NOT NULL DEFAULT '0',
  `score` double(16,4) NOT NULL DEFAULT '0.0000',
  `evalue` double DEFAULT NULL,
  `align_length` int(10) DEFAULT NULL,
  `identical_matches` int(10) DEFAULT NULL,
  `perc_ident` int(10) DEFAULT NULL,
  `positive_matches` int(10) DEFAULT NULL,
  `perc_pos` int(10) DEFAULT NULL,
  `hit_rank` int(10) DEFAULT NULL,
  `cigar_line` mediumtext,
  PRIMARY KEY (`peptide_align_feature_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10196922 DEFAULT CHARSET=latin1 MAX_ROWS=300000000 AVG_ROW_LENGTH=133;
 
CREATE TABLE `protein_tree_hmmprofile` (
  `node_id` int(10) unsigned NOT NULL,
  `type` varchar(40) NOT NULL DEFAULT '',
  `hmmprofile` mediumtext,
  UNIQUE KEY `type_node_id` (`type`,`node_id`),
  KEY `node_id` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `protein_tree_member` (
  `node_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `cigar_line` mediumtext,
  `cigar_start` int(10) DEFAULT NULL,
  `cigar_end` int(10) DEFAULT NULL,
  UNIQUE KEY `node_id` (`node_id`),
  KEY `root_id` (`root_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `protein_tree_member_score` (
  `node_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `cigar_line` mediumtext,
  `cigar_start` int(10) DEFAULT NULL,
  `cigar_end` int(10) DEFAULT NULL,
  UNIQUE KEY `node_id` (`node_id`),
  KEY `root_id` (`root_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `protein_tree_node` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `clusterset_id` int(10) unsigned NOT NULL,
  `left_index` int(10) NOT NULL,
  `right_index` int(10) NOT NULL,
  `distance_to_parent` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`node_id`),
  KEY `parent_id` (`parent_id`),
  KEY `root_id` (`root_id`),
  KEY `left_index` (`left_index`),
  KEY `right_index` (`right_index`)
) ENGINE=MyISAM AUTO_INCREMENT=1948689 DEFAULT CHARSET=latin1;
 
CREATE TABLE `protein_tree_stable_id` (
  `node_id` int(10) unsigned NOT NULL,
  `stable_id` varchar(40) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  PRIMARY KEY (`node_id`),
  UNIQUE KEY `stable_id` (`stable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `protein_tree_tag` (
  `node_id` int(10) unsigned NOT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `value` mediumtext,
  UNIQUE KEY `tag_node_id` (`node_id`,`tag`),
  KEY `node_id` (`node_id`),
  KEY `tag` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `sequence` (
  `sequence_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `length` int(10) NOT NULL,
  `sequence` longtext NOT NULL,
  PRIMARY KEY (`sequence_id`),
  KEY `sequence` (`sequence`(18))
) ENGINE=MyISAM AUTO_INCREMENT=200169664 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=19000;
 
CREATE TABLE `sequence_cds` (
  `sequence_cds_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `length` int(10) NOT NULL,
  `sequence_cds` longtext NOT NULL,
  PRIMARY KEY (`sequence_cds_id`),
  KEY `member_id` (`member_id`),
  KEY `sequence_cds` (`sequence_cds`(64))
) ENGINE=MyISAM AUTO_INCREMENT=1167792 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=60000;
 
CREATE TABLE `sequence_exon_bounded` (
  `sequence_exon_bounded_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `length` int(10) NOT NULL,
  `sequence_exon_bounded` longtext NOT NULL,
  PRIMARY KEY (`sequence_exon_bounded_id`),
  KEY `member_id` (`member_id`),
  KEY `sequence_exon_bounded` (`sequence_exon_bounded`(18))
) ENGINE=MyISAM AUTO_INCREMENT=1167792 DEFAULT CHARSET=latin1 MAX_ROWS=10000000 AVG_ROW_LENGTH=19000;
 
CREATE TABLE `sitewise_aln` (
  `sitewise_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aln_position` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  `tree_node_id` int(10) unsigned NOT NULL,
  `omega` float(10,5) DEFAULT NULL,
  `omega_lower` float(10,5) DEFAULT NULL,
  `omega_upper` float(10,5) DEFAULT NULL,
  `optimal` float(10,5) DEFAULT NULL,
  `ncod` int(10) DEFAULT NULL,
  `threshold_on_branch_ds` float(10,5) DEFAULT NULL,
  `type` enum('single_character','random','all_gaps','constant','default','negative1','negative2','negative3','negative4','positive1','positive2','positive3','positive4','synonymous') NOT NULL,
  PRIMARY KEY (`sitewise_id`),
  UNIQUE KEY `aln_position_node_id_ds` (`aln_position`,`node_id`,`threshold_on_branch_ds`),
  KEY `tree_node_id` (`tree_node_id`),
  KEY `node_id` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `species_set` (
  `species_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `genome_db_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`species_set_id`,`genome_db_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33012 DEFAULT CHARSET=latin1;
 
CREATE TABLE `species_set_tag` (
  `species_set_id` int(10) unsigned NOT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `value` mediumtext,
  UNIQUE KEY `tag_species_set_id` (`species_set_id`,`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `stable_id_history` (
  `mapping_session_id` int(10) unsigned NOT NULL,
  `stable_id_from` varchar(40) NOT NULL DEFAULT '',
  `version_from` int(10) unsigned DEFAULT NULL,
  `stable_id_to` varchar(40) NOT NULL DEFAULT '',
  `version_to` int(10) unsigned DEFAULT NULL,
  `contribution` float DEFAULT NULL,
  PRIMARY KEY (`mapping_session_id`,`stable_id_from`,`stable_id_to`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `subset` (
  `subset_id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `dump_loc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`subset_id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
 
CREATE TABLE `subset_member` (
  `subset_id` int(10) NOT NULL,
  `member_id` int(10) NOT NULL,
  UNIQUE KEY `subset_member_id` (`subset_id`,`member_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `super_protein_tree_member` (
  `node_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  `cigar_line` mediumtext,
  `cigar_start` int(10) DEFAULT NULL,
  `cigar_end` int(10) DEFAULT NULL,
  UNIQUE KEY `node_id` (`node_id`),
  KEY `root_id` (`root_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `super_protein_tree_node` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `root_id` int(10) unsigned NOT NULL,
  `clusterset_id` int(10) unsigned NOT NULL,
  `left_index` int(10) NOT NULL,
  `right_index` int(10) NOT NULL,
  `distance_to_parent` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`node_id`),
  KEY `parent_id` (`parent_id`),
  KEY `root_id` (`root_id`),
  KEY `left_index` (`left_index`),
  KEY `right_index` (`right_index`)
) ENGINE=MyISAM AUTO_INCREMENT=1769940 DEFAULT CHARSET=latin1;
 
CREATE TABLE `super_protein_tree_tag` (
  `node_id` int(10) unsigned NOT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `value` mediumtext,
  UNIQUE KEY `tag_node_id` (`node_id`,`tag`),
  KEY `node_id` (`node_id`),
  KEY `tag` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
 
CREATE TABLE `synteny_region` (
  `synteny_region_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method_link_species_set_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`synteny_region_id`),
  KEY `method_link_species_set_id` (`method_link_species_set_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38179 DEFAULT CHARSET=latin1;
  
