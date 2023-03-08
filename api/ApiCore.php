<?php
require 'db.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type, Authorization");
require_once('simplevk-master/autoload.php');
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);
const VK_KEY = "-";
const VERSION = "5.126";
use DigitalStar\vk_api\VK_api as vk_api; // Основной класс
$vk = vk_api::create(VK_KEY, VERSION);

class ApiCore
{
    public $ipUser;
    const NO_ERROR = 0;
    const ERROR_CANNOT_RECIEVE_IP = 1;
    const ERROR_BANNED_IP = 2;
    const ERROR_NOT_ALL_PARAMS = 3;
    const ERROR_INVALID_TOKEN = 4;
    const EROR_WRONG_PASSWORD = 5;
    const ERROR_NO_LOGIN = 6;
    const ERROR_NO_SIMILAR_REPORTS = 7;
    const ERROR_UNREGISTERED_TOKEN = 8;
    const ERROR_UNDEFINED_SERVER = 9;
    const ERROR_UNDEFINED_PROJECT = 10;
    const ERROR_PLAYER_WO_ORG = 11;
    const ERROR_UNACCEPTED_TOKEN = 12;
    const ERROR_NO_LEADERS = 13;
    const ERROR_NO_RECORDS = 14;
    const ERROR_LOGIN_EXIST = 15;
    const ERROR_EMAIL_EXIST = 16;
    const ERROR_NICK_EXIST = 17;
    const ERROR_VK_EXIST = 18;
    const ERROR_BAD_CODE = 19;
    const ERROR_TIMEOUT_CODE = 20;
    const ERROR_BAD_REFERER = 21;
    const ERROR_UNALLOWED_LENGTH = 22;
    const ERROR_UNCORRECT_VK = 23;
    const ERROR_UNCORRECT_EMAIL = 24;
    const ERROR_UNCORRECT_NICK = 25;
    const ERROR_UNCORRECT_LOGIN = 26;
    const ERROR_TIME_TOKEN_EXPIRES = 27;
    const ERROR_SEND_EMAIL = 28;
    const ERROR_SEND_VK = 29;
    const ERROR_UNDEFINED_ORG = 30;
    const ERROR_TOKEN_EXIST = 31;
    const ERROR_TOKEN_NOT_EXIST = 32;
    const ERROR_NICK_ALREADY_THIS = 33;
    const ERROR_NICK_RESERVED = 34;
    const ERROR_EMAIL_RESERVED = 35;
    const ERROR_EMAIL_ALREADY_THIS = 36;
    const ERROR_VK_RESERVED = 37;
    const ERROR_VK_ALREADY_THIS = 38;
    const ERROR_PASSWORD_ALREADY_THIS = 39;
    const ERROR_PASSWORD_UNCORRECT = 40;
    const ERROR_SECURITY_ALREADY_THIS = 41;
    const ERROR_SECURITY_UNDEFINED = 42;
    const ERROR_ANCET_EXIST = 43;
    const ERROR_REPORT_EXIST = 44;
    const ERROR_VK_ERROR_NO_CONTACT = 45;
    function __construct()
    {
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            $this->ipUser = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $this->ipUser = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } elseif (!empty($_SERVER['REMOTE_ADDR'])) {
            $this->ipUser = $_SERVER['REMOTE_ADDR'];
        }

        $this->ipUser = explode(",", $this->ipUser)[0];
        
        if(!$this->ipUser)
        {
            $array = array(
                'error' => self::ERROR_CANNOT_RECIEVE_IP,
                'description' => 'The server cannot receive your ip. Please turn off all applications that are blocking the receipt of the IP address.'
              );
              $json = json_encode($array, JSON_UNESCAPED_UNICODE);
              exit($json);
        }
    }

    public function checkRefer()
    {
        if(!preg_match('/robo\-tools\.online|localhost|a0602274/',$_SERVER['HTTP_REFERER'])) {
            $this->reportError(self::ERROR_BAD_REFERER,'');
        }
    }

    public function getServerName($number) {
        $serversname = array(
            'Phoenix',
            'Tucson',
            'Scottdale',
            'Chandler',
            'Brainburg',
            'Saintrose',
            'Mesa',
            'Red-Rock',
            'Yuma',
            'Surprise',
            'Prescott',
            'Glendale',
            'Kingman',
            'Winslow',
            'Payson', 
            'Gilbert',
            'Show-Low',
            'Casa-Grande',
            'Page',
            'Sun-City',
            'Queen-Creek',
            101 => 'Mobile-1',
            102 => 'Mobile-2',
            201 => "Vice-City"
          );

        return $serversname[$number];
    }

    public function isBlocked()
    {
        $banips = R::Findone('banips','ip = ?', [$this->ipUser]);
        if($banips)
        {
            $this->reportError(self::ERROR_BANNED_IP,'You are banned from this server. Date of receipt of the block: ' . $banips->time);
        }
    }

    public function reportError($error,$description)
    {
        exit(json_encode(array('error' => $error, 'description' => $description),JSON_UNESCAPED_UNICODE));
    }

}