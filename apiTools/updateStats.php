<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if($_SERVER['REQUEST_METHOD'] != 'OPTIONS') {
    if(isset($data['online_time'], $data['afk_time'], $data['reports'], $data['punishments'], $data['kicks'], $data['mutes'], $data['bans'], $data['warns'], $data['jails'], $data['reputation'], $data['token'], $headers['authorization'])) {
        $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);
        if($findToken) {
            if($findToken->expires_time >= time()) {
                $generateToken = md5($data['reports'] . $headers['authorization'] . $data['afk_time'] . $headers['authorization'] . $data['warns'] . $headers['authorization'] . $data['online_time'] . $headers['authorization'] . $data['bans'] . $headers['authorization'] . $data['punishments'] . $headers['authorization'] . $data['forms'] . $headers['authorization'] . $data['reputation'] . $headers['authorization'] . $data['jails'] . $headers['authorization'] . $data['mutes'] . $headers['authorization'] . $data['kicks'] . $headers['authorization']);
                if($generateToken == $data['token']) {
                    $findUser = R::findone('statisticusers', 'login = ?', [$findToken->login]);
                    $date = new DateTime();
                    $nowWeek = $date->format("W");
                    $nowDay = $date->format("N");
                    $nowYear = $date->format("Y");
                    if($findUser) {
                        $findUser->daily = json_encode(array(
                            'online_time' => $data['online_time'],
                            'afk_time' => $data['afk_time'],
                            'reports' => $data['reports'],
                            'punishments' => $data['punishments'],
                            'bans' => $data['bans'],
                            'warns' => $data['warns'],
                            'mutes' => $data['mutes'],
                            'kicks' => $data['kicks'],
                            'jails' => $data['jails'],
                            'reputation' => $data['reputation'],
                            'forms' => $data['forms'],
                        ));
                        $decodeDaily = json_decode($findUser->days_logs,true);
                        $isFinded = false;
                        foreach ($decodeDaily as $key => $value) {
                            if($value['week'] == $nowWeek && $value['dayWeek'] == $nowDay && $value['year'] == $nowYear) {
                                $isFinded = true;
                                $decodeDaily[$key]['timeUpdate'] = time();
                                $decodeDaily[$key]['data'] = array(
                                    'online_time' => $data['online_time'],
                                    'afk_time' => $data['afk_time'],
                                    'reports' => $data['reports'],
                                    'punishments' => $data['punishments'],
                                    'bans' => $data['bans'],
                                    'warns' => $data['warns'],
                                    'mutes' => $data['mutes'],
                                    'kicks' => $data['kicks'],
                                    'jails' => $data['jails'],
                                    'reputation' => $data['reputation'],
                                    'forms' => $data['forms'],
                                );
                                break;
                            }
                        }

                        if(!$isFinded) {
                            array_push($decodeDaily, array(
                                'week' => $nowWeek,
                                'dayWeek' => $nowDay,
                                'year' => $nowYear,
                                'timeUpdate' => time(), 
                                'data' => array(
                                    'online_time' => $data['online_time'],
                                    'afk_time' => $data['afk_time'],
                                    'reports' => $data['reports'],
                                    'punishments' => $data['punishments'],
                                    'bans' => $data['bans'],
                                    'warns' => $data['warns'],
                                    'mutes' => $data['mutes'],
                                    'kicks' => $data['kicks'],
                                    'jails' => $data['jails'],
                                    'reputation' => $data['reputation'],
                                    'forms' => $data['forms'],
                                )
                            ));
                        }

                        $findUser->days_logs = json_encode($decodeDaily);
                        $findUser->last_update = time();
                        R::store($findUser);
                        $core->reportError($core::NO_ERROR, '');
                    } else {
                        $cindUser = R::dispense('statisticusers');
                        $cindUser->login = $findToken->login;
                        $cindUser->daily = json_encode(array(
                            'online_time' => $data['online_time'],
                            'afk_time' => $data['afk_time'],
                            'reports' => $data['reports'],
                            'punishments' => $data['punishments'],
                            'bans' => $data['bans'],
                            'warns' => $data['warns'],
                            'mutes' => $data['mutes'],
                            'kicks' => $data['kicks'],
                            'jails' => $data['jails'],
                            'reputation' => $data['reputation'],
                            'forms' => $data['forms'],
                        ));
                        $cindUser->days_logs = json_encode(array(
                            array(
                                'week' => $nowWeek,
                                'dayWeek' => $nowDay,
                                'year' => $nowYear,
                                'timeUpdate' => time(), 
                                'data' => array(
                                    'online_time' => $data['online_time'],
                                    'afk_time' => $data['afk_time'],
                                    'reports' => $data['reports'],
                                    'punishments' => $data['punishments'],
                                    'bans' => $data['bans'],
                                    'warns' => $data['warns'],
                                    'mutes' => $data['mutes'],
                                    'kicks' => $data['kicks'],
                                    'jails' => $data['jails'],
                                    'reputation' => $data['reputation'],
                                    'forms' => $data['forms'],
                                )
                            )
                        ));
                        $cindUser->last_update = time();
                        R::store($cindUser);
                        $core->reportError($core::NO_ERROR, '');
                    }

                } else {
                    $core->reportError($core::ERROR_UNREGISTERED_TOKEN, '');
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
}