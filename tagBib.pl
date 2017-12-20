# tagBib.pl

use strict;
use Roman;      # Roman.pm version 1.1 by OZAWA Sakuro <ozawa@aisoft.co.jp>

my $file = $ARGV[0];

# See: https://en.wikipedia.org/wiki/Books_of_the_Bible and http://www.aresearchguide.com/bibleabb.html

my $ot = "Gen[.]|Ex[.]|Exod[.]|Lev[.]|Num[.]|Deut[.]|Joshua|Judges|Ruth|1 Sam[.]|2 Sam[.]|1 Kings|2 Kings|1 Chron[.]|2 Chron[.]";
my $ot1 = "Ezra|Neh[.]|Esth[.]|Esther|Job|Ps[.]|Prov[.]|Eccl[.]|Eccles[.]|Song of Sol[.]|Isa[.]|Jer[.]|Lam[.]|Ezek[.]|Dan[.]|Hos[.]|Joel|Am[.]|Amos|Obad[.]|Jon[.]|Jonah|Mic[.]|Nah[.]|Nahum|Hab[.]|Zeph[.]|Hag[.]|Zech[.]|Mal[.]";
my $ot2 = "Genesis|Exodus|Leviticus|Numbers|Deuteronomy|1 Samuel|2 Samuel|1 Chronicles|2 Chronicles";
my $ot3 = "Nehemiah|Psalm|Psalms|Proverbs|Ecclesiastes|Song of Solomon|Song of Songs|Isaiah|Jeremiah|Lamentations|Ezekiel|Daniel|Obadiah|Micah|Habakkuk|Zephaniah|Haggai|Zechariah|Malachi";

my $nt = "Matt[.]|Mt[.]|Mk[.]|Mark|Lk[.]|Luke|Jn[.]|John|Acts|Rom[.]|1 Cor[.]|2 Cor[.]|Gal[.]|Eph[.]|Phil[.]|Col[.]|1 Thess[.]|2 Thess[.]|1 Tim[.]|2 Tim[.]|Titus|Philem[.]|Heb[.]|Jas[.]|1 Pet[.]|2 Pet[.]|1 John|2 John|3 John|Jude|Rev[.]|Apoc[.]";
my $nt1 = "Matthew|Romans|Acts of the Apostles|1 Corinthians|2 Corinthians|Galatians|Ephesians|Philippians|Colossians|1 Thessalonians|2 Thessalonians|1 Timothy|2 Timothy|Philemon|Hebrews|James|1 Peter|2 Peter|Revelation|Apocalypse";

my $ap = "1 Esdras|2 Esdras|Tob[.]|Tobit|Jdt[.]|Judith|Rest of Esth[.]|Wisd[.] of Sol[.]|Ecclus[.]|Baruch|Song of Three Childr[.]|Susanna|Bel and Dragon|Pr[.] of Manasses|1 Macc[.]|2 Macc[.]";
my $ap1 = "Rest of Esther|Wisdon|Wisdom of Solomon|Ecclesiasticus|Sir[.]|Sirach|1 Maccabees|2 Maccabees";

my $roman = "[clxviCLXVI]+";
my $bibcit = "($ot|$ot1|$ot2|$ot3|$nt|$nt1|$ap)(?: (?:($roman|[0-9]+))[.]?(?: ([0-9]+))?(?:(?:[&]ndash;|-)([0-9]+))?)";


my %normalizeHash = 
(
    "1 chr"             => "1chron",
    "1 chron"           => "1chron",
    "1 chronicles"      => "1chron",
    "1 cor"             => "1cor",
    "1 cor"             => "1cor",
    "1 corinthians"     => "1cor",
    "1 corinthians"     => "1cor",
    "1 esdras"          => "1esdras",
    "1 jn"              => "1jn",
    "1 john"            => "1jn",
    "1 kings"           => "1kings",
    "1 macc"            => "1macc",
    "1 maccabees"       => "1macc",
    "1 pet"             => "1pet",
    "1 peter"           => "1pet",
    "1 sam"             => "1sam",
    "1 samuel"          => "1sam",
    "1 thess"           => "1thess",
    "1 thessalonians"   => "1thess",
    "1 tim"             => "1tim",
    "1 timothy"         => "1tim",
    "2 chr"             => "2chron",
    "2 chron"           => "2chron",
    "2 chronicles"      => "2chron",
    "2 cor"             => "2cor",
    "2 cor"             => "2cor",
    "2 corinthians"     => "2cor",
    "2 corinthians"     => "2cor",
    "2 esdras"          => "2esdras",
    "2 jn"              => "2jn",
    "2 john"            => "2jn",
    "2 kings"           => "2kings",
    "2 macc"            => "2macc",
    "2 maccabees"       => "2macc",
    "2 pet"             => "2pet",
    "2 peter"           => "2pet",
    "2 sam"             => "2sam",
    "2 samuel"          => "2sam",
    "2 thess"           => "1thess",
    "2 thessalonians"   => "1thess",
    "2 tim"             => "2tim",
    "2 timothy"         => "2tim",
    "3 jn"              => "3jn",
    "3 john"            => "3jn",
    "acts of the apostles"  => "acts",
    "am"                => "am",
    "amos"              => "am",
    "apoc"              => "apoc",
    "apocalypse"        => "apoc",
    "baruch"            => "bar",
    "col"               => "col",
    "colossians"        => "col",
    "dan"               => "dan",
    "daniel"            => "dan",
    "deuteronomy"       => "deut",
    "eccles"            => "eccl",
    "ecclesiastes"      => "eccl",
    "eph"               => "eph",
    "ephesians"         => "eph",
    "ex"                => "exod",
    "exod"              => "exod",
    "exodus"            => "exod",
    "ezek"              => "ezek",
    "ezekial"           => "ezek",
    "ezra"              => "ezra",
    "gal"               => "gal",
    "galatians"         => "gal",
    "genesis"           => "gen", 
    "habakkuk"          => "hab",
    "haggai"            => "hag",
    "heb"               => "heb",
    "hebrews"           => "heb",
    "hos"               => "hos",
    "hosea"             => "hos",
    "isa"               => "isa",
    "isaiah"            => "isa",
    "james"             => "jas",
    "jas"               => "jas",
    "jer"               => "jer",
    "jeremiah"          => "jer",
    "joel"              => "joel",
    "john"              => "jn",
    "jon"               => "jon",
    "jonah"             => "jon",
    "jos"               => "josh",
    "joshua"            => "josh",
    "jude"              => "jude",
    "judges"            => "judg",
    "judith"            => "jdt",
    "lam"               => "lam",
    "lamentations"      => "lam",
    "leviticus"         => "lev", 
    "luke"              => "lk",
    "malachi"           => "mal",
    "mark"              => "mk",
    "matt"              => "mt",
    "matthew"           => "mt",
    "mic"               => "mic",
    "micah"             => "mic",
    "nahum"             => "nah",
    "neh"               => "neh",
    "neh"               => "neh",
    "nehemiah"          => "neh",
    "numbers"           => "num", 
    "obad"              => "obad",
    "obadiah"           => "obad",
    "phil"              => "phil",
    "philem"            => "philem",
    "philemon"          => "philem",
    "philippians"       => "phil",
    "proverbs"          => "prov",
    "psalm"             => "ps",
    "psalms"            => "ps",
    "rev"               => "rev",
    "revelation"        => "rev",
    "romans"            => "rom",
    "sirach"            => "sir",
    "song of sol"       => "song",
    "song of solomon"   => "song",
    "song of songs"     => "song",
    "tobit"             => "tob",
    "wisd of sol"       => "wis",
    "wisdom of solomon" => "wis",
    "wisdom"            => "wis",
    "zechariah"         => "zech",
    "zeph"              => "zeph",
    "zephaniah"         => "zeph"
);




open(INPUTFILE, $file) || die("Could not open input file $file");

while (<INPUTFILE>)
{
    my $remainder = $_;
    while ($remainder =~ /\b($bibcit)\b/i)
    {
        my $before = $`;

        my $citation = $1;
        my $book = $2;
        my $chapter = $3;
        my $verse = $4;
        my $toverse = $5;

        my $ref = makeReference($book, $chapter, $verse, $toverse);

        print $before;
        print "<xref url=\"bib:$ref\">$citation</xref>";
        $remainder = $';
    }
    print $remainder;
}


sub makeReference($$$$$)
{
    my $book = shift;
    my $chapter = shift;
    my $verse = shift;
    my $toverse = shift;

	$book = lc $book;
	$book =~ s/[.]//g;
	if (defined $normalizeHash{$book}) 
	{
		$book = $normalizeHash{$book}
	}

    if (defined $chapter and isroman($chapter))
    {
        $chapter = arabic($chapter);
    }

    my $result = "";
    if (length $book > 0) 
    { 
        $result .= $book;

        if (length $chapter > 0) 
        {
            $result .= " " . $chapter;

            if (length $verse > 0) 
            {
                $result .= ":" . $verse;
            
                if (length $toverse > 0) 
                {
                    $result .= "-" . $toverse;
                }
            }
        }
    }
    return $result;
}
