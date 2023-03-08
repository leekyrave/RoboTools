<?php

require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['secret'],$headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
    
        if($findToken) {
            if($findToken->expires_time >= time()) {
                    $findCheck = R::findone('changevk','login = ? AND secret = ?',[$findToken->login, $data['secret']]);
                    if($findCheck) {

                        if(time() - $findCheck->time <= 240)
                        {
                            $delete = R::load('changevk', $findCheck->id);
                            R::trash($delete);
    

                            $checkNewVK = R::findone('changenewvk', 'login = ?', [$findToken->login]);
                            if($checkNewVK) {
                                $delete = R::load('changenewvk', $findCheck->id);
                                R::trash($delete);
                            }
                            $accept_code = mt_rand(100000,999999);
                            $bufferCodes = R::dispense('changenewvk');
                            $bufferCodes->login = $findToken->login;
                            $bufferCodes->vk_id = $findToken->vk_id;
                            $bufferCodes->change = $findCheck->change;
                            $bufferCodes->secret = $accept_code;
                            $bufferCodes->time = time();
                            R::store($bufferCodes);
                            $vk->SendMessage($findCheck->change,"Используйте следующий код для привязки вашего VK. Если вы получили это сообщение случайно - проигнорируйте его.\n\nКод: $accept_code\n\nИнформация:\n— Логин: " . $findToken->login . "\n— Ник: " . $findToken->nick);
                            $core->reportError($core::NO_ERROR,'');
                        } else {
                            $core->reportError($core::ERROR_TIMEOUT_CODE,'time out');
                        }
                    } else {
                        $core->reportError($core::ERROR_BAD_CODE,'Unregistered Code');
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