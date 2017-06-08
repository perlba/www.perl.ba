requires "Dancer2" => "0.166001";
requires 'Template';
requires 'Crypt::Eksblowfish::Bcrypt';
requires 'MIME::Base64';
requires 'MooX::Types::MooseLike::Base';
requires 'KiokuDB';
requires 'KiokuDB::Backend::Files';

recommends "YAML"             => "0";
recommends "URL::Encode::XS"  => "0";
recommends "CGI::Deurl::XS"   => "0";
recommends "HTTP::Parser::XS" => "0";

on "test" => sub {
    requires "Test::More"            => "0";
    requires "HTTP::Request::Common" => "0";
};
