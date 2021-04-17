
open F, "../data/dblpfulltext-links.txt";
while (<F>) {
    print;
    if (/url = .(http.*)\'/) {
        my $url = $1;
        my $doi = "";
            
        if ($url =~ /.*(10\.\d+\/.*)\'?/) {
            $doi = $1;
        } else {
            my $out = scall("\"C:\\Program Files\\MySQL\\MySQL Workbench 8.0 CE\\mysql.exe\" -u root --password=root -e \"select distinct doi from f_dblp where url = \'$1\'\" dblp 1> out 2> out2");
            if ($out =~ /.*(10\.\d+\/.*)\n?/) {
                $doi = $1;
            }
        }
        print "DOI " . $doi . "\n\n";
    }
}
close F;

sub scall {
    my $cmd = shift;
    my $outfile = "out";
    unlink $outfile if (-f $outfile);
    my $output = "";
    system($cmd);
    open O, $outfile;
    while (<O>) {
        $output .= $_;
    }
    close O;
    return $output;
}
