<?php
require 'Slim/Slim.php';
# include_once ('libs-common/jwt-utils.php');

// error_reporting( ((E_ALL ^ E_NOTICE) ^ E_DEPRECATED ^  E_WARNING));
error_reporting(E_ALL);

\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim();

$app->get('/', function(){
  global $app;
  $app->response->setStatus(200);
  $app->response->headers->set('Content-Type', 'application/json');
  echo json_encode(array('desc'=>'ATM Akunting Endpoint'));
});
$app->get('/ping', function(){
  global $app;
  $app->response->setStatus(200);
  $app->response->headers->set('Content-Type', 'application/json');
  echo json_encode(array('ping'=>'OK'));
});

$app->run();