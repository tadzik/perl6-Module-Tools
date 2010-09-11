use File::Copy;
use File::Find;
use File::Mkdir;

module Module::Install;

sub install(Str $dir = '.', Str $dest = "%*ENV<HOME>/.perl6/", :$v) is export {
    if $*VM<config><osname> ne 'MSWin32'
    && "$dir/Makefile".IO ~~ :f {
        run 'make install' and die "'make install' failed";
    } else {
        for find(dir => "$dir/lib", name => /[\.pm6?$] | [\.pir$]/).list -> $pmfile {
            my $target-dir = $pmfile.dir.subst(/\.\//, $dest);
            mkdir $target-dir, :p;
            say "Installing $pmfile" if $v.defined;
#            say "Starting copying $pmfile, sized {
#                $pmfile.Str.IO.stat.size} bytes";
#            my $t = time;
            cp ~$pmfile, "$target-dir/{$pmfile.name}";
#            say "Done copying, took {time() - $t} seconds";
        }
    }
}

# vim: ft=perl6
