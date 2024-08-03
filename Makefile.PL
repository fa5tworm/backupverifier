use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'BackupVerifier',
    VERSION_FROM => 'lib/BackupVerifier.pm', # finds $VERSION
    AUTHOR       => 'Otmane Echaibi <sudotoo@protonmail.com>',
    ABSTRACT     => 'A module to verify the integrity of backup files.',
    LICENSE      => 'perl',
    PREREQ_PM    => {
        'Digest::SHA' => 0,
        'Carp'        => 0,
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
                type => 'git',
                url  => 'git://github.com/fa5tworm/BackupVerifier.git',
                web  => 'https://github.com/fa5tworm/BackupVerifier',
            },
            bugtracker => {
                web => 'https://github.com/fa5tworm/BackupVerifier/issues',
            },
        },
    },
);
