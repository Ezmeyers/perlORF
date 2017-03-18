#!usr/bin/perl

# By: Elisabeth Meyers 10/23/16

require ("subroutines_for_a3.pm");

use strict;
use warnings;

# Lets get the input file
print("Please input a file to extract ORFs: ");
# remove trailing whitespace from input
chomp(my $in_file = (<STDIN>));

# get valid sequences
my $seq_list = ext_seq($in_file);

# extracting orfs from our valid sequence list
my @orfs = get_orfs($seq_list);

# lets translate the codons into amino acid sequences
my $codon;
my @peptides = ();

# this is where my time complexity gets really bad
# would like to rewrite this more efficiently
# I tried writing it without doing foreach and the time was
# just as slow. 

# count was for testing purposes
#my $count = 0;


#foreach $codon (@orfs){
	#$count++;
#	my $peptides = dna2peptide($codon);	
#	#print"$count\n";
#push @peptides, $peptides;

#}
my $longOrfs;
$longOrfs = join("", @orfs);
my $peptides = dna2peptide($longOrfs);

print "here";
my $pepCount = @peptides;
print "Number of peptide sequences extracted: $pepCount";


# output peptides to file
open(my $pep_file, ">", "peps.fa")|| die "Error: Cannot open peptide file";

print $pep_file "$_\n" for @peptides;

close $pep_file || warn "Cannot close peptide file: $!";



# this sub will extract all valid orfs, namely printing all
# orfs who will create amino sequences longer than 10.
sub get_orfs {

my ($list) = @_;

# will contain subset of orfs
    my @long_orfs = ();

# count valid orfs and their subset
    my $orfCount;
    my $longOrfCount;

# orf_num will hold the number of matches
# my@orfs will hold the orf values
# we check for a sequence that starts with ATG
# then we find multiples of 3 with a lazy check to stop at the first TAA/TGA/TAG

    my $orf_num = () = my @orfs = ($list =~ m/(ATG(?:.{3})*?(?:TAA|TGA|TAG))/ig);
# just printing the # of orfs extracted
    print "Valid orfs in this fasta file: $orf_num \n";

# subset or orfs which will create at least 10 amino acid sequences
    my $long_num = @long_orfs = grep { length>36} @orfs;
    print "Valid orfs that can produce >= 10 amino acids: $long_num\n";

    open(my $orfs_file, ">", "myOrfs.fa") || die "Error Cannot open ORF file";
 	print $orfs_file "$_\n" for @long_orfs;
    close $orfs_file || warn "Close orf file Failed: $!";

return @long_orfs;
}# end sub


# this sub will validate and extract valid sequences using regex
sub ext_seq {

my ($in_file) = @_;

# used to check each line in the file
    my $line;

# stores return value of sequence check function.
# if that function returned false -> the sequence is invalid
# and sequence will be ignored
    my $bool = 0;

# large string holding full valid sequences
    my $seq_list;

# opening the file
    open(my $fa, "<", $in_file) || die ("Error: cannot find file");

# read each line of file into $line
    while($line = <$fa>) {
        chomp($line);

# call function which uses regex to validate the line
        $bool = is_seq($line);

# if bool was true, seq was valid, concat to seq_list
        if($bool) {
            $seq_list .=$line;
        }
    }

# done with in_file, close file
    close $fa || warn "Close failed: $!";

# return good sequences
    return $seq_list;
}# end sub

# checks if the sequence is valid
sub is_seq {
    my ($checkLine) = @_;

# parsing fasta header that we know exists
# this was for my own parsing practice (grouping + this was not necessary)

    if ( $checkLine =~ m/^\>gi\|(\d+)\|ref\|(\S+)\|\s(\S.*)/) {
        return 0;
    }


# will do a global check if each character starts with A or T or C or G
    elsif($checkLine =~ m/[^(?:A|T|C|G)]/ig) {
        return 0;
    }

# sequence is valid
    else{
        return 1;
    }

}# end sub

exit;
