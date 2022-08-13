//复用
function geb($i){return document.getElementById($i)}



function _1(){
	//输入数据
	var $oldConfig = geb('oldConfigInput').value.split(/[(\r\n)\r\n]+/); //根据换行转换为数组
	var $newConfig = geb('newConfigInput').value; //直接输入
	//独占一行的注释
	var $outErr = '';
	
	//遍历旧配置数组
	var $length = $oldConfig.length;
	for(var $i = 0;    $i < $length;    $i++){
		var $old = $oldConfig[$i];
		
		//如果存在 "#"
		if($old.indexOf('#') !== -1){
			//截取第一个 "#" 前面的字符. 删除首尾空格
			var $old_c = $old.substring(0, $old.indexOf('#')).replace(/(^\s*)|(\s*$)/g, '');
			//截取第一个 "#" 及后面的字符
			var $old_n = $old.substring($old.indexOf('#'));
			
			if($old_c !== ''){
				//将新配置中的一行配置替换为旧配置+注释
				$newConfig = $newConfig.replace($old_c, $old_c +' '+ $old_n);
			}else{
				//错误输出
				$outErr += '    '+ $old_n +"\r\n";
			}
		}
	} //FOR结束//
	
	//输出 outConfigInput
	//独占一行的注释
	if($outErr !== '') $outErr = "#这些注释独占一行: \r\n"+ $outErr +"\r\n\r\n";
	//输出到输入框
	geb('outConfigInput').value = $outErr + $newConfig;
	
	
	//在新配置中查找没有注释的配置
	geb('outConfigInput_noNote').value = '';
	var $newConfig = $newConfig.split(/[(\r\n)\r\n]+/); //将转换过的新配置写入数组
	var $length = $newConfig.length;
	for(var $i = 0;    $i < $length;    $i++){
		var $new_c = $newConfig[$i];
		
		//如果不存在 "#" 同时 不存在中文
		if($new_c.indexOf('#') === -1 && /.*[\u4e00-\u9fa5]+.*$/.test($new_c) === false){
			geb('outConfigInput_noNote').value += $new_c +"\r\n";
		}
	}
	
	
	//在新配置中消失的旧配置
	
	
	geb('_1status').innerHTML = '状态: 转换完成';
};



_2(true);
function _2($m){
	//防报错
	try{
		if($m === true){ //压缩
			var $i = geb('JSONInput').value;
			
			//删除注释
			var $reg = /("([^\\\"]*(\\.)?)*")|('([^\\\']*(\\.)?)*')|(\/{2,}.*?(\r|\n))|(\/\*(\n|.)*?\*\/)/g;
			var $i = $i.replace($reg, function($n){return /^\/{2,}/.test($n) || /^\/\*/.test($n) ? "" : $n});
			
			geb('outJSONInput').value = JSON.stringify(JSON.parse($i));
		}else{ //格式化
			var $i = geb('outJSONInput').value;
			var $i = JSON.parse($i); //字符串转对象
			geb('JSONInput').value = JSON.stringify($i, null, 4); //对象转字符串
		}
		geb('_2status').innerHTML = '状态: 转换完成';
	}
	catch(err){geb('_2status').innerHTML = '错误: '+ err.message} //输出错误
	finally{}
}





