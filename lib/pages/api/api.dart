// port
const port = "8000";
// io
// const ip = "127.0.0.1";192.168.43.107,192.168.10.154
const String ip = "http://192.168.43.107";
// server check
const apiServer = "$ip:$port/api/users/server/";
// login
const apiLogin = "$ip:$port/api/users/login";

//phone check already
const apiCheckPhone = "$ip:$port/api/users/tell/";
//phone check already
const apiCreateUser = "$ip:$port/api/users";

// register all
const apiCreateAll = "$ip:$port/api/users/register";

// check mail
const apiCheckMail = "$ip:$port/api/users/";
//create card
const apiCreateCard = "$ip:$port/api/cards/create";
// show card
const apiShowCard = "$ip:$port/api/cards/show/";
// create notification
const apiGetNotiToken = "$ip:$port/api/cards/notification";
// create notification
const apiGetUserInfo = "$ip:$port/api/users/info/";
// his transfer
const apiHisTransfer = "$ip:$port/api/cards/history/trans";
// select card
const apiSelectCard = "$ip:$port/api/cards/select/";

// card received
const apiReceived = "$ip:$port/api/cards/rev_card";

// tran card
const apiTranCard = "$ip:$port/api/cards/tran_card";
//create card
const apiCreateTran = "$ip:$port/api/cards/create_tran";
// noti
const apiNoti = "https://fcm.googleapis.com/fcm/send";
// select token noti
const apiNotiToken = "$ip:$port/api/cards/select/noti/";
