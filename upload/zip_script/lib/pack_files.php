<?php

require_once(__DIR__ . '/quick/FilesPacker.php');

$options = array(
    array('h',   'help',       0,      false,       'show help'),
    array('i',   'src',        1,      null,        'source files directory'),
    array('o',   'output',     1,      null,        'output filename | output directory'),
    array('p',   'path',     1,      '',          'upload file path'),
    array('t',   'type',     1,      null,          'file type'),
    array('xa',   'android',   1,      null,        'excluded android files'),
    array('xi',   'ios',   1,      null,        'excluded ios files'),
    array('xp',   'pc',   1,      null,        'excluded ios files'),
    array('ek',  'key',        1,      null,        'encrypt key'),
    array('es',  'sign',       1,      null,        'encrypt sign'),
    array('png',  'png',       1,      null,        'png zip'),
    array('ogg',  'ogg',       1,      null,        'mp3 -> ogg'),
    array('webp',  'webp',       1,      null,        'jpg -> webp'),
    array('jpg',  'jpg',       1,      null,        'jpg -> jpg'),
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

if ($config['path'])
{
    $configFilename = $config['path'] . '.list';
    if (file_exists($configFilename))
    {
        $config['upload'] = json_decode(file_get_contents($configFilename),true);
    }
    else
    {
        $config['upload'] = array();
    }
    $configFilename = $config['path'] . '_list.ver';
    if (file_exists($configFilename))
    {
        $config['upload_list'] = json_decode(file_get_contents($configFilename),true);
    }
    else
    {
        $config['upload_list'] = array();
    }
}
else
{
	$config['path'] = "uplocal.json";
}


$packer = new FilesPacker($config, $options);
if ($packer->validateConfig())
{
    return($packer->run());
}
else
{
    errorhelp();
    return(1);
}
