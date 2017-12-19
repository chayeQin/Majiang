<?php
ini_set ('memory_limit', '512M');
require_once(__DIR__ . '/init.php');
require_once(__DIR__ . '/xxtea.php');

class FilesPacker
{
    const ENCRYPT_XXTEA_DEFAULT_SIGN = 'XXTEA';

    private $config;
    private $options;
	private $hasNew = false;
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
            $excludes = array_filter($excludes, function($value) {
                return !empty($value);
            });
			$this->config['type'] = array();
			foreach($excludes as $key => $value)
			{
				$this->config['type'][$value] = true;
			}
        }
        else
        {
            $this->config['type'] = array();
        }
		
        if (!empty($this->config['android']))
        {
            $excludes = explode(',', $this->config['android']);
            array_walk($excludes, function($value) {
                return trim($value);
            });
            $excludes = array_filter($excludes, function($value) {
                return !empty($value);
            });
			$this->config['android'] = array();
			foreach($excludes as $key => $value)
			{
				$this->config['android'][$value] = true;
			}
        }
        else
        {
            $this->config['android'] = array();
        }
		
        if (!empty($this->config['ios']))
        {
            $excludes = explode(',', $this->config['ios']);
            array_walk($excludes, function($value) {
                return trim($value);
            });
            $excludes = array_filter($excludes, function($value) {
                return !empty($value);
            });
			$this->config['ios'] = array();
			foreach($excludes as $key => $value)
			{
				$this->config['ios'][$value] = true;
			}
        }
        else
        {
            $this->config['ios'] = array();
        }
		
        if (!empty($this->config['pc']))
        {
            $excludes = explode(',', $this->config['pc']);
            array_walk($excludes, function($value) {
                return trim($value);
            });
            $excludes = array_filter($excludes, function($value) {
                return !empty($value);
            });
			$this->config['pc'] = array();
			foreach($excludes as $key => $value)
			{
				$this->config['pc'][$value] = true;
			}
        }
        else
        {
            $this->config['pc'] = array();
        }

		if (empty($this->config['sign']))
		{
			$this->config['sign'] = self::ENCRYPT_XXTEA_DEFAULT_SIGN;
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

		$errorList = array();
        $files = $this->searchSourceFiles(1);
		foreach ($files as $key => $path)
		{
			$pos = strpos($path, ' ');
			if($pos !== false)
			{
				$errorList[] = $path;
			}
		}
		if (count($errorList) > 0)
		{
			print("ERR: error path!!\n");
			print("-------------start--------------\n");
			foreach ($errorList as $path)
			{
				print($path);
				print("\n");
			}
			print("-------------end---------------\n");
			return false;
		}
		
        $modules = $this->prepareForPack($files,1);

        $this->getModulesData($modules, count($modules),$this->config['key'], $this->config['sign']);

        if (!$this->createOutputFiles($modules))
        {
            $this->cleanupTempFiles($modules);
            return false;
        }

        $this->cleanupTempFiles($modules);
		
		if($this->hasNew)
		{
			// 删除文件
			foreach ($this->config["dels"] as $path => $data)
			{
				unset($this->config['upload'][$path]);
				$outPath = $this->config['output'] . DS . $path;
				if(file_exists($outPath))
				{
					printf("*** del %s\n",$path);
					unlink($outPath);
				}
			}
			
			$cfg_list = $this->config['upload_list'];// 上版本有文件
			$android = array();
			$ios = array();
			$pc = array();
			$list = array();
			
			foreach ($this->config['upload'] as $path => $data)
			{
				$pt=strrpos($path, ".");  
				if ($pt){
					$type = substr($path, $pt+1);
				}else{
					$type = "???";
				}
				
				$outPath = $this->config['output'] . DS . $path;
				if(!file_exists($outPath))
				{
					continue;
				}
				$list[$path] = $data;
				
				// 与上次发行版本时相同就过
				if($cfg_list[$path] === $data['md5'])
				{
					continue;
				}
				
				$out_data = array(
					'md5' => md5_file($outPath),
					'size' => filesize($outPath)
				);
				
				if(empty($this->config['android'][$type]))
				{
					$android[$path] = $out_data;
				}
				
				if(empty($this->config['ios'][$type]))
				{
					$ios[$path] = $out_data;
				}
				
				if(empty($this->config['pc'][$type]))
				{
					$pc[$path] = $out_data;
				}
			}

			file_put_contents($this->config['path'] . '.android',gzcompress(json_encode($android)));
			file_put_contents($this->config['path'] . '.ios',gzcompress(json_encode($ios)));
			file_put_contents($this->config['path'] . '.pc',gzcompress(json_encode($pc)));
			file_put_contents($this->config['path'] . '.list',json_encode($list));
		}
		printf("*** save upload file\n");
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

    protected function prepareForPack(array $files)
    {
        $modules = array();
        // prepare for pack
        foreach ($files as $key => $path)
        {
			$moduleName = substr($path, $this->config['srcpathLength']);
			$tempFilePath = $this->config['output'] . DS . $moduleName . '_tmp';
			$tmp = str_replace(DS, '.', $moduleName);
			$pt=strrpos($moduleName, ".");  
			if ($pt){
				$type = substr($moduleName, $pt+1);
			}else{
				$type = "???";
			}
			
			$isXXX = true;
			if(empty($this->config['type'][$type]))
			{
				$isXXX = false;
			}

			$module = array(
				'src' => $path,
				'moduleName' => $moduleName,
				'tempFilePath' => $tempFilePath,
				'isXXX' => $isXXX,
				'type' =>  $type,
				'copy' => true
			);
			
			// PNG
			if($type == 'png' && $this->config['png'])
			{
				$module['copy'] = false;
				$module['newName'] = substr($moduleName,0,$pt) . '.png';
				$module['newPath'] = $this->config['output'] . DS . $module['newName'];
				$module['newTemp'] = $module['newPath'] . '_tmp';
				$module['exec'] = 'copy ' . $path . ' ' . $module['newPath'] . ' && "' . $this->config['png'] . '" --force --ext .png ' . $module['newPath'];
			}
			else if($type == 'mp3' && $this->config['ogg'])
			{
				$module['newName'] = substr($moduleName,0,$pt) . '.ogg';
				$module['newPath'] = $this->config['output'] . DS . $module['newName'];
				$module['newTemp'] = $module['newPath'] . '_tmp';
				$module['exec'] = '"' . $this->config['ogg'] . '\lame.exe" --decode ' . $path . ' - | "' . $this->config['ogg'] . '\oggenc2.exe" - -q 1 -o ' . $module['newPath'];
			}
			else if($type == 'jpg' && $this->config['webp'])
			{
				$module['newName'] = substr($moduleName,0,$pt) . '.webp';
				$module['newPath'] = $this->config['output'] . DS . $module['newName'];
				$module['newTemp'] = $module['newPath'] . '_tmp';
				$module['exec'] = '"' . $this->config['webp'] . '" -q 50 ' . $path . ' -o ' . $module['newPath'];
			}
			else if($type == 'jpg' && $this->config['jpg'])
			{
				$module['copy'] = false;
				$module['newName'] = substr($moduleName,0,$pt) . '.jpg';
				$module['newPath'] = $this->config['output'] . DS . $module['newName'];
				$module['newTemp'] = $module['newPath'] . '_tmp';
				$module['exec'] = 'copy ' . $path . ' ' . $module['newPath'] . ' && "' . $this->config['jpg'] . '" -m 1 -q 7 -f ' . $module['newPath'];
			}
			$modules[] = $module;
        }
        return $modules;
    }

    protected function cleanupTempFiles(array $modules)
    {
        foreach ($modules as $module)
        {
            if (file_exists($module['tempFilePath']))
            {
                unlink($module['tempFilePath']);
            }
            if ($module['newTemp'] && file_exists($module['newTemp']))
            {
                unlink($module['newTemp']);
            }
        }
    }

    protected function getModulesData(array $modules,$count, $key = null, $sign = null)
    {
        if (!empty($key))
        {
            $xxtea = new XXTEA();
            $xxtea->setKey($key);
        }

		$i = 0;
		$cfg = $this->config['upload'];
		$dels = $this->config['upload'];//已经删除列表

        foreach ($modules as $module)
        {
			$i++;
			printf("*** check %d/%d\n",$i,$count);
			$fileKey = str_replace('/','\\',$module['moduleName']);
		
			$md5 = md5_file($module['src']);
		
			$ver = $cfg[$fileKey];
			if (!is_array($ver))
			{
				$ver = array();
			}

			// 源文件存在
			if($dels[$fileKey])
			{
				unset($dels[$fileKey]);
				
				// 如果这文件会产生新文件，同时新将新文件也从删除列表移除
				if($module['newName'])
				{
					unset($dels[str_replace('/','\\',$module['newName'])]);
				}
			}
			
			// 和上次打包跳过
			if($md5 === $ver['md5']) 
			{
				continue;
			}
			$ver['md5'] = $md5;
			
			$list = array();
			$list[] = array(
				'key' => $fileKey,
				'src' => $module['src'],
				'tmp' => $module['tempFilePath'],
				'copy' => $module['copy']
				);
					
			if($module['exec']) // ×ª»»PNG
			{
				printf("\n\n%s\n\n",$module['exec']);
				printf("*** update %s=>%s\n",$module['moduleName'],$module['newName']);
				@mkdir(pathinfo($module['newPath'], PATHINFO_DIRNAME), 0777, true);
				exec($module['exec']);
					
				$list[] = array(
					'key' => str_replace('/','\\',$module['newName']),
					'src' => $module['newPath'],
					'tmp' => $module['newTemp'],
					'copy' => true
					);
			}
			
			foreach($list as $file)
			{
				if($file['copy'])
				{
					$bytes = file_get_contents($file['src']);
					if (!empty($key) && $module['isXXX'])
					{
						$buf = $sign . $xxtea->encrypt($bytes);
						unset($bytes);
						$bytes = $buf;
					}
					@mkdir(pathinfo($file['tmp'], PATHINFO_DIRNAME), 0777, true);
					file_put_contents($file['tmp'], $bytes);
					if (!$bytes)
					{
						print("not bytes \n");
						return false;
					}
					$ver['size'] = ceil(strlen($bytes)/1024);
					unset($bytes);
				}else{
					$ver['size'] = 0;
				}
				$cfg[$file['key']] = $ver;
			}
			$this->hasNew = true;
        }
		$this->config["upload"] = $cfg;
		$this->config["dels"] = $dels;
		return true;
    }
	
    protected function createOutputFiles(array $modules)
    {
        foreach ($modules as $module)
        {
			if(file_exists($module['tempFilePath'])){
				$destPath = $this->config['output'] . DS . $module['moduleName'];
				rename($module['tempFilePath'], $destPath);
			}
			if($module['newTemp'] && file_exists($module['newTemp'])){
				rename($module['newTemp'], $module['newPath']);
			}
        }

        printf("create output files in %s .\n", $this->config['output']);
        print("done.\n\n");
        return true;
    }
}
