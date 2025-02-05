# A subroutine to translate a DNA 3-character codon to amino acid

sub codon2aa {
    my($codon) = @_;

    $codon = uc $codon;

    my(%genetic_code) = (

        'TCA' => 'S', # Serine
        'TCC' => 'S', # Serine
        'TCG' => 'S', # Serine
        'TCT' => 'S', # Serine
        'TTC' => 'F', # Phenylalanine
        'TTT' => 'F', # Phenylalanine
        'TTA' => 'L', # Leucine
        'TTG' => 'L', # Leucine
        'TAC' => 'Y', # Tyrosine
        'TAT' => 'Y', # Tyrosine
        'TAA' => '_', # Stop
        'TAG' => '_', # Stop
        'TGC' => 'C', # Cysteine
        'TGT' => 'C', # Cysteine
        'TGA' => '_', # Stop
        'TGG' => 'W', # Tryptophan
        'CTA' => 'L', # Leucine
        'CTC' => 'L', # Leucine
        'CTG' => 'L', # Leucine
        'CTT' => 'L', # Leucine
        'CCA' => 'P', # Proline
        'CCC' => 'P', # Proline
        'CCG' => 'P', # Proline
        'CCT' => 'P', # Proline
        'CAC' => 'H', # Histadine
        'CAT' => 'H', # Histadine
        'CAA' => 'Q', # Glutamine
        'CAG' => 'Q', # Glutamine
        'CGA' => 'R', # Arginine
        'CGC' => 'R', # Arginine
        'CGG' => 'R', # Arginine
        'CGT' => 'R', # Arginine
        'ATA' => 'I', # Isoleucine
        'ATC' => 'I', # Isoleucine
        'ATT' => 'I', # Isoleucine
        'ATG' => 'M', # Methionine
        'ACA' => 'T', # Threonine
        'ACC' => 'T', # Threonine
        'ACG' => 'T', # Threonine
        'ACT' => 'T', # Threonine
        'AAC' => 'N', # Asparagine
        'AAT' => 'N', # Asparagine
        'AAA' => 'K', # Lysine
        'AAG' => 'K', # Lysine
        'AGC' => 'S', # Serine
        'AGT' => 'S', # Serine
        'AGA' => 'R', # Arginine
        'AGG' => 'R', # Arginine
        'GTA' => 'V', # Valine
        'GTC' => 'V', # Valine
        'GTG' => 'V', # Valine
        'GTT' => 'V', # Valine
        'GCA' => 'A', # Alanine
        'GCC' => 'A', # Alanine
        'GCG' => 'A', # Alanine
        'GCT' => 'A', # Alanine
        'GAC' => 'D', # Aspartic Acid
        'GAT' => 'D', # Aspartic Acid
        'GAA' => 'E', # Glutamic Acid
        'GAG' => 'E', # Glutamic Acid
        'GGA' => 'G', # Glycine
        'GGC' => 'G', # Glycine
        'GGG' => 'G', # Glycine
        'GGT' => 'G', # Glycine
    );
    if(exists $genetic_code{$codon}) {
        return $genetic_code{$codon};
    }
    else{
        print STDERR "Bad codon \"$codon\"!!\n";
        exit;
    }

}

# dna2peptide
#
# A Subroutine to translate DNA sequence into a peptide

sub dna2peptide {

   my($dna) = @_;

# initialize variables
    my $protein = '';
# Translate each three-base codon to an amino acid & append to protein
    for(my $i=0; $i< (length($dna) - 2); $i=$i+3) {

	$protein .= codon2aa( substr($dna,$i,3) );
    }
    return $protein;
}
1;
