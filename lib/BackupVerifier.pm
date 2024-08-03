package BackupVerifier;

use strict;
use warnings;
use Digest::SHA qw(sha256_hex);
use Carp;

our $VERSION = '1.0';

# Constructor
sub new {
    my ($class) = @_;
    return bless {}, $class;
}

# Method to calculate the SHA-256 checksum of a file
sub calculate_checksum {
    my ($self, $file_path) = @_;

    open my $fh, '<', $file_path or croak "Could not open file '$file_path': $!";
    binmode $fh;
    
    my $sha = Digest::SHA->new(256);
    $sha->addfile($fh);
    
    close $fh;

    return $sha->hexdigest;
}

# Method to verify the checksum of a file
sub verify_checksum {
    my ($self, $file_path, $expected_checksum) = @_;
    my $actual_checksum = $self->calculate_checksum($file_path);

    if ($actual_checksum eq $expected_checksum) {
        return 1; # Checksums match
    } else {
        return 0; # Checksums do not match
    }
}

1;

__END__

=head1 NAME

BackupVerifier - A module to verify the integrity of backup files.

=head1 SYNOPSIS

    use BackupVerifier;

    my $verifier = BackupVerifier->new();
    
    my $checksum = $verifier->calculate_checksum('path/to/backup.tar.gz');
    print "Checksum: $checksum\n";
    
    my $is_valid = $verifier->verify_checksum('path/to/backup.tar.gz', 'expected_checksum_value');
    if ($is_valid) {
        print "Backup is valid.\n";
    } else {
        print "Backup is corrupted.\n";
    }

=head1 DESCRIPTION

The C<BackupVerifier> module provides methods to calculate and verify the SHA-256 checksum of files. This is useful for ensuring the integrity of backup files.

=head1 METHODS

=head2 new

    my $verifier = BackupVerifier->new();

Creates a new C<BackupVerifier> object.

=head2 calculate_checksum

    my $checksum = $verifier->calculate_checksum('path/to/file');

Calculates the SHA-256 checksum of the specified file.

=head2 verify_checksum

    my $is_valid = $verifier->verify_checksum('path/to/file', 'expected_checksum');

Verifies the SHA-256 checksum of the specified file against the expected checksum. Returns 1 if the checksums match, otherwise returns 0.

=head1 AUTHOR

Your Name, C<< <your_email@example.com> >>

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut
