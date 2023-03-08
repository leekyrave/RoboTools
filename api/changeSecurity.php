<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['value'],$headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {
                if($data['value'] != $findToken->accept_security) {
                    $findToken->accept_security = $data['value'];
                    R::store($findToken);
                    $core->reportError($core::NO_ERROR,'');
                } else {
                    $core->reportError($core::ERROR_SECURITY_ALREADY_THIS,'');
                }
            } else {
                $core->reportError($core::ERROR_TIME_TOKEN_EXPIRES,'');
            }
        } else {
            $core->reportError($core::ERROR_UNREGISTERED_TOKEN,'');
        }
    } else {
        header('HTTP/1.0 403 Forbidden');
        die('Forbidden');
    }
}