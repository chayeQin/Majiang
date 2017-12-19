<?php

require_once(__DIR__ . '/quick/FilesPackerList.php');

$options = array(
    array('h',   'help',       0,      false,       'show help'),
    array('i',   'src',        1,      null,        'source files directory'),
    array('o',   'output',     1,      null,        'output directory'),
    array('c',   'config',     1,      null,        'config filename'),
    array('t',   'trans',     1,      null,        'trans type'),
    array('f',   'filter',     1,      null,        'filter'),
    array('q',   'quiet',      0,      false,       'quiet'),
);


function errorhelp()
{
    print("\nshow help:\n    pack_files -h\n\n");
}

function help()
{
    global $options;

    echo <<<EOT

usage: pack_files -i src -o output ...

options:

EOT;

    for ($i = 0; $i < count($options); $i++)
    {
        $o = $options[$i];
        printf("    -%s %s\n", $o[0], $o[4]);
    }

    echo <<<EOT

pack mode:
    -m zip                  package all files to a ZIP archive file and encrypt.
    -m files (default)  save encrypted files to separate files. -o specifies output dir.
                        * default encrypt sign is "XXTEA"

config file format:

    return array(
        'src'      => source files directory,
        'output'   => output filename or output directory,
        'prefix'   => package prefix name,
        'excludes' => excluded packages,
        'pack'  => pack mode,
        'key'      => encrypt key,
        'sign'     => encrypt sign,
    );

examples:

    # encrypt res/*.* to resnew/, with XXTEA, specifies sign
    pack_files -i res -o resnew -ek XXTEA -es tsts

    # package res/*.* to game.zip
    pack_files -i res -o game.zip -m zip

    # package scripts/*.* to game.zip, encrypt game.zip with XXTEA, specifies sign
    pack_files -i scripts -o game.zip -m zip -ek XXTEA -es tsts

    # load options from config file
    pack_files -c my_config.lua


EOT;

}

// ----

print("\n");
if ($argc < 2)
{
    help();
    return(1);
}

$config = fetchCommandLineArguments($argv, $options, 4);
if (!$config)
{
    errorhelp();
    return(1);
}

if ($config['help'])
{
    help();
    return(0);
}

$packer = new FilesPackerList($config, $options);
if ($packer->validateConfig())
{
    return($packer->run());
}
else
{
    errorhelp();
    return(1);
}
