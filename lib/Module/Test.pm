module Module::Test;

sub test(Str $dir = '.', Str $binary = 'perl6') is export {
    if $*VM<config><osname> ne 'MSWin32'
    && "$dir/Makefile".IO ~~ :f {
        run 'make test' and die "'make test' failed";
    }
    if "$dir/t".IO ~~ :d {
        my $command = "PERL6LIB=$dir/lib prove -e $binary -r $dir/t/";
        run $command or die 'Testing failed';
    }
}

# vim: ft=perl6
