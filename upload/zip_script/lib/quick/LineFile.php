<?php

require_once(__DIR__ . '/init.php');

class LineFile
{
    private $config;
    private $options;

    private $validated = false;

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
		
        if (!empty($this->config['type']))
        {
            $excludes = explode(',', $this->config['type']);
            array_walk($excludes, function($value) {
                return trim($value);
            });
            $this->config['type'] = array_filter($excludes, function($value) {
                return !empty($value);
            });
        }
        else
        {
            $this->config['type'] = array();
        }

        // check src path
        $srcpath = realpath($this->config['src']);
        if (!is_dir($srcpath))
        {
            printf("ERR: invalid src dir %s\n", $srcpath);
            return false;
        }
        $this->config['src'] = $srcpath;
        $this->config['srcpathLength'] = strlen($srcpath) + 1;

		$this->config['output'] = realpath($this->config['output']);
        $this->config['outpathLength'] = strlen($this->config['output']) + 1;
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

        $src_files = $this->searchSourceFiles('src');
		$src_md5 = array();
		$out_files = $this->searchSourceFiles('output');
		$out_md5 = $this->config['cfg'];

		// 查找源目录
		$src_md5_map = array();
		$src_path_map = array();
		foreach ($src_files as $key => $path)
        {
			$pathKey = substr($path, $this->config['srcpathLength']);
			$md5 = md5_file($path);
			$src_md5_map[$md5] = $pathKey;
			$src_path_map[$pathKey] = $md5;
		}
		
		// 生成输出目录所有文件MD5值，并以md5作KEY生成一份索引
		$i = 0;
		$count = count($out_files);
		$not_lines = array();
		foreach ($out_files as $key => $path)
        {
			$pathKey = substr($path, $this->config['outpathLength']);
			$md5File = $out_md5[$pathKey];
			if(!$md5File)
			{
				$md5File = array('md5' => md5_file($path));
			}
			
			if($md5File['src'])
			{
				$src = urldecode($md5File['src']);
				$srcPath = $this->config['src'] . DS . $src;
				if(file_exists($srcPath) && $src_path_map[$src])
				{
					if($src_path_map[$src] != $md5File['md5'])
					{
						$i++;
						printf("*** 关联更新(%d)：%s=>%s\n",$i,$src,$pathKey);
						$md5File['md5'] = $src_path_map[$src];
						$out_md5[$pathKey] = $md5File;
						copy($srcPath,$path);
					}
					continue;
				}
			}
			
			$file = $src_md5_map[$md5File['md5']];
			if($file)
			{
				$md5File['src'] = urlencode($file);
				$out_md5[$pathKey] = $md5File;
				continue;
			}
			
			$not_lines[] = $pathKey;
		}

		// 生成新的配置文件
		file_put_contents($this->config['path'] . '.cfg',json_encode($out_md5));
		
		// 未关联
		file_put_contents($this->config['path'] . '.notlines',implode("\n",$not_lines));

		print("*** save config file");
        return true;
    }

	// 查找指类文件类型
    protected function searchSourceFiles($name)
    {
        if (!$this->config['quiet'])
        {
            printf("Pack source files in path %s\n", $this->config['srcpath']);
        }
        $files = array();
        findFiles($this->config[$name], $files);
		
		$result = array();
		$checkTypes = count($this->config['type']) > 0;
		foreach ($files as $key => $path)
        {
			$pt=strrpos($path, ".");  
			if ($pt){
				$type = substr($path, $pt+1);
			}else{
				$type = "???";
			}
			
			$isRemove = false;
			if(checkTypes)
			{
				$isRemove = true;
				foreach ($this->config['type'] as $key => $exclude)
				{
					if ($type == $exclude)
					{
						$isRemove = false;
						break;
					}
				}
			}
			
			if(!$isRemove)
			{
				$result[] = $path;
			}
        }

        return $result;
    }
}
