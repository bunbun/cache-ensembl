# cache\_ensembl_#
is a python library which encapsulates various data in the ensembl database for fast processing._

Because all the data for each genome is loaded at once, genome-wide bioinformatics analyses can be carried out with ease.

The design is to store database data as python lists or dictionaries indexed by (external, stable) Ensembl identifiers, such as gene or peptide or transcript IDs.

Currently available modules include:
  * # core protein features #
> > Domain and other annotations for each peptide from the core (per species / gene build) database

  * # compara ncbi taxa #
> > ncbi taxonomy held in the compara database

  * # compara orthology #
> > Orthology predictions between genes of a pair of species from the compara database

  * # compara protein tree #
> > Phlyogenetic trees for peptides for all species in the compara database. These are the basis of the pairwise orthology predictions.