<?php
ini_set ('memory_limit', '512M');
require_once(__DIR__ . '/init.php');

class FilesPackerList
{

    private $config;
    private $options;

    function __construct($config, $options)
    {
        $this->config = $config;
        $this->options = $options;
    }

    function validateConfig()
    {
        if (empty($this->config['src']))
        {
            printf("ERR: not specifies source files directory\n");
            return false;
        }

        if (empty($this->config['output']))
        {
            printf("ERR: not output filename or output directory\n");
            return false;
        }
		
		if (!empty($this->config['trans']))
        {
            $excludes = explode(',', $this->config['trans']);
            array_walk($excludes, function($value) {
                return trim($value);
            });
            $excludes = array_filter($excludes, function($value) {
                return !empty($value);
            });
			$this->config['trans'] = array();
			for($i = count($excludes) - 1 ; $i > 0  ; $i -= 2)
			{
				$key = $excludes[$i - 1];
				$value = $excludes[$i];
				$this->config['trans'][$key] = $value;
			}
        }
        else
        {
            $this->config['trans'] = array();
        }
		
		if (!empty($this->config['filter']))
        {
            $excludes = explode(',', $this->config['filter']);
            array_walk($excludes, function($value) {
                return trim($value);
            });
            $excludes = array_filter($excludes, function($value) {
                return !empty($value);
            });
			$this->config['filter'] = array();
			foreach($excludes as $key => $value)
			{
				$this->config['filter'][$value] = true;
			}
        }
        else
        {
            $this->config['filter'] = array();
        }
		
        if (!$this->config['quiet'])
        {
            dumpConfig($this->config, $this->options);
        }

        // check src path
        $srcpath = realpath($this->config['src']);
        if (!is_dir($srcpath))
        {
            printf("ERR: invalid src dir %s\n", $srcpath);
            return false;
        }
        $this->config['srcpath'] = $srcpath;
        $this->config['srcpathLength'] = strlen($srcpath) + 1;

        @mkdir($this->config['output'], 0777, true);
		$this->config['output'] = realpath($this->config['output']);
		if (empty($this->config['output']) || !is_dir($this->config['output']))
		{
			printf("ERR: invalid output dir %s\n", $this->config['output']);
			return false;
		}

        $this->validated = true;
        return true;
    }

    function run()
    {
        if (!$this->validated)
        {
            print("ERR: invalid config\n");
            return false;
        }

        $files = $this->searchSourceFiles();
        $modules = $this->createMd5List($files);
		$str = json_encode($modules);
		$path = $this->config['output'] . '\\' . $this->config['config'];
		printf("*** count %d\n\n",count($files));
		file_put_contents($path,$str);
		
        return true;
    }

    protected function searchSourceFiles()
    {
        if (!$this->config['quiet'])
        {
            printf("Pack source files in path %s\n", $this->config['srcpath']);
        }
        $files = array();
        findFiles($this->config['srcpath'], $files);
        return $files;
    }

    protected function createMd5List(array $files)
    {
		$filter = $this->config['filter'];
		$trans = $this->config['trans'];
        $modules = array();
        // prepare for pack
        foreach ($files as $key => $path)
        {
			$moduleName = substr($path, $this->config['srcpathLength']);
			$fileKey = str_replace('/','\\',$moduleName);
			
			$pt=strrpos($fileKey, ".");  
			$type = substr($fileKey, $pt+1);
			
			if($filter[$type])
			{
				continue;
			}
			
			$md5 = md5_file($path);
			$modules[$fileKey] = $md5;
			
			if (!$pt){
				continue;
			}
			if (!$trans[$type])
			{
				continue;
			}
			$newName = substr($fileKey,0,$pt) . '.' . $trans[$type];
			$modules[$newName] = $md5;
        }
        return $modules;
    }
}
