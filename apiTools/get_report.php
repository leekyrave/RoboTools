<?php
require 'ApiCore.php';
header('Content-Type: application/json');
$core = new ApiCore();

$ipUser = $core->ipUser;
$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if(isset($_GET['question']) && isset($_GET['percent'], $headers['authorization']))
{
    $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    if($findToken) {
        if($findToken->expires_time >= time()) {
            $a = R::findall('reports');
            if($a)
            {
                $array = array('similars' => array());
                foreach ($a as $key => $value) {
                    similar_text($_GET['question'],$value['question'],$percent);
                    if($percent >= $_GET['percent'])
                    {
                        array_push($array['similars'],array('question' => $value['question'], 'answer' => $value['answer'], 'percent' => round($percent,1), 'server' => $value['server']));
                    }
                }
        
                function cmp_function_desc($a, $b){
                    return ($a['percent'] < $b['percent']);
                }
                if(count($array['similars']) > 0)
                {
                    usort($array['similars'], 'cmp_function_desc');
                    $array = array('error' => $core::NO_ERROR) + $array;
                } else {
                    $array = array('error' => $core::ERROR_NO_SIMILAR_REPORTS, 'description' => 'There are not similar reports.') + $array;
                }
                $json = json_encode($array, JSON_UNESCAPED_UNICODE);
                exit($json);
            } else {
                $core->reportError($core::ERROR_NO_SIMILAR_REPORTS,'');
            }        
        } else {
            $core->reportError($core::ERROR_TIME_TOKEN_EXPIRES,'');
        }
    
    } else {
        $core->reportError($core::ERROR_UNREGISTERED_TOKEN,'');
    }


} else {
    $core->reportError($core::ERROR_NOT_ALL_PARAMS,'');
}
