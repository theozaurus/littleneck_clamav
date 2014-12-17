Littleneck ClamAV [![Build status](https://secure.travis-ci.org/theozaurus/littleneck_clamav.png)](http://travis-ci.org/theozaurus/littleneck_clamav)
=================

[Littleneck ClamAV](http://github.com/theozaurus/littleneck_clamav) is a thin
wrapper to make it quick and easy to use [ClamAV](http://www.clamav.net) within
Ruby.

It will use `clamdscan` if available to save load time, or fallback to
`clamscan` if it is not. Compilation is avoided by using the command line
interface of ClamAV, and as such Littleneck expects a working and up to date
ClamAV installation.

Requirements
============

It is currently fully tested against:

 - Ruby 1.9.3
 - Ruby 2.0.0
 - Ruby 2.1.2

Usage
=====

To scan a file:

    scanner = LittleneckClamAV.new
    result = scanner.scan "jeepers.txt"
    result.clean?
    => false
    result.infected?
    => true
    result.description
    => "HLLP.Creeper.5127"
    result.path
    => "jeepers.txt"

To find out about the scanners database

    scanner.database_version
    => 15306
    scanner.database_date
    => 2012-08-28 20:18:12 +00:00
    scanner.engine
    => "0.97.5"

You can specify a specific scanner to use as well

    scanner = LittleneckClamAV::Clam.new
    # or
    scanner = LittleneckClamAV::Clamd.new

